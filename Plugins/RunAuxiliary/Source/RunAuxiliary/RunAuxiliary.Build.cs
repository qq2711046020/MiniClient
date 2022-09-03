
using System.IO;
using UnrealBuildTool;

public class RunAuxiliary : ModuleRules
{
	public RunAuxiliary(ReadOnlyTargetRules Target) : base(Target)
	{
        PrivatePCHHeaderFile = "Private/RunAuxiliaryPrivatePCH.h";

        PublicDependencyModuleNames.AddRange(
			new string[]
			{
				"Core",
                "CoreUObject",
				"Engine"
				// ... add other public dependencies that you statically link with here ...
			}
		);

		PrivateDependencyModuleNames.AddRange(
			new string[]
			{
                // ... add other private dependencies that you statically link with here ...
			}
		);
	}
}
