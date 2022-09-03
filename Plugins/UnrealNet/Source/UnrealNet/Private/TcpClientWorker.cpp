#include "TcpClientWorker.h"
#include "ByteOrder.h"
#include "UnrealNetPrivatePCH.h"
#include "SymmetricCrypto.h"
#include "Cryptography.h"

const FTimespan TcpClientWorker::_PingTimespan = FTimespan::FromSeconds(1.0);

template<typename Func1, typename Func2, typename Func3, typename Func4>
TcpClientWorker::TcpClientWorker(Func1 OnConnect, Func2 OnClose, Func3 OnRecv, Func4 OnRecvTestPing)
{
	_OnConnect = OnConnect;
	_OnClose = OnClose;
	_OnRecv = OnRecv;
	_OnRecvTestPing = OnRecvTestPing;

	_tcp_clients.clear();
	_bRun = true;
	_thread = TSharedPtr<FRunnableThread>(FRunnableThread::Create(this, TEXT("TcpClientWorker"), 128 * 1024, TPri_Normal), [](FRunnableThread* InThread)
	{
		if (InThread != nullptr)
		{
			InThread->WaitForCompletion();
			delete InThread;
			InThread = nullptr;
		}
	});
}

template<typename callback>
void TcpClientWorker::ErgodicAllClients(callback cb)
{
	FScopeLock Lock(&_tcp_client_mutex);
	TArray<int> _tcp_clients_all_keys;
	for (auto it : _tcp_clients)
	{
		_tcp_clients_all_keys.Add(it.first);
	}
	while (_tcp_clients_all_keys.Num() > 0)
	{
		auto connect_id = _tcp_clients_all_keys[0];
		_tcp_clients_all_keys.Remove(connect_id);
		auto it = _tcp_clients.find(connect_id);
		if (it == _tcp_clients.end())
			continue;
		cb(it->first, it->second);
	}
}

TcpClientWorker::~TcpClientWorker()
{
	//FScopeLock Lock(&_tcp_client_mutex);
	_tcp_clients.clear();
	//_tcp_client_lock.unlock();
	Stop();
}

int32 TcpClientWorker::CreateClient()
{
	int32 connect_id = GetConnectId();
	std::shared_ptr<TcpClient> client = std::make_shared<TcpClient>();
	client->OpenSocket();
	{
		FScopeLock Lock(&_tcp_client_mutex);
		//_tcp_client_lock.lock();
		_tcp_clients.insert(std::pair<int, std::shared_ptr<TcpClient>>(connect_id, client));
		//_tcp_client_lock.unlock();
	}
	//UE_LOG(LogUnrealNet, Log, TEXT("Create Client Socket Success!!! connect_id = %d"), connect_id);
	return connect_id;
}

void TcpClientWorker::Connect(int32 connect_id, const char* host, const int port)
{
	FScopeLock Lock(&_tcp_client_mutex);
	auto client = _tcp_clients.find(connect_id);
	if (client == _tcp_clients.end())
	{
		UE_LOG(LogUnrealNet, Error, TEXT("Do not find Client socket for connect_id = %d"), connect_id);
		return;
	}

	SetNetConnectionState(connect_id, ENetConnectionState::Connecting);
	if (!client->second->Connect(host, port))
	{
		UE_LOG(LogUnrealNet, Error, TEXT("Connect failed!!! connect_id = %d"), connect_id);
		return;
	}
}

void TcpClientWorker::Close(int connect_id)
{
	//UE_LOG(LogUnrealNet, Log, TEXT("Try Close Net!!! connect_id = %d"), connect_id);
	//_tcp_client_lock.lock();
	FScopeLock Lock(&_tcp_client_mutex);
	auto it = _tcp_clients.find(connect_id);
	if (it != _tcp_clients.end())
	{
		it->second->CloseSocket();
		_OnClose(it->first);
		_tcp_clients.erase(it); // YYC: cannot erase directly, cause crash! 2020-8-27 10:49:11
	}
	//_tcp_client_lock.unlock();
}

void TcpClientWorker::Clean()
{
	FScopeLock Lock(&_tcp_client_mutex);
	for (auto it : _tcp_clients)
	{
		it.second->CloseSocket();
		_OnClose(it.first);
	}
	_tcp_clients.clear();
}


