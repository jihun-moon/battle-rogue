using UnrealBuildTool;
using System.Collections.Generic;

public class BattleRogueServerTarget : TargetRules
{
    public BattleRogueServerTarget(TargetInfo Target)
        : base(Target)
    {
        Type = TargetType.Server;
        DefaultBuildSettings = BuildSettingsVersion.V2;
        ExtraModuleNames.Add("BattleRogue");
    }
}
