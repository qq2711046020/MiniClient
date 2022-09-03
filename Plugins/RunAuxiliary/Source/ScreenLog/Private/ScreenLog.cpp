// Copyright 1998-2018 Epic Games, Inc. All Rights Reserved.

#include "ScreenLog.h"

#if !UE_BUILD_SHIPPING
#include "SScreenLog.h"
#include "ScreenLogFunctionLibaray.h"
#endif

#include "Features/IModularFeatures.h"
#include "Modules/ModuleManager.h"
#include "Framework/Application/SlateApplication.h"
#include "Textures/SlateIcon.h"
#include "Framework/Docking/TabManager.h"
#include "Editor/WorkspaceMenuStructure/Public/WorkspaceMenuStructure.h"
#include "Editor/WorkspaceMenuStructure/Public/WorkspaceMenuStructureModule.h"
#include "Widgets/Docking/SDockTab.h"
#include "Widgets/SWeakWidget.h"
#include "Engine/Engine.h"
#include "Engine/GameViewportClient.h"
#include "GameDelegates.h"

#define LOCTEXT_NAMESPACE "FScreenLogModule"

//TSharedPtr<FScreenLogHistory>  FScreenLogModule::OutputLogHistory;
//TSharedPtr<SScreenLog> FScreenLogModule::ScreenLogPtr;
//TSharedPtr<class SWeakWidget> FScreenLogModule::ScreenLogWeakPtr;
#if !UE_BUILD_SHIPPING
namespace OutputLogModule
{
	static const FName OutputLogTabName = FName(TEXT("ScreenLog"));
}

/** This class is to capture all log output even if the log window is closed */
class FScreenLogHistory : public FOutputDevice
{
public:

	FScreenLogHistory()
	{
		GLog->AddOutputDevice(this);
		GLog->SerializeBacklog(this);
	}

	~FScreenLogHistory()
	{
		// At shutdown, GLog may already be null
		if (GLog != NULL)
		{
			GLog->RemoveOutputDevice(this);
		}
	}

	/** Gets all captured messages */
	const TArray< TSharedPtr<FGameLogMessage> >& GetMessages() const
	{
		return Messages;
	}

protected:

	virtual void Serialize(const TCHAR* V, ELogVerbosity::Type Verbosity, const class FName& Category) override
	{
		// Capture all incoming messages and store them in history
		SScreenLog::CreateLogMessages(V, Verbosity, Category, Messages);
	}

private:

	/** All log messsges since this module has been started */
	TArray< TSharedPtr<FGameLogMessage> > Messages;
};

static TSharedPtr<FScreenLogHistory> OutputLogHistory;
#endif

#if !UE_BUILD_SHIPPING
TSharedPtr<SScreenLog> FScreenLogModule::GetOutputLog()
{
	return ScreenLogPtr;
}

void FScreenLogModule::AddSScreenLogToViewport()
{
	if (!ScreenLogPtr.IsValid())
	{
		if (!OutputLogHistory.IsValid())
		{
			OutputLogHistory = MakeShareable(new FScreenLogHistory);
		}
		 
		SAssignNew(ScreenLogPtr, SScreenLog)
			.Messages(OutputLogHistory->GetMessages())
			.Visibility(EVisibility::SelfHitTestInvisible);
	}
	//GEngine->GameViewport->AddViewportWidgetContent(SAssignNew(ScreenLogWeakPtr, SWeakWidget).PossiblyNullContent(FScreenLogModule::GetOutputLog()));
	//GEngine->GameViewport->AddViewportWidgetContent(SNew(SWeakWidget).PossiblyNullContent(FScreenLogModule::GetOutputLog()));
	GEngine->GameViewport->AddViewportWidgetContent(FScreenLogModule::GetOutputLog().ToSharedRef(), 100);
	
}

void FScreenLogModule::RemoveScreenLogFromViewport()
{
	if (ScreenLogPtr.IsValid() && nullptr != GEngine->GameViewport)
	{

		GEngine->GameViewport->RemoveViewportWidgetContent(ScreenLogPtr.ToSharedRef());
	}
}

void FScreenLogModule::RemoveScreenLogDeveice()
{
	if (GLog != nullptr && ScreenLogPtr.IsValid())
	{
		GLog->RemoveOutputDevice(ScreenLogPtr.Get());
	}
}


void FScreenLogModule::OnGameEndplay()
{
	RemoveScreenLogFromViewport();
	RemoveScreenLogDeveice();
	if (ScreenLogPtr.IsValid())
	{
		ScreenLogPtr.IsValid();
	}
}
#endif

void FScreenLogModule::StartupModule()
{
#if !UE_BUILD_SHIPPING
	OutputLogHistory = MakeShareable(new FScreenLogHistory);

	FGameDelegates::Get().GetEndPlayMapDelegate().AddRaw(this, &FScreenLogModule::OnGameEndplay);
#endif
}

void FScreenLogModule::ShutdownModule()
{
	// This function may be called during shutdown to clean up your module.  For modules that support dynamic reloading,
	// we call this function before unloading the module.
	UE_LOG(LogTemp, Log, TEXT("[DF]FScreenLogModule::ShutdownModule"));
#if !UE_BUILD_SHIPPING
	FGameDelegates::Get().GetEndPlayMapDelegate().RemoveAll(this);
	OutputLogHistory.Reset();
#endif
}

#undef LOCTEXT_NAMESPACE
	
IMPLEMENT_MODULE(FScreenLogModule, ScreenLog)