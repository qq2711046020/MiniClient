using System.IO;
using UnrealBuildTool;

public class Cryptography : ModuleRules
{
    public Cryptography(ReadOnlyTargetRules Target) : base(Target)
    {
        PrivatePCHHeaderFile = "Private/CryptographyPrivatePCH.h";
        bUseRTTI = true;
        bEnableExceptions = true;

        PublicDependencyModuleNames.AddRange(
            new string[]
            {
                "Core"
			}
        );

        string ThirdPartyFolder = Path.Combine(ModuleDirectory, "../../ThirdParty");
        string CryptoPPPath = Path.Combine(ThirdPartyFolder, "CryptoPP", "8.5.0");
        PublicIncludePaths.Add(Path.Combine(CryptoPPPath, "include"));
        PublicIncludePaths.Add(Path.Combine(ModuleDirectory, "Public"));
        if (Target.Platform == UnrealTargetPlatform.Win64)
        {
            PublicAdditionalLibraries.Add(Path.Combine(CryptoPPPath, "lib", "Win64", "VS2019", "cryptlib.lib"));
        }
        if (Target.Platform == UnrealTargetPlatform.Mac)
        {
            PublicAdditionalLibraries.Add(Path.Combine(CryptoPPPath, "lib", "Mac", "libcryptopp.a"));
        }
        if (Target.Platform == UnrealTargetPlatform.IOS)
        {
            PublicAdditionalLibraries.Add(Path.Combine(CryptoPPPath, "lib", "IOS", "libcryptopp.a"));
        }
        if (Target.Platform == UnrealTargetPlatform.Android)
        {
            PublicAdditionalLibraries.Add(Path.Combine(CryptoPPPath, "lib", "Android", "armeabi-v7a", "libcryptopp.a"));
            PublicAdditionalLibraries.Add(Path.Combine(CryptoPPPath, "lib", "Android", "arm64-v8a", "libcryptopp.a"));
            PublicAdditionalLibraries.Add(Path.Combine(CryptoPPPath, "lib", "Android", "x86", "libcryptopp.a"));
            PublicAdditionalLibraries.Add(Path.Combine(CryptoPPPath, "lib", "Android", "x86_64", "libcryptopp.a"));
        }
        if (Target.Platform == UnrealTargetPlatform.Linux)
        {
            PublicAdditionalLibraries.Add(Path.Combine(CryptoPPPath, "lib", "Linux", "libcryptopp.a"));
        }
    }
}
