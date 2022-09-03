// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"

#include "FogOfWarTypes.generated.h"

USTRUCT(BlueprintType)
struct FFOWStaticModifier_UnFogged
{
	GENERATED_BODY()
public:

	FFOWStaticModifier_UnFogged()
		: Location(0)
		, Radius(100)
	{}

	FFOWStaticModifier_UnFogged(FVector InLocation, float Radius)
		: Location(InLocation)
		, Radius(Radius)
	{}

	FVector Location;
	float Radius;
};

USTRUCT(BlueprintType)
struct FFOWModifierParam
{
	GENERATED_BODY()
public:

	FFOWModifierParam()
		: Location(0)
		, Radius(10)
		, bIsWriteUnFog(true)
		, bIsWriteFow(true)
		, bIsWriteTerraIncog(true)
	   {}

	FFOWModifierParam(FVector InLocation, float Radius, bool bInIsWriteUnFog, bool bInIsWriteFow, bool bInIsWriteTerraIncog)
		: Location(InLocation)
		, Radius(Radius)
		, bIsWriteUnFog(bInIsWriteUnFog)
		, bIsWriteFow(bInIsWriteFow)
		, bIsWriteTerraIncog(bInIsWriteTerraIncog)
	{}

	FVector Location;
	float Radius;
	uint8 bIsWriteUnFog : 1;
	uint8 bIsWriteFow : 1;
	uint8 bIsWriteTerraIncog : 1;

};