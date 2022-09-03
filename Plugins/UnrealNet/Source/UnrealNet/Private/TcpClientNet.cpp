#include "TcpClientNet.h"
#include "TcpClientWorker.h"
#include "Tickable.h"

class FUnrealNet final : public IUnrealNet, public FTickableGameObject
{
public:
	void StartupModule() override;
	void ShutdownModule() override;

	void SetConnectionDeadTimespan(int32 connect_id, FTimespan timespan) override;
	//void SetZipDictionary(const TArray<uint8>& InZipDictionary) override;
	void SetRemotePublicKey(const FAsymmetricPublicKey& InRemotePublicKey) override;
	void SetLocalPrivateKey(const FAsymmetricPrivateKey& InLocalPrivateKey) override;
	int32 CreateClient() override;
	void Connect(int32 connect_id, const char* host, const int port) override;
	void Close(int connect_id) override;
	void Clean() override;
	void SendMessage(int connect_id, uint32 msg_type, const uint8* msg, int32 msg_len) override;
	void SendMessage(int connect_id, uint32 msg_type, const TArray<uint8>& msg) override;

	// Begin FTickableGameObject interface
	virtual void Tick(float InDeltaSeconds) override;
	virtual ETickableTickType GetTickableTickType() const override { return ETickableTickType::Always; }
	virtual bool IsTickable() const override;
	virtual TStatId GetStatId() const override;
	virtual bool IsTickableWhenPaused() const override { return true; }
	virtual bool IsTickableInEditor() const override { return true; }
	// End FTickableGameObject interface

	DECLARE_DERIVED_EVENT(FUnrealNet, IUnrealNet::FOnConnect, FOnConnect)
	FOnConnect& GetOnConnect()
	{
		return _OnConnectEvent;
	}
	DECLARE_DERIVED_EVENT(FUnrealNet, IUnrealNet::FOnClose, FOnClose)
	FOnClose& GetOnClose()
	{
		return _OnCloseEvent;
	}
	DECLARE_DERIVED_EVENT(FUnrealNet, IUnrealNet::FOnRecv, FOnRecv)
	FOnRecv& GetOnRecv()
	{
		return _OnRecvEvent;
	}
	DECLARE_DERIVED_EVENT(FUnrealNet, IUnrealNet::FOnRecvTestPing, FOnRecvTestPing)
	FOnRecvTestPing& GetOnRecvTestPing()
	{
		return _OnRecvTestPingEvent;
	}
private:
	TUniquePtr<TcpClientWorker> _NetWorker;
	FOnConnect					_OnConnectEvent;
	FOnClose					_OnCloseEvent;
	FOnRecv						_OnRecvEvent;
	FOnRecvTestPing				_OnRecvTestPingEvent;
};

IMPLEMENT_MODULE(FUnrealNet, UnrealNet)

void FUnrealNet::StartupModule()
{
	_NetWorker = MakeUnique<TcpClientWorker>(
		[this](int32 connect_id, uint8 status) {
			_OnConnectEvent.Broadcast(connect_id, status);
		},
		[this](int32 connect_id) {
			_OnCloseEvent.Broadcast(connect_id);
		},
		[this](int32 connect_id, uint32 msg_type, array_uint8_t msg) {
			_OnRecvEvent.Broadcast(connect_id, msg_type, msg);
		},
		[this](int32 connect_id, uint32 ping_in_ms) {
			_OnRecvTestPingEvent.Broadcast(connect_id, ping_in_ms);
		}
		);
}

void FUnrealNet::ShutdownModule()
{
	_NetWorker->Stop();
	_NetWorker.Reset();
}

void FUnrealNet::SetConnectionDeadTimespan(int32 connect_id, FTimespan timespan)
{
	_NetWorker->SetConnectionDeadTimespan(connect_id, timespan);
}

//void FUnrealNet::SetZipDictionary(const TArray<uint8>& InZipDictionary)
//{
//	_NetWorker->SetZipDictionary(InZipDictionary);
//}

void FUnrealNet::SetRemotePublicKey(const FAsymmetricPublicKey& InRemotePublicKey)
{
	_NetWorker->SetRemotePublicKey(InRemotePublicKey);
}

void FUnrealNet::SetLocalPrivateKey(const FAsymmetricPrivateKey& InLocalPrivateKey)
{
	_NetWorker->SetLocalPrivateKey(InLocalPrivateKey);
}


int32 FUnrealNet::CreateClient()
{
	return _NetWorker->CreateClient();
}

void FUnrealNet::Connect(int32 connect_id, const char* host, const int port)
{
	_NetWorker->Connect(connect_id, host, port);
}

void FUnrealNet::Close(int connect_id)
{
	_NetWorker->Close(connect_id);
}

void FUnrealNet::SendMessage(int connect_id, uint32 msg_type, const uint8* msg, int32 msg_len)
{
	TArray<uint8> message(msg, msg_len);
	_NetWorker->SendMessage(connect_id, msg_type, message);
}

void FUnrealNet::SendMessage(int connect_id, uint32 msg_type, const TArray<uint8>& msg)
{
	_NetWorker->SendMessage(connect_id, msg_type, msg);
}

void FUnrealNet::Tick(float InDeltaSeconds)
{
	_NetWorker->UpdateConnectionStatus();
	_NetWorker->RecvMessage();
}

bool FUnrealNet::IsTickable() const
{
	return _NetWorker.IsValid();
}

TStatId FUnrealNet::GetStatId() const
{
	RETURN_QUICK_DECLARE_CYCLE_STAT(FUnrealNet, STATGROUP_Tickables);
}

void FUnrealNet::Clean()
{
	_NetWorker->Clean();
}
