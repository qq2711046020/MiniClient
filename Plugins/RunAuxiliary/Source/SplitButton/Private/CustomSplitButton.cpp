#include "CustomSplitButton.h"
#include "Widgets/Layout/SConstraintCanvas.h"
#include "Widgets/Images/SImage.h"

class SCustomSplitButton : public SCompoundWidget
{
public:
	SLATE_BEGIN_ARGS(SCustomSplitButton)
		:_BaseImg(nullptr)
		,_OutlineImg(nullptr)
		,_BaseScale(0.5f)
		,_ShowOutline(false)
		,_Count(4)
	{}
		SLATE_ATTRIBUTE( const FSlateBrush*, BaseImg)
		SLATE_ATTRIBUTE( const FSlateBrush*, OutlineImg)
		SLATE_ATTRIBUTE(float, BaseScale)
		SLATE_ATTRIBUTE(bool, ShowOutline)
		SLATE_ATTRIBUTE(int32, Count)
	SLATE_END_ARGS()

public:
	void Construct(const FArguments& InArgs)
	{
		BaseImg = InArgs._BaseImg.Get();
		OutlineImg = InArgs._OutlineImg.Get();
		BaseScale = InArgs._BaseScale;
		ShowOutline = InArgs._ShowOutline;
		Count = InArgs._Count;

		this->ChildSlot
			.HAlign(HAlign_Fill)
			.VAlign(VAlign_Fill)
			[
				SNew(SConstraintCanvas)
				+ SConstraintCanvas::Slot()
				.Anchors(FAnchors(0.5, 0.5f, 0.5f, 0.5f))
				.Offset(FMargin())
				.Alignment(TAttribute<FVector2D>(FVector2D(BaseScale.Get(), BaseScale.Get())))
				.AutoSize(true)
				[
					SNew(SImage)
					.Image(InArgs._BaseImg)
				]
			];
	}

	virtual int32 OnPaint(const FPaintArgs& Args, const FGeometry& AllottedGeometry, const FSlateRect& MyCullingRect, FSlateWindowElementList& OutDrawElements, int32 LayerId, const FWidgetStyle& InWidgetStyle, bool bParentEnabled) const override
	{
		bool bEnabled = ShouldBeEnabled(bParentEnabled);
		ESlateDrawEffect DrawEffects = !bEnabled ? ESlateDrawEffect::DisabledEffect : ESlateDrawEffect::None;

		//FVector2D drawSize = AllottedGeometry.GetDrawSize();

		//if (BaseImg && BaseImg->DrawAs != ESlateBrushDrawType::NoDrawType)
		//{
		//	++LayerId;
		//	FSlateDrawElement::MakeBox(
		//		OutDrawElements,
		//		LayerId,
		//		AllottedGeometry.ToPaintGeometry(drawSize * BaseScale.Get(), drawSize * BaseScale.Get()),
		//		BaseImg,
		//		DrawEffects
		//	);
		//}

		if (ShowOutline.Get() &&  OutlineImg && OutlineImg->DrawAs != ESlateBrushDrawType::NoDrawType)
		{
			++ LayerId;
			FSlateDrawElement::MakeBox(
				OutDrawElements,
				LayerId,
				AllottedGeometry.ToPaintGeometry(),
				OutlineImg,
				DrawEffects
			);

			++LayerId;
			int32 lineCount = Count.Get();
			for (int32 index=0; index < lineCount; ++ index)
			{
				FVector2D Begin = AllottedGeometry.GetAbsoluteSize() / 2.0f;
				FVector2D End = FVector2D(AllottedGeometry.GetAbsoluteSize().X/2.0f,0);
				End = End.GetRotated(360.0f/ lineCount * index);
				TArray<FVector2D> Points;
				Points.Add(Begin);
				Points.Add(End);
				FSlateDrawElement::MakeLines(
					OutDrawElements,
					LayerId,
					AllottedGeometry.ToPaintGeometry(),
					Points
				);
			}
		}

		return SCompoundWidget::OnPaint(Args, AllottedGeometry, MyCullingRect, OutDrawElements, LayerId, InWidgetStyle, bParentEnabled);
	}

	const FSlateBrush* BaseImg = nullptr;
	const FSlateBrush* OutlineImg = nullptr;
	bool bShowOutline = true;
	TAttribute<float> BaseScale;
	TAttribute<bool> ShowOutline;
	TAttribute<int32> Count;
};

void UCustomSplitButton::SynchronizeProperties() {
	Super::SynchronizeProperties();
	//MyButton->BaseImg = &BaseBrush;
	//MyButton->OutlineImg = &OutlineBrush;
}

TSharedRef<SWidget> UCustomSplitButton::RebuildWidget() 
{
	SAssignNew(MyButton,SCustomSplitButton)
		.BaseImg_UObject(this, &UCustomSplitButton::GetBaseImage)
		.OutlineImg_UObject(this, &UCustomSplitButton::GetOutlineImage)
		.BaseScale_UObject(this, &UCustomSplitButton::GetBaseScale)
		.ShowOutline_UObject(this, &UCustomSplitButton::GetOutlineVisible)
		;
	return MyButton.ToSharedRef();
}

const FSlateBrush* UCustomSplitButton::GetBaseImage() const
{
	return &BaseBrush;
}

const FSlateBrush* UCustomSplitButton::GetOutlineImage() const
{
	return &OutlineBrush;
}

bool UCustomSplitButton::GetOutlineVisible() const
{
	return bShowOutline;
}

float UCustomSplitButton::GetBaseScale() const
{
	return BaseScale;
}

FVector2D UCustomSplitButton::ComputeDesiredSize(float LayoutScaleMultiplier) const
{
	return FVector2D{ 300.f, 300.f };
}