void TcpClientWorker::SendMessage(int connect_id, uint32 msg_type, array_uint8_t msg, bool enc)
{
	FScopeLock Lock(&_tcp_client_mutex);
	auto it = _tcp_clients.find(connect_id);
	if (it != _tcp_clients.end())
	{
		array_uint8_t encode_msg;
		Encode(msg_type, msg, encode_msg, enc);
		it->second->Send(encode_msg);
	}
}

void TcpClientWorker::RecvMessage()
{
	//_tcp_client_lock.lock_shared();
	ErgodicAllClients([this](int32 connect_id, std::shared_ptr<TcpClient> client) {
		client->Recv([this, connect_id, client](array_uint8_t& recv_message) {
			if (recv_message.Num() <= 0)
				return;
			uint32 msg_type;
			array_uint8_t decode_msg;
			bool isInternalMsg = false;
			while (Decode(recv_message, msg_type, decode_msg, isInternalMsg))
			{
				if (!isInternalMsg)
				{
					_OnRecv(connect_id, msg_type, decode_msg);
				}
				else
				{
					auto internalType = FByteOrder::Get8(decode_msg.GetData(), 0);
					auto internalData = FByteOrder::GetBE16(decode_msg.GetData() + 1);
					OnReceiveInternalMessage(connect_id, internalType, internalData);
				}
				msg_type = 0;
				decode_msg.Empty();
				isInternalMsg = false;
			}
		});
	});
	//_tcp_client_lock.unlock_shared();
}

void TcpClientWorker::UpdateConnectionStatus()
{
	//_tcp_client_lock.lock_shared();
	ErgodicAllClients([this](int32 connect_id, std::shared_ptr<TcpClient> client) {
		if (client->GetIsUpdateConnectState())
		{
			client->SetIsUpdateConnectState(false);
			_OnConnect(connect_id, (uint8)client->GetConnectState());
		}
	});
}

void TcpClientWorker::SetConnectionDeadTimespan(int32 connect_id, FTimespan timespan)
{
	FScopeLock Lock(&_tcp_client_mutex);
	auto it = _tcp_clients.find(connect_id);
	if (it != _tcp_clients.end())
	{
		it->second->SetConnectionDeadTimespan(timespan);
	}
}

void TcpClientWorker::SendKeyMessage(int32 connect_id)
{
	// �������״̬
	if (GetNetConnectionState(connect_id) != ENetConnectionState::Connecting)
	{
		return;
	}

	// ���ɶԳ���Կ
	auto key = FCryptography::CreateSymmetricCryptoKey(ESymmetricCrypto::ChaCha20, 0);

	// �����Կ
	array_uint8_t msg;
	msg.Append(key.GetKey());
	msg.Append(key.GetIV());

	// �÷�����˽Կ������Կ
	auto rsa_enc = FCryptography::CreateEncryption(EAsymmetricCrypto::RSA, _RemotePublicKey);
	array_uint8_t enc_msg;
	rsa_enc->EncryptData(msg, enc_msg);

	// ���ɼ��ܽ�����
	_Enc = FCryptography::CreateEncryption(ESymmetricCrypto::ChaCha20, key);
	_Dec = FCryptography::CreateDecryption(ESymmetricCrypto::ChaCha20, key);

	// ����Կ���͸�������
	SendMessage(connect_id, 0, enc_msg, false);
}

void TcpClientWorker::OnGetKeysMessage(int32 connect_id, uint16 msg)
{
	SendKeyMessage(connect_id);
	SetNetConnectionState(connect_id, ENetConnectionState::Connected);
}

void TcpClientWorker::SendTestPing(int32 connect_id, std::shared_ptr<TcpClient> client)
{
	// �鿴����״̬
	if (client->GetConnectState() != ENetConnectionState::Connected)
	{
		return;
	}

	// �鿴����ʱ��
	const FDateTime DateTimeNow = FDateTime::UtcNow();
	if (DateTimeNow - _HeartBeatTimestamp < _PingTimespan)
	{
		return;
	}

	// ����ʱ��
	_HeartBeatTimestamp = DateTimeNow;

	// ����testping
	SendInternalMsg(client, (uint8)EMessageType_Internal::MT_Ping, 0);
}

