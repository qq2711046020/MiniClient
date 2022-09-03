#pragma once

#include "Runtime/Networking/Public/Networking.h"
#include "Misc/Guid.h"
#include "Misc/DateTime.h"
#include "HAL/Platform.h"
#include "Sockets.h"
#include "NetConnectionState.h"

using array_uint8_t = TArray<uint8>;

class TcpClient
{
public:
	TcpClient();
	~TcpClient();
	void			Reset();
    void            CheckConnect();
	bool			OpenSocket();
	void			CloseSocket();
	bool			Connect(const char* host, const int port);
	int32			SendToNet();
	int32			RecvFromNet();
	void			Send(array_uint8_t msg);
	template<typename Callback>
	void			Recv(Callback OnRecv);

	FGuid			GetUuid() { return _uuid; };

	void			SetConnectionDeadTimespan(FTimespan timespan) { _timespan = timespan; };
	FTimespan		GetConnectionDeadTimespan() { return _timespan; };
	FDateTime		GetLastRecvTime() { return _last_recv_time; };

	void			SetConnectState(ENetConnectionState State) { _connect_state = State; }
	ENetConnectionState GetConnectState() { return _connect_state; }
	void			SetIsUpdateConnectState(bool is_update) { _is_update_connect_state = is_update; }
	bool			GetIsUpdateConnectState() { return _is_update_connect_state; }

private:
	bool			IsConnected();

	FGuid						_uuid;
	TSharedPtr<FSocket,ESPMode::ThreadSafe>		_socket;
	volatile bool				_is_connected = false;
	TQueue<array_uint8_t>		_send_msg_queue;
	array_uint8_t				_recv_msg_queue;
	FCriticalSection			_send_lock;
	FCriticalSection			_recv_lock;
    bool                        _TCPConnectCalled = false;
	FTimespan					_timespan = FTimespan::FromSeconds(5.0);
	FDateTime					_last_recv_time = FDateTime::UtcNow();
	ENetConnectionState			_connect_state = ENetConnectionState::Invalid;
	volatile bool				_is_update_connect_state = false;
};
