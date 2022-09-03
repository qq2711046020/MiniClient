// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "Kismet/BlueprintFunctionLibrary.h"
#include "GameFileHelper.generated.h"

/**
 * 
 */
UCLASS()
class RUNAUXILIARY_API UGameFileHelper : public UBlueprintFunctionLibrary
{
	GENERATED_BODY()

public:
	UFUNCTION(BlueprintCallable, Category = "GameFileHelper | File", meta = (DisplayName = "Move File"))
	static bool GFH_MoveFile(const FString& InTo, const FString& InFrom);
	UFUNCTION(BlueprintCallable, Category = "GameFileHelper | File", meta = (DisplayName = "Delete File"))
	static bool GFH_DeleteFile(const FString& InFileName);
	UFUNCTION(BlueprintCallable, Category = "GameFileHelper | File", meta = (DisplayName = "Delete Directory"))
	static bool GFH_Directory(const FString& InDirectory);
};
