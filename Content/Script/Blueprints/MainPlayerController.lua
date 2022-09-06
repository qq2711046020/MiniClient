--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

---@class MainPlayerController
local MainPlayerController = Class()

--function MainPlayerController:Initialize(Initializer)
--end

--function MainPlayerController:UserConstructionScript()
--end

--function MainPlayerController:ReceiveBeginPlay()
--end

function MainPlayerController:ReceiveEndPlay()
    NetMgr:SendMessage("c2s_logout", {})
end

-- function MainPlayerController:ReceiveTick(DeltaSeconds)
-- end

--function MainPlayerController:ReceiveAnyDamage(Damage, DamageType, InstigatedBy, DamageCauser)
--end

--function MainPlayerController:ReceiveActorBeginOverlap(OtherActor)
--end

--function MainPlayerController:ReceiveActorEndOverlap(OtherActor)
--end

function MainPlayerController:CreateWidget(Path, ZOrder)
    local widget_class = LoadClass(Path)
    local widget = NewObject(widget_class, self)
    widget:AddToViewport(ZOrder or 0)
    return widget
end

function MainPlayerController:NotifyMsg(Msg)
    local widget = self:CreateWidget("WidgetBlueprint'/Game/UI/Common/UI_NotifyMsg.UI_NotifyMsg_C'")
    return widget:SetMsg(Msg)
end

function MainPlayerController:OpenLoginUI()
    local widget = self:CreateWidget("WidgetBlueprint'/Game/UI/UI_Login.UI_Login_C'")
    return widget
end

function MainPlayerController:OpenSelectRoleUI()
    local widget = self:CreateWidget("WidgetBlueprint'/Game/UI/SelectRole/UI_SelectRole.UI_SelectRole_C'")
    return widget
end

function MainPlayerController:OpenMainUI()
    local widget = self:CreateWidget("WidgetBlueprint'/Game/UI/Main/UI_Main.UI_Main_C'")
    return widget
end

function MainPlayerController:OpenGroupUI()
    local widget = self:CreateWidget("WidgetBlueprint'/Game/UI/Group/UI_Group.UI_Group_C'")
    return widget
end

function MainPlayerController:OpenCmdUI()
    local widget = self:CreateWidget("WidgetBlueprint'/Game/UI/Cmd/UI_Cmd.UI_Cmd_C'")
    return widget
end

return MainPlayerController

