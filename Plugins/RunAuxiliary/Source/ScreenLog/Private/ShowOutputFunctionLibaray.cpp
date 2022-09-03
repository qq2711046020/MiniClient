// Fill out your copyright notice in the Description page of Project Settings.

#include "ScreenLogFunctionLibaray.h"
#include "ScreenLog.h"
#include "SScreenLog.h"

#include "Kismet/GameplayStatics.h"
#include "GameFramework/PlayerController.h"
#include "Blueprint/WidgetBlueprintLibrary.h"
#include "Engine/Engine.h"
#include "Engine/GameViewportClient.h"
#include "Widgets/SWeakWidget.h"
#include "Misc/Build.h"

void UScreenLogFunctionLibaray::AddSScreenLogToViewport()
{
#if !UE_BUILD_SHIPPING
	//GEngine->GameViewport->AddViewportWidgetContent(SNew(SWeakWidget).PossiblyNullContent(FScreenLogModule::GetOutputLog()));
	//GEngine->GameViewport->AddViewportWidgetContent(SNew(SWeakWidget).PossiblyNullContent(SNew(SScreenLog).Messages(FScreenLogModule::OutputLogHistory->GetMessages())));
	FScreenLogModule& outputLogInGmaeModule = FModuleManager::GetModuleChecked<FScreenLogModule>("ScreenLog");
	outputLogInGmaeModule.AddSScreenLogToViewport();
#endif
}

void UScreenLogFunctionLibaray::RemoveScreenLogFromViewport()
{
#if !UE_BUILD_SHIPPING
	FScreenLogModule& outputLogInGmaeModule = FModuleManager::GetModuleChecked<FScreenLogModule>("ScreenLog");
	outputLogInGmaeModule.RemoveScreenLogFromViewport();
#endif
}

void UScreenLogFunctionLibaray::RemoveScreenLogDeveice()
{
#if !UE_BUILD_SHIPPING
	FScreenLogModule& outputLogInGmaeModule = FModuleManager::GetModuleChecked<FScreenLogModule>("ScreenLog");
	outputLogInGmaeModule.RemoveScreenLogDeveice();
#endif
}