void TcpClientWorker::OnTestPing(int32 connect_id, uint16 msg)
{
	const uint32 PingInMS = static_cast<uint32>(FMath::Max(0.0, (FDateTime::UtcNow() - _HeartBeatTimestamp).GetTotalMilliseconds()));

	FScopeLock Lock(&_tcp_client_mutex);
	auto client = _tcp_clients.find(connect_id);
	if (client != _tcp_clients.end())
	{
		_OnRecvTestPing(connect_id, PingInMS);
	}
}

void TcpClientWorker::SetNetConnectionState(int32 connect_id, ENetConnectionState ConnectionState)
{
	{
		FScopeLock Lock(&_tcp_client_mutex);
		//_connect_state_lock.lock();
		auto client = _tcp_clients.find(connect_id);
		if (client != _tcp_clients.end())
		{
			client->second->SetConnectState(ConnectionState);
			client->second->SetIsUpdateConnectState(true);
		}
	}
}

ENetConnectionState TcpClientWorker::GetNetConnectionState(int32 connect_id)
{
	//_connect_state_lock.lock_shared();		
	FScopeLock Lock(&_tcp_client_mutex);

	auto client = _tcp_clients.find(connect_id);
	if (client != _tcp_clients.end())
	{
		return client->second->GetConnectState();
	}
	return ENetConnectionState(ENetConnectionState::Invalid);
}

void TcpClientWorker::SendInternalMsg(std::shared_ptr<TcpClient> client, uint8 msg_type, uint16 data)
{
	array_uint8_t msg;
	msg.InsertZeroed(0, 6);
	FByteOrder::SetBE16(msg.GetData(), 3);
	FByteOrder::SetBE16(msg.GetData() + sizeof(uint16), 0);
	FByteOrder::Set8(msg.GetData(), 3, msg_type);
	FByteOrder::SetBE16(msg.GetData() + 4, data);
	client->Send(msg);
}

void TcpClientWorker::OnReceiveInternalMessage(int32 connect_id, uint8 msg_type, uint16 msg)
{
	switch (static_cast<EMessageType_Internal>(msg_type))
	{
	case EMessageType_Internal::MT_GetPassword:
		OnGetKeysMessage(connect_id, msg);
		break;
	case EMessageType_Internal::MT_Ping:
		OnTestPing(connect_id, msg);
		break;
	default:
		UE_LOG(LogUnrealNet, Error, TEXT("Invalid internal message type %u, drop message"), msg_type);
		break;
	}
}

bool TcpClientWorker::Init()
{
	return true;;
}

uint32 TcpClientWorker::Run()
{
	//try
	//{
	while (_bRun)
	{
		Tick();
		FPlatformProcess::Sleep(0.005f);
	}
	//}
	//catch (std::exception & e)
	//{
	//	UE_LOG(LogUnrealNet, Error, _TEXT("%s"), e.what());
	//	return uint32(0);
	//}
	return uint32(0);
}

void TcpClientWorker::Stop()
{
	_bRun = false;
}

void TcpClientWorker::Exit()
{
}

void TcpClientWorker::Tick()
{
	//_tcp_client_lock.lock_shared();
	ErgodicAllClients([this](int32 connect_id, std::shared_ptr<TcpClient> client) {
		if (client->GetConnectState() == ENetConnectionState::Connecting)
		{
			if (FDateTime::UtcNow() - client->GetLastRecvTime() >= client->GetConnectionDeadTimespan())
			{
				SetNetConnectionState(connect_id, ENetConnectionState::Disconnected);
				return;
			}
		}

		client->CheckConnect();
		client->RecvFromNet();
		if (client->SendToNet() < 0)
		{
			SetNetConnectionState(connect_id, ENetConnectionState::Disconnected);
		}
		SendTestPing(connect_id, client);
	});
	//_tcp_client_lock.unlock_shared();
}

FSingleThreadRunnable* TcpClientWorker::GetSingleThreadInterface()
{
	return this;
}

