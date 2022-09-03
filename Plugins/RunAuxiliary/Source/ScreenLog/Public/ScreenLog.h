// Copyright 1998-2018 Epic Games, Inc. All Rights Reserved.

#pragma once

#include "Misc/Build.h"

#if !UE_BUILD_SHIPPING

#include "CoreMinimal.h"
#include "Modules/ModuleManager.h"


/** Style of the debug console */
namespace EGameDebugConsoleStyle
{
	enum Type
	{
		/** Shows the debug console input line with tab completion only */
		Compact,

		/** Shows a scrollable log window with the input line on the bottom */
		WithLog,
	};
};

struct FGameDebugConsoleDelegates
{
	FSimpleDelegate OnFocusLost;
	FSimpleDelegate OnConsoleCommandExecuted;
	FSimpleDelegate OnCloseConsole;
};

#endif

class FScreenLogModule : public IModuleInterface
{
public:

	/** IModuleInterface implementation */
	virtual void StartupModule() override;
	virtual void ShutdownModule() override;

#if !UE_BUILD_SHIPPING

	void AddSScreenLogToViewport();
	void RemoveScreenLogFromViewport();
	void RemoveScreenLogDeveice();

	void OnGameEndplay();
	TSharedPtr<class SScreenLog> GetOutputLog();
protected:
	TSharedPtr<SScreenLog> ScreenLogPtr;
	//TSharedPtr<class SWeakWidget> ScreenLogWeakPtr;
#endif

public:

};
