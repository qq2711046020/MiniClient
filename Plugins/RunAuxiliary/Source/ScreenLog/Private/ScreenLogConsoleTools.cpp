// Fill out your copyright notice in the Description page of Project Settings.

#if !UE_BUILD_SHIPPING

#include "ScreenLogConsoleTools.h"

#include "HAL/IConsoleManager.h"
#include "ScreenLogFunctionLibaray.h"

void UScreenLogConsoleTools::ScreenLogLogInGame()
{
	static bool isShow = false;
	if (!isShow)
	{
		isShow = true;
		UScreenLogFunctionLibaray::AddSScreenLogToViewport();
	}
	else
	{
		isShow = false;
		UScreenLogFunctionLibaray::RemoveScreenLogFromViewport();
	}
}

FAutoConsoleCommand UScreenLogConsoleTools::ScreenLogLogInGameCommand(
	TEXT("ScreenLog"),
	TEXT("Show Output Log In Game."),
	FConsoleCommandDelegate::CreateStatic(&UScreenLogConsoleTools::ScreenLogLogInGame)
);

#endif