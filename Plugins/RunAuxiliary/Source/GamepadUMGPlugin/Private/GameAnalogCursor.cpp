#include "GameAnalogCursor.h"
#include "GamepadUMGPluginPrivatePCH.h"
#include "GamepadCursorSettings.h"
#include "Blueprint/WidgetLayoutLibrary.h"
#include "Engine/UserInterfaceSettings.h"
//#include "RawInputFunctionLibrary.h"

bool IsWidgetInteractable(const TSharedPtr<SWidget> Widget)
{
	return Widget.IsValid() && Widget->IsInteractable();
}

////////////////////////////////////////////////////////////////////////////
// FGameAnalogCursor
////////////////////////////////////////////////////////////////////////////

void FGameAnalogCursor::EnableAnalogCursor(class APlayerController* PC, TSharedPtr<SWidget> WidgetToFocus)
{
	
	if (PC)
	{
		UE_LOG(LogTemp, Log, TEXT("FGameAnalogCursor::EnableAnalogCursor pc ==%s"), *PC->GetName());
		if (-1 != FSlateApplication::Get().FindInputPreProcessor(GetMutableDefault<UGamepadCursorSettings>()->GetAnalogCursor()))
		{
			UE_LOG(LogTemp, Log, TEXT("FGameAnalogCursor::EnableAnalogCursor aready register ! pc ==%s"), *PC->GetName());
			FSlateApplication::Get().UnregisterInputPreProcessor(GetMutableDefault<UGamepadCursorSettings>()->GetAnalogCursor());
		}
		const float CursorRadius = GetDefault<UGamepadCursorSettings>()->GetAnalogCursorRadius();
		TSharedPtr<FGameAnalogCursor> AnalogCursor = MakeShareable(new FGameAnalogCursor(PC, CursorRadius));
		FSlateApplication::Get().RegisterInputPreProcessor(AnalogCursor);
		FSlateApplication::Get().SetCursorRadius(CursorRadius);

		GetMutableDefault<UGamepadCursorSettings>()->SetAnalogCursor(AnalogCursor);

		////setup the new input mode
		//FInputModeGameAndUI NewInputMode;
		////NewInputMode.SetLockMouseToViewport(true);
		//NewInputMode.SetLockMouseToViewportBehavior(EMouseLockMode::LockOnCapture);

		//NewInputMode.SetWidgetToFocus(WidgetToFocus);
		//PC->SetInputMode(NewInputMode);
	}
}

void FGameAnalogCursor::DisableAnalogCursor(class APlayerController* PC)
{
	if (PC)
	{
		UE_LOG(LogTemp, Log, TEXT("FGameAnalogCursor::DisableAnalogCursor pc ==%s"), *PC->GetName());
		if (FSlateApplication::IsInitialized())
		{
			FSlateApplication::Get().UnregisterInputPreProcessor(GetMutableDefault<UGamepadCursorSettings>()->GetAnalogCursor());
			FSlateApplication::Get().SetCursorRadius(0.0f);
		}
	
		//FInputModeGameOnly NewInputMode;
		//PC->SetInputMode(NewInputMode);
	}
}

FGameAnalogCursor::FGameAnalogCursor(class APlayerController* PC, float _Radius)
: Velocity(FVector2D::ZeroVector)
, CurrentPosition(FLT_MAX, FLT_MAX)
, LastCursorDirection(FVector2D::ZeroVector)
, HoveredWidgetName(NAME_None)
, bIsUsingAnalogCursor(false)
, Radius(FMath::Max<float>(_Radius, 16.0f))
, PlayerContext(PC)
{
	ensure(PlayerContext.IsValid());
}

