
#pragma once

#include "CoreMinimal.h"
#include "WrapperAsset.generated.h"

UCLASS()
class RUNAUXILIARY_API UWrapperAsset : public UObject
{
	GENERATED_BODY()

public:
	UPROPERTY(VisibleAnywhere)
	FString ImportPath;

	void SetData(const TArray<uint8> & InData)
	{
		AssetData = InData;
	}
	void GetData(TArray<uint8> & OutData) const
	{
		OutData = AssetData;
	}

private:
	UPROPERTY()
	TArray<uint8> AssetData;
};