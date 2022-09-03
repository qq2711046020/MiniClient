// Fill out your copyright notice in the Description page of Project Settings.


#include "GameNetworkUtilities.h"

#include "HAL/PlatformFilemanager.h"
#include "Kismet/GameplayStatics.h"


EGameNetworkConnectionType UGameNetworkUtilities::GNU_GetNetworkConnectionType()
{
	ENetworkConnectionType networkConnectionType = FPlatformMisc::GetNetworkConnectionType();
	switch (networkConnectionType)
	{
    case ENetworkConnectionType::Unknown:
        return EGameNetworkConnectionType::EGNCT_Unknown;
    case ENetworkConnectionType::None:
        return EGameNetworkConnectionType::EGNCT_None;
    case ENetworkConnectionType::AirplaneMode:
        return EGameNetworkConnectionType::EGNCT_AirplaneMode;
    case ENetworkConnectionType::Cell:
        return EGameNetworkConnectionType::EGNCT_Cell;
    case ENetworkConnectionType::WiFi:
        return EGameNetworkConnectionType::EGNCT_WiFi;
    case ENetworkConnectionType::WiMAX:
        return EGameNetworkConnectionType::EGNCT_WiMAX;
    case ENetworkConnectionType::Bluetooth:
        return EGameNetworkConnectionType::EGNCT_Bluetooth;
    case ENetworkConnectionType::Ethernet:
        return EGameNetworkConnectionType::EGNCT_Ethernet;
	}

    return EGameNetworkConnectionType::EGNCT_None;
}

EGamePlatformType UGameNetworkUtilities::GNU_GetPlatformType()
{
#if WITH_EDITOR
    FString platfromName = UGameplayStatics::GetPlatformName();
    if (platfromName.Contains(TEXT("Windows")))
    {
        return EGamePlatformType::EGPT_Editor_PC;
    }
    else if (platfromName.Contains(TEXT("Mac")))
    {
        return EGamePlatformType::EGPT_Editor_Mac;
    }

    return EGamePlatformType::EGPT_Unknown;
#else

    FString platfromName = UGameplayStatics::GetPlatformName();
    if (platfromName.Contains(TEXT("Windows")))
    {
        return EGamePlatformType::EGPT_Windows;
    }
    else if (platfromName.Contains(TEXT("Mac")))
    {
        return EGamePlatformType::EGPT_Mac;
    }
    else if (platfromName.Contains(TEXT("Android")))
    {
        return EGamePlatformType::EGPT_Android;
    }
    else if (platfromName.Contains(TEXT("IOS")))
    {
        return EGamePlatformType::EGPT_IOS;
    }

    return EGamePlatformType::EGPT_Unknown;
#endif
}