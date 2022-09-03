// Fill out your copyright notice in the Description page of Project Settings.


#include "GameFileHelper.h"

#include "HAL/FileManager.h"
#include "HAL/PlatformFilemanager.h"

bool UGameFileHelper::GFH_MoveFile(const FString& InTo, const FString& InFrom)
{
	IPlatformFile& PlatformFile = FPlatformFileManager::Get().GetPlatformFile();
	return PlatformFile.MoveFile(*InTo, *InFrom);
}

bool UGameFileHelper::GFH_DeleteFile(const FString& InFileName)
{
	IPlatformFile& PlatformFile = FPlatformFileManager::Get().GetPlatformFile();
	return PlatformFile.DeleteFile(*InFileName);
}

bool UGameFileHelper::GFH_Directory(const FString& InDirectory)
{
	IPlatformFile& PlatformFile = FPlatformFileManager::Get().GetPlatformFile();
	return PlatformFile.DeleteDirectory(*InDirectory);
}