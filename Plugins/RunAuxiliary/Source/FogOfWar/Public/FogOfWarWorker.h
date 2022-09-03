// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "HAL/Runnable.h"

/**
* Worker thread for updating the fog of war data.
*/
class AFogOfWarManager;

class FOGOFWAR_API AFogOfWarWorker : public FRunnable
{
	//Thread to run the FRunnable on
	FRunnableThread* Thread;

	//Pointer to our manager
	AFogOfWarManager* Manager;

	//Thread safe counter
	FThreadSafeCounter StopTaskCounter;

public:
	AFogOfWarWorker();
	AFogOfWarWorker(AFogOfWarManager* manager);
	virtual ~AFogOfWarWorker();

	//FRunnable interface
	virtual bool Init();
	virtual uint32 Run();
	virtual void Stop();

	//Method to perform work
	void UpdateFowTexture();
	bool bShouldUpdate = false;
	bool isWriteUnFog = false;
	bool isWriteFow = false;
	bool isWriteTerraIncog = false;
	bool bCheckActorInTerraIncog = false;//Bool, is the actor in terra incognita territory

	void ShutDown();
protected:
	void Reveal(FVector InLocation, float InSampleUnitMeter, float InHalfTextureSize, AActor* InActor, float InSightRange, TSet<FVector2D>& InTexelsToBlur, TSet<FVector2D>& InCurrentlyInSight);
};