void FGameAnalogCursor::Tick(const float DeltaTime, FSlateApplication& SlateApp, TSharedRef<ICursor> Cursor)
{
	if (PlayerContext.IsValid())
	{
		const FVector2D ViewportSize = UWidgetLayoutLibrary::GetViewportSize(PlayerContext.GetPlayerController());
		const float DPIScale = GetDefault<UUserInterfaceSettings>()->GetDPIScaleBasedOnSize(FIntPoint(FMath::RoundToInt(ViewportSize.X), FMath::RoundToInt(ViewportSize.Y)));
		

		const UGamepadCursorSettings* Settings = GetDefault<UGamepadCursorSettings>();

		//if we have no acceleration curve, then move on;
		if (Settings->GetUseEngineAnalogCursor())
		{
			FAnalogCursor::Tick(DeltaTime, SlateApp, Cursor);
			return;
		}

		//set the current position if we haven't already
		static const float MouseMoveSizeBuffer = 2.0f;
		const FVector2D CurrentPositionTruc = FVector2D(FMath::TruncToFloat(CurrentPosition.X), FMath::TruncToFloat(CurrentPosition.Y));
		if (CurrentPositionTruc != Cursor->GetPosition())
		{
			CurrentPosition = Cursor->GetPosition();
			Velocity = FVector2D::ZeroVector;
			LastCursorDirection = FVector2D::ZeroVector;
			bIsUsingAnalogCursor = false;
			FSlateApplication::Get().SetCursorRadius(0.0f);
		}

		//cache the old position
		const FVector2D OldPosition = CurrentPosition;

		//figure out if we should clamp the speed or not
		const float MaxSpeedNoHover = Settings->GetMaxAnalogCursorSpeed()*DPIScale;
		const float MaxSpeedHover = Settings->GetMaxAnalogCursorSpeedWhenHovered()*DPIScale;
		const float DragCoNoHover = Settings->GetAnalogCursorDragCoefficient()*DPIScale;
		const float DragCoHovered = Settings->GetAnalogCursorDragCoefficientWhenHovered()*DPIScale;
		const float MinCursorSpeed = Settings->GetMinAnalogCursorSpeed()*DPIScale;

		HoveredWidgetName = NAME_None;
		float DragCo = DragCoNoHover;
		
		//Part of base class now
		MaxSpeed = MaxSpeedNoHover;

		//see if we are hovered over a widget or not
		FWidgetPath WidgetPath = SlateApp.LocateWindowUnderMouse(OldPosition, SlateApp.GetInteractiveTopLevelWindows());
		if (WidgetPath.IsValid())
		{
			for (int32 i = WidgetPath.Widgets.Num() - 1; i >= 0; --i)
			{
				//grab the widget
				FArrangedWidget& ArrangedWidget = WidgetPath.Widgets[i];
				TSharedRef<SWidget> Widget = ArrangedWidget.Widget;

				//see if it is acceptable or not
				if (IsWidgetInteractable(Widget))
				{
					HoveredWidgetName = Widget->GetType();
					DragCo = DragCoHovered;
					MaxSpeed = MaxSpeedHover;
					break;
				}
			}
		}
		DragCo = DragCoHovered;
		MaxSpeed = MaxSpeedHover;
		//grab the cursor acceleration
		const FVector2D AccelFromAnalogStick = GetAnalogCursorAccelerationValue(GetAnalogValues(), DPIScale);

		FVector2D NewAccelerationThisFrame = FVector2D::ZeroVector;
		if (!Settings->GetAnalogCursorNoAcceleration())
		{
			//Calculate a new velocity. RK4.
			if (!AccelFromAnalogStick.IsZero() || !Velocity.IsZero())
			{
				const FVector2D A1 = (AccelFromAnalogStick - (DragCo * Velocity)) * DeltaTime;
				const FVector2D A2 = (AccelFromAnalogStick - (DragCo * (Velocity + (A1 * 0.5f)))) * DeltaTime;
				const FVector2D A3 = (AccelFromAnalogStick - (DragCo * (Velocity + (A2 * 0.5f)))) * DeltaTime;
				const FVector2D A4 = (AccelFromAnalogStick - (DragCo * (Velocity + A3))) * DeltaTime;
				NewAccelerationThisFrame = (A1 + (2.0f * A2) + (2.0f * A3) + A4) / 6.0f;
				Velocity += NewAccelerationThisFrame;
			}
		}
		else
		{
			//else, use what is coming straight from the analog stick
			Velocity = AccelFromAnalogStick;
		}

		//if we are smaller than out min speed, zero it out
		const float VelSizeSq = Velocity.SizeSquared();
		if (VelSizeSq < (MinCursorSpeed * MinCursorSpeed))
		{
			Velocity = FVector2D::ZeroVector;
		}
		else if (VelSizeSq > (MaxSpeed * MaxSpeed))
		{
			//also cap us if we are larger than our max speed
			Velocity = Velocity.GetSafeNormal() * MaxSpeed;
		}

		//store off the last cursor direction
		if (!Velocity.IsZero())
		{
			LastCursorDirection = Velocity.GetSafeNormal();
		}

		//update the new position
		CurrentPosition += (Velocity * DeltaTime);

		//update the cursor position
		UpdateCursorPosition(SlateApp, Cursor, CurrentPosition);

		//if we get here, and we are moving the stick, then hooray
		if (!AccelFromAnalogStick.IsZero())
		{
			bIsUsingAnalogCursor = true;
			FSlateApplication::Get().SetCursorRadius(Settings->GetAnalogCursorRadius()*DPIScale);
		}
	}
}

