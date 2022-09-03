#include "TcpClient.h"
#include "UnrealNetPrivatePCH.h"
#include "SocketSubsystem.h"
#include "Misc/ScopeLock.h"

TcpClient::TcpClient()
{
	Reset();
}

TcpClient::~TcpClient()
{
	Reset();
}

void TcpClient::Reset()
{
	_uuid.Invalidate();
	_is_connected = false;
	{
		FScopeLock Lock(&_send_lock);
		_send_msg_queue.Empty();
	}
	{
		FScopeLock Lock(&_recv_lock);
		_recv_msg_queue.Empty();
	}
	_timespan = FTimespan::FromSeconds(5.0);
	_last_recv_time = FDateTime::UtcNow();
	_connect_state = ENetConnectionState::Invalid;
	_is_update_connect_state = false;
}

bool TcpClient::OpenSocket()
{
	CloseSocket();
	_uuid = FGuid::NewGuid();
	_socket = MakeShareable(ISocketSubsystem::Get(PLATFORM_SOCKETSUBSYSTEM)->CreateSocket(NAME_Stream, TEXT("default"), false), [](FSocket* inSocket) {
		//ISocketSubsystem::Get(PLATFORM_SOCKETSUBSYSTEM)->DestroySocket(inSocket); SOCKET 有泄漏，待解决
	});
	if (!_socket.IsValid())
	{
		UE_LOG(LogUnrealNet, Error, TEXT("Create Socket Failed!"));
		return false;
	}
    UE_LOG(LogUnrealNet, Log, TEXT("create Socket success! %x"),(uint64)(&(*_socket.Get())));
	_socket->SetNonBlocking();
	return true;
}

void TcpClient::CloseSocket()
{
	if (_socket.IsValid())
	{
		//_socket->Close(); DestroySocket will call close 2020-9-18 14:59 YYC
		ISocketSubsystem::Get(PLATFORM_SOCKETSUBSYSTEM)->DestroySocket(_socket.Get());
        UE_LOG(LogUnrealNet, Log, TEXT("Close Socket! %x"),(uint64)(&(*_socket.Get())));
		_socket.Reset();
	}
	Reset();
}
void TcpClient::CheckConnect()
{
    if (_TCPConnectCalled && _socket.IsValid())
    {
        _is_connected = _socket->GetConnectionState() == ESocketConnectionState::SCS_Connected;
    }
}

bool TcpClient::Connect(const char* host, const int port)
{
	FIPv4Address ip;
	FIPv4Address::Parse(host, ip);

	TSharedRef<FInternetAddr> addr = ISocketSubsystem::Get(PLATFORM_SOCKETSUBSYSTEM)->CreateInternetAddr();
	addr->SetIp(ip.Value);
	addr->SetPort(port);

	_TCPConnectCalled = _socket->Connect(*addr);
	if (!_TCPConnectCalled)
	{
		ESocketErrors LastErr = ISocketSubsystem::Get(PLATFORM_SOCKETSUBSYSTEM)->GetLastErrorCode();

		if (LastErr == SE_EINPROGRESS || LastErr == SE_EWOULDBLOCK)
		{
			//_TCPConnectCalled = true;
		}
		else
		{
			UE_LOG(LogUnrealNet, Log, TEXT("Connect failed with error code (%d) error (%s)"), LastErr, ISocketSubsystem::Get(PLATFORM_SOCKETSUBSYSTEM)->GetSocketError(LastErr));
		}
	}

	if (_TCPConnectCalled)
	{
		UE_LOG(LogUnrealNet, Log, TEXT("Opening connection to %s (localport: %d)"), *FString(host), port);
		_last_recv_time = FDateTime::UtcNow();
		return true;
	}
	ISocketSubsystem::Get(PLATFORM_SOCKETSUBSYSTEM)->DestroySocket(_socket.Get());
	UE_LOG(LogUnrealNet, Error, TEXT("Failed connect to %s (localport: %d)"), *FString(host), port);
	return false;
}

int32 TcpClient::SendToNet()
{
	if (!IsConnected())
	{
		return int32(0);
	}
	array_uint8_t msg = {};
	{
		FScopeLock Lock(&_send_lock);
		if (_send_msg_queue.IsEmpty())
		{
			return int32(0);
		}
		_send_msg_queue.Dequeue(msg);
	}

	int32 send_size = { 0 };
	_socket->Send(msg.GetData(), msg.Num(), send_size);
	if (send_size <= 0)
	{
		UE_LOG(LogUnrealNet, Warning, TEXT("Network has a problem for send! Send data's length = %d"), send_size);
		return -1;
	}

	return send_size;
}

int32 TcpClient::RecvFromNet()
{
	uint32 recv_size = { 0 };
	if (!IsConnected() )
	{
		return int32(0);
	}
    
    if(!_socket->HasPendingData(recv_size))
    {
       return int32(0);
    }
    
	array_uint8_t recv_data;
	recv_data.Init(0, recv_size);
	int32 read_size = { 0 };
	_socket->Recv(recv_data.GetData(), recv_data.Num(), read_size);
	if (read_size <= 0)
	{
		return int32(0);
	}
	{
		FScopeLock Lock(&_recv_lock);
		_recv_msg_queue.Append(recv_data);
	}

	_last_recv_time = FDateTime::UtcNow();

	return recv_size;
}

void TcpClient::Send(array_uint8_t msg)
{
	FScopeLock Lock(&_send_lock);
	_send_msg_queue.Enqueue(msg);
}

template<typename Callback>
inline void TcpClient::Recv(Callback OnRecv)
{
	FScopeLock Lock(&_recv_lock);
	if (_recv_msg_queue.Num() <= 0)
	{
		return;
	}
	OnRecv(_recv_msg_queue);
}

bool TcpClient::IsConnected()
{
	return _is_connected;
}
