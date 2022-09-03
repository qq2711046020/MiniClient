#include "VirtualCursorFunctionLibrary.h"
#include "GamepadUMGPluginPrivatePCH.h"
#include "GamepadCursorSettings.h"
#include "GameAnalogCursor.h"

void UVirtualCursorFunctionLibrary::EnableVirtualCursor(class APlayerController* PC)
{
	FGameAnalogCursor::EnableAnalogCursor(PC, TSharedPtr<SWidget>());
}

void UVirtualCursorFunctionLibrary::DisableVirtualCursor(class APlayerController* PC)
{
	FGameAnalogCursor::DisableAnalogCursor(PC);
}

bool UVirtualCursorFunctionLibrary::IsCursorOverInteractableWidget()
{
	TSharedPtr<FGameAnalogCursor> Analog = GetDefault<UGamepadCursorSettings>()->GetAnalogCursor();
	if ( Analog.IsValid() )
	{
		return Analog->IsHovered();
	}

	return false;
}


bool UVirtualCursorFunctionLibrary::MakeCanEnableVirtualCursor(class APlayerController* PC)
{
	if (nullptr == PC)
	{
		UE_LOG(LogTemp, Log, TEXT("UVirtualCursorFunctionLibrary::MakeCanEnableVirtualCursor PC not valid"));
		return false;
	}
	TSharedPtr<FGameAnalogCursor> Analog = GetDefault<UGamepadCursorSettings>()->GetAnalogCursor();
	if (Analog.IsValid())
	{
		if (Analog->IsPlayerValid())
		{
			if (Analog->GetPlayerController() == PC)
			{
				return -1 == FSlateApplication::Get().FindInputPreProcessor(Analog);
			}
			else
			{
				UE_LOG(LogTemp, Log, TEXT("UVirtualCursorFunctionLibrary::MakeCanEnableVirtualCursor analog is valid but Not This PlayerController!"));
			}
		}
		else
		{
			UE_LOG(LogTemp, Log, TEXT("UVirtualCursorFunctionLibrary::MakeCanEnableVirtualCursor analog is valid but Not This PlayerController!"));
		}
	}

	if (-1 != FSlateApplication::Get().FindInputPreProcessor(Analog))
	{
		UE_LOG(LogTemp, Log, TEXT("UVirtualCursorFunctionLibrary::MakeCanEnableVirtualCursor aready register ! pc ==%s"), *PC->GetName());
		FSlateApplication::Get().UnregisterInputPreProcessor(Analog);
	}

	return true;
}