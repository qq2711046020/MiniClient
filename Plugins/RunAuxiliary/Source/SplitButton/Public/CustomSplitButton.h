#pragma once

#include "CoreMinimal.h"
#include "Widgets/SWidget.h"
#include "Components/ContentWidget.h"
#include "CustomSplitButton.generated.h"

UCLASS()
class UCustomSplitButton : public UContentWidget
{
	GENERATED_BODY()

public:
	UPROPERTY(EditAnywhere, BlueprintReadOnly, Category = "SplitButton")
	FSlateBrush BaseBrush;

	UPROPERTY(EditAnywhere, BlueprintReadOnly, Category = "SplitButton")
	FSlateBrush OutlineBrush;

	UPROPERTY(EditAnywhere, BlueprintReadOnly, Category = "SplitButton")
	bool bShowOutline = false;

	UPROPERTY(EditAnywhere, BlueprintReadOnly, Category = "SplitButton")
	int32 Count = 4;

	UPROPERTY(EditAnywhere, BlueprintReadOnly, Category = "SplitButton")
	float BaseScale = 0.5f;


	virtual void SynchronizeProperties() override;
	virtual TSharedRef<SWidget> RebuildWidget() override;


private:
	FVector2D ComputeDesiredSize(float LayoutScaleMultiplier) const;
	const FSlateBrush* GetBaseImage() const;
	const FSlateBrush* GetOutlineImage() const;
	bool GetOutlineVisible() const;
	float GetBaseScale() const;

	TSharedPtr<class SCustomSplitButton> MyButton;
};
