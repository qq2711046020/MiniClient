// Copyright Epic Games, Inc. All Rights Reserved.

#pragma once

#include "CoreMinimal.h"
#include "GameFramework/GameModeBase.h"
#include "MiniClientGameModeBase.generated.h"

/**
 * 
 */
UCLASS()
class MINICLIENT_API AMiniClientGameModeBase : public AGameModeBase
{
	GENERATED_BODY()

public:
	virtual bool ProcessConsoleExec(const TCHAR* Cmd, FOutputDevice& Ar, UObject* Executor) override;
};
