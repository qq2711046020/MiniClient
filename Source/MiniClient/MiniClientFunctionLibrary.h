// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "Kismet/BlueprintFunctionLibrary.h"
#include "MiniClientFunctionLibrary.generated.h"

/**
 * 
 */
UCLASS()
class MINICLIENT_API UMiniClientFunctionLibrary : public UBlueprintFunctionLibrary
{
	GENERATED_BODY()

public:
	UFUNCTION(BlueprintCallable, Category = "Config")
		static FString GetLocalConfig(const FString& Section, const FString& Key, const FString& Path);

	UFUNCTION(BlueprintCallable, Category = "Config")
		static void SetLocalConfig(const FString& Section, const FString& Key, const FString& Value, const FString& Path);
};