FVector2D FGameAnalogCursor::GetAnalogCursorAccelerationValue(const FVector2D& InAnalogValues, float DPIScale)
{
	const UGamepadCursorSettings* Settings = GetDefault<UGamepadCursorSettings>();

	FVector2D RetValue = FVector2D::ZeroVector;
	if ( const FRichCurve* AccelerationCurve = Settings->GetAnalogCursorAccelerationCurve() )
	{
		const float DeadZoneSize = Settings->GetAnalogCursorDeadZone();
		const float AnalogValSize = InAnalogValues.Size();
		if (AnalogValSize > DeadZoneSize)
		{
			RetValue = AccelerationCurve->Eval(AnalogValSize) * InAnalogValues.GetSafeNormal() * DPIScale;
			RetValue *= Settings->GetAnalogCursorAccelerationMultiplier()*DPIScale;
		}
	}
	return RetValue;
}



bool FGameAnalogCursor::HandleAnalogInputEvent(FSlateApplication& SlateApp, const FAnalogInputEvent& InAnalogInputEvent)
{
	// return FAnalogCursor::HandleAnalogInputEvent(SlateApp, InAnalogInputEvent);

	//if (IsRelevantInput(InAnalogInputEvent))
	//{
	//	FKey Key = InAnalogInputEvent.GetKey();
	//	float AnalogValue = InAnalogInputEvent.GetAnalogValue();
	//	//FIXED   Aways have value
	//	if (FMath::Abs(AnalogValue) < 0.15)
	//	{
	//		AnalogValue = 0;
	//	}
	//	//if (Key == FRawInputKeys::GenericUSBController_Axis3)
	//	//{
	//	//	SlateApp.ProcessAnalogInputEvent(FAnalogInputEvent(EKeys::Gamepad_LeftY, FModifierKeysState(), InAnalogInputEvent.GetUserIndex(), InAnalogInputEvent.IsRepeat(), InAnalogInputEvent.GetCharacter(), InAnalogInputEvent.GetKeyCode(), AnalogValue));
	//	//}
	//	//else if(Key == FRawInputKeys::GenericUSBController_Axis4)
	//	//{
	//	//	SlateApp.ProcessAnalogInputEvent(FAnalogInputEvent(EKeys::Gamepad_LeftX, FModifierKeysState(), InAnalogInputEvent.GetUserIndex(), InAnalogInputEvent.IsRepeat(), InAnalogInputEvent.GetCharacter(), InAnalogInputEvent.GetKeyCode(), AnalogValue));
	//	//	return true;
	//	//}
	//	//else if (Key == EKeys::Gamepad_RightX)
	//	//{
	//	//	FVector2D& Value = GetAnalogValue(EAnalogStick::Right);
	//	//	Value.X = AnalogValue;
	//	//}
	//	//else if (Key == EKeys::Gamepad_RightY)
	//	//{
	//	//	FVector2D& Value = GetAnalogValue(EAnalogStick::Right);
	//	//	Value.Y = -AnalogValue;
	//	//}
	//	else
	//	{
	//		return FAnalogCursor::HandleAnalogInputEvent(SlateApp, InAnalogInputEvent);
	//	}
	//}

	return FAnalogCursor::HandleAnalogInputEvent(SlateApp, InAnalogInputEvent);
}

