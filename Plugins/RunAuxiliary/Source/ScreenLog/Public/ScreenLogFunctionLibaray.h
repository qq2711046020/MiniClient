// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "Kismet/BlueprintFunctionLibrary.h"
#include "ScreenLogFunctionLibaray.generated.h"

/**
 *  Gloabol Helper Functions for UI
 */
UCLASS()
class SCREENLOG_API UScreenLogFunctionLibaray : public UBlueprintFunctionLibrary
{
	GENERATED_BODY()
	
	
public:
	UFUNCTION(BlueprintCallable)
	static void AddSScreenLogToViewport();
	UFUNCTION(BlueprintCallable)
	static void RemoveScreenLogFromViewport();
	UFUNCTION(BlueprintCallable)
	static void RemoveScreenLogDeveice();
};