--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

---@class Map_Main
local Map_Main = Class()

--function Map_Main:Initialize(Initializer)
--end

--function Map_Main:UserConstructionScript()
--end

function Map_Main:ReceiveBeginPlay()
    G_PlayerController = UE4.UGameplayStatics.GetPlayerController(self, 0)
    G_PlayerController:OpenLoginUI()
end

--function Map_Main:ReceiveEndPlay()
--end

-- function Map_Main:ReceiveTick(DeltaSeconds)
-- end

--function Map_Main:ReceiveAnyDamage(Damage, DamageType, InstigatedBy, DamageCauser)
--end

--function Map_Main:ReceiveActorBeginOverlap(OtherActor)
--end

--function Map_Main:ReceiveActorEndOverlap(OtherActor)
--end

return Map_Main
