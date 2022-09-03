#pragma once
#include "Modules/ModuleManager.h"
#include "AsymmetricCrypto.h"
#include "NetConnectionState.h"
#include <vector>
#include <memory>

/**
 * The public interface to this module.  In most cases, this interface is only public to sibling modules
 * within this plugin.
 */
class IUnrealNet : public IModuleInterface
{
public:
	/**
	 * Singleton-like access to this module's interface.  This is just for convenience!
	 * Beware of calling this during the shutdown phase, though.  Your module might have been unloaded already.
	 *
	 * @return Returns singleton instance, loading the module on demand if needed
	 */
	static IUnrealNet& Get()
	{
		return FModuleManager::LoadModuleChecked<IUnrealNet>(TEXT("UnrealNet"));
	}

	/**
	 * Checks to see if this module is loaded and ready.  It is only valid to call Get() if IsAvailable() returns true.
	 *
	 * @return True if the module is loaded and ready to use
	 */
	static bool IsAvailable()
	{
		return FModuleManager::Get().IsModuleLoaded(TEXT("UnrealNet"));
	}

	DECLARE_EVENT_TwoParams(IUnrealNet, FOnConnect, int32, uint8)
	virtual FOnConnect& GetOnConnect() = 0;
	DECLARE_EVENT_OneParam(IUnrealNet, FOnClose, int32)
	virtual FOnClose& GetOnClose() = 0;
	DECLARE_EVENT_ThreeParams(IUnrealNet, FOnRecv, int32, uint32, TArray<uint8>)
	virtual FOnRecv& GetOnRecv() = 0;
	DECLARE_EVENT_TwoParams(IUnrealNet, FOnRecvTestPing, int32, uint32)
	virtual FOnRecvTestPing& GetOnRecvTestPing() = 0;

	virtual void SetConnectionDeadTimespan(int32 connect_id, FTimespan timespan) = 0;
	//virtual void SetZipDictionary(const TArray<uint8>& InZipDictionary) = 0;
	virtual void SetRemotePublicKey(const FAsymmetricPublicKey& InRemotePublicKey) = 0;
	virtual void SetLocalPrivateKey(const FAsymmetricPrivateKey& InLocalPrivateKey) = 0;
	virtual int32 CreateClient() = 0;
	virtual void Connect(int32 connect_id, const char* host, const int port) = 0;
	virtual void Close(int32 connect_id) = 0;
	virtual void Clean() = 0;
	virtual void SendMessage(int32 connect_id, uint32 msg_type, const uint8* msg, int32 msg_len) = 0;
	virtual void SendMessage(int32 connect_id, uint32 msg_type, const TArray<uint8>& msg) = 0;
};