int32 TcpClientWorker::GetConnectId()
{
	static int32 i = 1;
	return i++;
}
//
//bool TcpClientWorker::ConstructProtocolStack(int32 connect_id)
//{
//	//do
//	//{
//	//	_ProtocolStack.Empty(4);
//	//	TArray<TSharedPtr<INetStackFrame>> ProtocolStack;
//	//	if (GetNetConnectionState(connect_id) == ENetConnectionState::Connected)
//	//	{
//	//		if (_SymmetricCryptoKey.IsValid())
//	//		{
//	//			ProtocolStack.Add(MakeShared<FZipperStackFrame>(_ZipDictionary));
//	//			ProtocolStack.Add(MakeShared<FPrivateHeaderStackFrame>(1, 1, true));
//	//			ProtocolStack.Add(MakeShared<FSymmetricCryptoStackFrame>(ESymmetricCrypto::AES, _SymmetricCryptoKey));
//	//			ProtocolStack.Add(MakeShared<FPublicHeaderStackFrame>());
//	//		}
//	//		else
//	//		{
//	//			UE_LOG(LogUnrealNet, Error, TEXT("ConstructProtocolStack Connected CryptoKey is not valid"));
//	//			break;
//	//		}
//	//	}
//	//	else
//	//	{
//	//		if (_RemotePublicKey.IsValid() && _AsymmetricKeyPair.IsValid())
//	//		{
//	//			ProtocolStack.Add(MakeShared<FZipperStackFrame>(_ZipDictionary));
//	//			ProtocolStack.Add(MakeShared<FPrivateHeaderStackFrame>(1, 1, false));
//	//			ProtocolStack.Add(MakeShared<FAsymmetricCryptoStackFrame>(EAsymmetricCrypto::RSA, _RemotePublicKey, _AsymmetricKeyPair.GetPrivateKey()));
//	//			ProtocolStack.Add(MakeShared<FPublicHeaderStackFrame>());
//	//		}
//	//		else
//	//		{
//	//			UE_LOG(LogUnrealNet, Error, TEXT("ConstructProtocolStack Client Connecting CryptoKey is not valid"));
//	//			break;
//	//		}
//	//	}
//	//	_ProtocolStack = ProtocolStack;
//	//	return true;
//	//} while (false);
//	//return false;
//}

void TcpClientWorker::Encode(uint32 msg_type, array_uint8_t msg, array_uint8_t& encode_msg, bool enc)
{
#define HEADER_SIZE sizeof(uint16) + sizeof(uint8) + sizeof(uint32)

	uint8 header[HEADER_SIZE];

	auto size = msg.Num() + sizeof(uint32);

	auto s = uint16(size & 0xFFFF);
	auto c = uint8(size >> 16);

	if (!FByteOrder::IsHostBigEndian()) {
		s = FByteOrder::HostToNetwork16(s);
		msg_type = FByteOrder::HostToNetwork32(msg_type);
	}

	memcpy(header, &s, sizeof(uint16));
	memcpy(header + sizeof(uint16), &c, sizeof(uint8));
	memcpy(header + sizeof(uint16) + sizeof(uint8), &msg_type, sizeof(uint32));

	encode_msg.Empty();

	encode_msg.Append(header, HEADER_SIZE);

	if (enc && _Enc) {
		_Enc->EncryptData(msg, msg);
	}

	encode_msg.Append(msg);
}

bool TcpClientWorker::Decode(array_uint8_t& msg, uint32& msg_type, array_uint8_t& decode_msg, bool& isInternalMsg)
{
	auto size_size = sizeof(uint16) + sizeof(uint8);

	auto msg_size = msg.Num();
	if (msg_size < size_size) {
		return false;
	}

	auto data = msg.GetData();

	size_t size = FByteOrder::GetBE16(data);

	size_t count = FByteOrder::Get8(data, sizeof(uint16));

	size = (count << 16) | size;

	switch (size)
	{
	case 0: break;
	case 3:
	case 2:
	case 1: {

		if (msg_size < size + size_size) {
			return false;
		}
		isInternalMsg = true;
		decode_msg.Empty();
		decode_msg.Append(data + size_size, size);
	}break;
	default:
	{
		if (msg_size < size + size_size) {
			return false;
		}

		msg_type = FByteOrder::GetBE32(data + size_size);

		if (msg_type == 0) {
			UE_LOG(LogUnrealNet, Error, TEXT("%s"), data);
		}

		decode_msg.Empty();
		decode_msg.Append(data + size_size + sizeof(uint32), size - sizeof(uint32));

		if (_Dec) {
			_Dec->DecryptData(decode_msg, decode_msg);
		}
	}break;
	}


	msg.RemoveAt(0, size + size_size);

	if (size == 0) {
		return false;
	}

	return true;
}
