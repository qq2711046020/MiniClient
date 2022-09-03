// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "Misc/Build.h"

#if !UE_BUILD_SHIPPING
/**
 * 
 */
class UScreenLogConsoleTools
{
public:
	static void ScreenLogLogInGame();

public:	
	static class FAutoConsoleCommand ScreenLogLogInGameCommand;
};
#endif