#pragma once

#include "TcpClient.h"
//#include "NetStackFrame.h"
#include "HAL/Runnable.h"
#include "HAL/RunnableThread.h"
#include "Misc/SingleThreadRunnable.h"
#include "NetChannel.h"
#include <shared_mutex>
#include <map>
#include <functional>
#include "SymmetricCrypto.h"

enum class EMessageType_Internal : uint32
{
	MT_Invalid,
	MT_Ping,
	MT_GetPassword,
};

class TcpClientWorker final : public FRunnable, FSingleThreadRunnable
{
public:
	template<typename Func1, typename Func2, typename Func3, typename Func4>
	TcpClientWorker(Func1 OnConnect, Func2 OnClose, Func3 OnRecv, Func4 OnRecvTestPing);
	~TcpClientWorker();

	/* net */
	int32	CreateClient();
	void	Connect(int32 connect_id, const char* host, const int port);
	void	Close(int connect_id);
	void	Clean();
	void	SendMessage(int connect_id, uint32 msg_type, array_uint8_t msg, bool enc = true);
	void	RecvMessage();
	void	UpdateConnectionStatus();
	void	SetConnectionDeadTimespan(int32 connect_id, FTimespan timespan);
	//void	SetZipDictionary(const array_uint8_t& InZipDictionary) { _ZipDictionary = InZipDictionary; }
	void	SetRemotePublicKey(const FAsymmetricPublicKey& InRemotePublicKey) { _RemotePublicKey = InRemotePublicKey; }
	void	SetLocalPrivateKey(const FAsymmetricPrivateKey& InLocalPrivateKey) { _LocalPrivateKey = InLocalPrivateKey; }

	/* thread */
	bool	Init() override;
	uint32	Run() override;
	void	Stop() override;
	void	Exit() override;
	void	Tick() override;
	FSingleThreadRunnable* GetSingleThreadInterface() override;

private:
	//bool	ConstructProtocolStack(int32 connect_id);
	//bool	IsValidProtocolStack() const { return false /*_ProtocolStack.Num() == 4*/; }
	void	Encode(uint32 msg_type, array_uint8_t msg, array_uint8_t& encode_msg, bool enc = false);
	bool	Decode(array_uint8_t& msg, uint32& msg_type, array_uint8_t& decode_msg, bool& isTestPing);
	void	OnReceiveInternalMessage(int32 connect_id, uint8 msg_type, uint16 msg);
	void	SendKeyMessage(int32 connect_id);
	void	OnGetKeysMessage(int32 connect_id, uint16 msg);
	void	SendTestPing(int32 connect_id, std::shared_ptr<TcpClient> client);
	void	OnTestPing(int32 connect_id, uint16 msg);
	int32	GetConnectId();
	void	SetNetConnectionState(int32 connect_id, ENetConnectionState ConnectionState);
	ENetConnectionState GetNetConnectionState(int32 connect_id);
	void	SendInternalMsg(std::shared_ptr<TcpClient> client, uint8 msg_type, uint16 data);
	static bool IsValidNetChannel(uint8 InNetChannel)
	{
		if (InNetChannel == static_cast<uint8>(ENetChannel::Control))
		{
			return true;
		}
		if (InNetChannel == static_cast<uint8>(ENetChannel::AboveNormal))
		{
			return true;
		}
		if (InNetChannel == static_cast<uint8>(ENetChannel::Normal))
		{
			return true;
		}
		if (InNetChannel == static_cast<uint8>(ENetChannel::BelowNormal))
		{
			return true;
		}
		return false;
	}

private:
	template<typename callback>
	void ErgodicAllClients(callback cb);

	/*thread*/
	volatile bool								_bRun = false;
	TSharedPtr<FRunnableThread>					_thread;

	/*network*/
	FCriticalSection							_tcp_client_mutex;
	FCriticalSection							_connect_state_mutex;
	std::map<int, std::shared_ptr<TcpClient>>	_tcp_clients;

	/*codes*/
	//TArray<TSharedPtr<INetStackFrame>>			_ProtocolStack;
	//array_uint8_t								_ZipDictionary;
	FAsymmetricPublicKey						_RemotePublicKey;
	FAsymmetricPrivateKey						_LocalPrivateKey;
	FAsymmetricKeyPair							_AsymmetricKeyPair;
	TSharedPtr<class FSymmetricEncryption>			_Enc;
	TSharedPtr<class FSymmetricDecryption>			_Dec;

	/*ping*/
	uint32										_PingInMS = 0;
	FDateTime									_HeartBeatTimestamp = FDateTime::UtcNow();
	const static FTimespan						_PingTimespan;

	/*server give*/
	uint32										_Mtu = 0;
	uint32										_ConversationID = 0;
	FSymmetricCryptoKey							_SymmetricCryptoKey;

	/*callback functions*/
	std::function<void(int32, uint8)>					_OnConnect;
	std::function<void(int32)>							_OnClose;
	std::function<void(int32, uint32, array_uint8_t)>	_OnRecv;
	std::function<void(int32, uint32)>					_OnRecvTestPing;
};
