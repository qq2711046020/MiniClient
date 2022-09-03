#pragma once

#include "UObject/ObjectMacros.h"

UENUM(BlueprintType)
enum class ENetConnectionState : uint8
{
	Invalid = 0, 
	Connecting, 
	Connected,
	Disconnected
};
