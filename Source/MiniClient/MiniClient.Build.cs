// Copyright Epic Games, Inc. All Rights Reserved.

using UnrealBuildTool;

public class MiniClient : ModuleRules
{
	public MiniClient(ReadOnlyTargetRules Target) : base(Target)
	{
		PCHUsage = PCHUsageMode.UseExplicitOrSharedPCHs;
	
		PublicDependencyModuleNames.AddRange(new string[] {
			"Core",
			"CoreUObject",
			"Engine",
			"InputCore",
			"UnLua",
			"Lua"
		});

		PrivateDependencyModuleNames.AddRange(new string[] {
			"Slate", "SlateCore",
			"UMG",
		});

		// Uncomment if you are using online features
		// PrivateDependencyModuleNames.Add("OnlineSubsystem");

		// To include OnlineSubsystemSteam, add it to the plugins section in your uproject file with the Enabled attribute set to true
	}
}
