// Copyright Epic Games, Inc. All Rights Reserved.


#include "MiniClientGameModeBase.h"
#include "UnLua.h"

bool AMiniClientGameModeBase::ProcessConsoleExec(const TCHAR* Cmd, FOutputDevice& Ar, UObject* Executor)
{
	lua_State* L = UnLua::GetState();

	FString sCmd = Cmd;
	const auto RetValues = UnLua::CallTableFunc(L, "_G", "ProcessConsoleExec", sCmd);
	check(RetValues.Num() == 1);

	const bool bHandle = RetValues[0].Value<bool>();
	return bHandle;
}
