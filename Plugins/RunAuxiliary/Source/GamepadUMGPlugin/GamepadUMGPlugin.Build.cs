using UnrealBuildTool;

public class GamepadUMGPlugin : ModuleRules
{
    public GamepadUMGPlugin(ReadOnlyTargetRules Target) : base(Target)
    {
        PublicDependencyModuleNames.AddRange(
			new string[] { 
				"Core", 
				"CoreUObject", 
				"Engine", 
				"InputCore",
				"RawInput"
			}
		);

        PrivateDependencyModuleNames.AddRange(new string[] { "Slate", "SlateCore", "UMG", "DeveloperSettings" });
	}
}
