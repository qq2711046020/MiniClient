// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "Kismet/BlueprintFunctionLibrary.h"
#include "GameNetworkUtilities.generated.h"

UENUM(BlueprintType)
enum class EGameNetworkConnectionType : uint8
{
	EGNCT_Unknown UMETA(DisplayName = "Unknown"),
	EGNCT_None UMETA(DisplayName = "None"),
	EGNCT_AirplaneMode UMETA(DisplayName = "AirplaneMode"),
	EGNCT_Cell UMETA(DisplayName = "Cel"),
	EGNCT_WiFi UMETA(DisplayName = "WiFi"),
	EGNCT_WiMAX UMETA(DisplayName = "WiMAX"),
	EGNCT_Bluetooth UMETA(DisplayName = "Bluetooth"),
	EGNCT_Ethernet UMETA(DisplayName = "Ethernet"),
};


UENUM(BlueprintType)
enum class EGamePlatformType : uint8
{
	EGPT_Unknown UMETA(DisplayName = "Unknown"),
	EGPT_Windows UMETA(DisplayName = "Windows"),
	EGPT_Android UMETA(DisplayName = "Android"),
	EGPT_Mac UMETA(DisplayName = "Mac"),
	EGPT_IOS UMETA(DisplayName = "IOS"),
	EGPT_Editor_Mac UMETA(DisplayName = "MacEDitor"),
	EGPT_Editor_PC UMETA(DisplayName = "PCEDitor")
};

/**
 * 
 */
UCLASS()
class RUNAUXILIARY_API UGameNetworkUtilities : public UBlueprintFunctionLibrary
{
	GENERATED_BODY()
public:
	UFUNCTION(BlueprintPure, Category = "GameNetworkUtilities", meta = (DisplayName = "GetNetworkConnectionType"))
	static EGameNetworkConnectionType GNU_GetNetworkConnectionType();

	UFUNCTION(BlueprintPure, Category = "GameNetworkUtilities", meta = (DisplayName = "GetPlatformType"))
	static EGamePlatformType GNU_GetPlatformType();
};
