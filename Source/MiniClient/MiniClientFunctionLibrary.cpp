// Fill out your copyright notice in the Description page of Project Settings.


#include "MiniClientFunctionLibrary.h"

FString UMiniClientFunctionLibrary::GetLocalConfig(const FString& Section, const FString& Key, const FString& Path)
{
	FString Result;
	FString FullPath = FPaths::Combine(FPaths::ProjectUserDir(), *Path);
	GConfig->GetString(*Section, *Key, Result, *FullPath);
	return Result;
}

void UMiniClientFunctionLibrary::SetLocalConfig(const FString& Section, const FString& Key, const FString& Value, const FString& Path)
{
	FString FullPath = FPaths::Combine(FPaths::ProjectUserDir(), *Path);
	GConfig->SetString(*Section, *Key, *Value, *FullPath);
	GConfig->Flush(false, GGameUserSettingsIni);
}