#pragma once

#include "UObject/ObjectMacros.h"

UENUM(BlueprintType)
enum class ENetChannel : uint8
{
	Invalid = 0, 
	Control, 
	AboveNormal,
	Normal,
	BelowNormal
};
