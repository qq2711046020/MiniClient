using System.IO;
using UnrealBuildTool;

public class UnrealNet : ModuleRules
{
    public UnrealNet(ReadOnlyTargetRules Target) : base(Target)
    {
        bEnableUndefinedIdentifierWarnings = false;

        PrivatePCHHeaderFile = "Private/UnrealNetPrivatePCH.h";
        PublicIncludePathModuleNames.Add("Cryptography");
        PublicDependencyModuleNames.AddRange(new string[]{
                "Core",
                "CoreUObject",
                "Engine",
                "Cryptography",
        });

        PrivateDependencyModuleNames.AddRange(new string[]{
                "Sockets",
                "Cryptography",
                "Networking",
        });

        //if(Target.Platform == UnrealTargetPlatform.Android)
        //{
        //    PublicDefinitions.Add("-Werror,-Wdeprecated-declarations");
        //}
    }
}