bool FGameAnalogCursor::HandleKeyDownEvent(FSlateApplication& SlateApp, const FKeyEvent& InKeyEvent)
{
	//return FAnalogCursor::HandleKeyDownEvent(SlateApp, InKeyEvent);

	//if (IsRelevantInput(InKeyEvent))
	//{
	//	FKey Key = InKeyEvent.GetKey();
	//	// Consume the sticks input so it doesn't effect other things
	//	if (Key == FRawInputKeys::GenericUSBController_Axis1 ||
	//		Key == FRawInputKeys::GenericUSBController_Axis2)
	//	{
	//		return true;
	//	}

	//	// Bottom face button is a click
	//	if (Key == FRawInputKeys::GenericUSBController_Button2)
	//	{
	//		if (!InKeyEvent.IsRepeat())
	//		{
	//			if (TSharedPtr<FSlateUser> SlateUser = SlateApp.GetUser(InKeyEvent))
	//			{
	//				const bool bIsPrimaryUser = FSlateApplication::CursorUserIndex == SlateUser->GetUserIndex();
	//				FPointerEvent MouseEvent(
	//					SlateUser->GetUserIndex(),
	//					FSlateApplication::CursorPointerIndex,
	//					SlateUser->GetCursorPosition(),
	//					SlateUser->GetPreviousCursorPosition(),
	//					bIsPrimaryUser ? SlateApp.GetPressedMouseButtons() : TSet<FKey>(),
	//					EKeys::LeftMouseButton,
	//					0,
	//					bIsPrimaryUser ? SlateApp.GetModifierKeys() : FModifierKeysState()
	//				);

	//				TSharedPtr<FGenericWindow> GenWindow;
	//				return SlateApp.ProcessMouseButtonDownEvent(GenWindow, MouseEvent);
	//			}
	//		}

	//		return true;
	//	}
	//}

	return FAnalogCursor::HandleKeyDownEvent(SlateApp, InKeyEvent);
}

bool FGameAnalogCursor::HandleKeyUpEvent(FSlateApplication& SlateApp, const FKeyEvent& InKeyEvent)
{
	//return FAnalogCursor::HandleKeyUpEvent(SlateApp, InKeyEvent);
	//if (IsRelevantInput(InKeyEvent))
	//{
	//	FKey Key = InKeyEvent.GetKey();

	//	// Consume the sticks input so it doesn't effect other things
	//	if (Key == FRawInputKeys::GenericUSBController_Axis1 ||
	//		Key == FRawInputKeys::GenericUSBController_Axis2)
	//	{
	//		return true;
	//	}

	//	// Bottom face button is a click
	//	if (Key == FRawInputKeys::GenericUSBController_Button2 && !InKeyEvent.IsRepeat())
	//	{
	//		if (TSharedPtr<FSlateUser> SlateUser = SlateApp.GetUser(InKeyEvent))
	//		{
	//			const bool bIsPrimaryUser = FSlateApplication::CursorUserIndex == SlateUser->GetUserIndex();
	//			FPointerEvent MouseEvent(
	//				SlateUser->GetUserIndex(),
	//				FSlateApplication::CursorPointerIndex,
	//				SlateUser->GetCursorPosition(),
	//				SlateUser->GetPreviousCursorPosition(),
	//				bIsPrimaryUser ? SlateApp.GetPressedMouseButtons() : TSet<FKey>(),
	//				EKeys::LeftMouseButton,
	//				0,
	//				bIsPrimaryUser ? SlateApp.GetModifierKeys() : FModifierKeysState()
	//			);

	//			return SlateApp.ProcessMouseButtonUpEvent(MouseEvent);
	//		}
	//	}
	//}
	return FAnalogCursor::HandleKeyUpEvent(SlateApp, InKeyEvent);
}
