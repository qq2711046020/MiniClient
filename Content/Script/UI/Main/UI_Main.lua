--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

require "UnLua"

---@class UI_Main
local UI_Main = Class()

--function UI_Main:Initialize(Initializer)
--end

--function UI_Main:PreConstruct(IsDesignTime)
--end

local ShowPropertyList = {
    [1] = "name",
    [2] = "profession",
    [3] = "level",
    [4] = "exp",
    [5] = "main_progress",
    [6] = "conch",
    [7] = "starfish",
    [8] = "pearl",
}

function UI_Main:Construct()
    self.Button_Logout.OnClicked:Add(self, self.OnClicked_Logout)
    self:UpdateUI()
end

function UI_Main:UpdateUI()
    self.Text_PlayerID:SetText(PlayerData.PlayerID)
    for i, v in ipairs(ShowPropertyList) do
        local widget = G_PlayerController:CreateWidget("WidgetBlueprint'/Game/UI/Main/UI_PlayerProperty.UI_PlayerProperty_C'", nil, true)
        self.VerticalBox_Properties:AddChildToVerticalBox(widget)
        widget:SetPropertyType(v)
    end
end

function UI_Main:OnClicked_Logout()
    NetMgr:SendMessage("c2s_logout", {})
    self:RemoveFromViewport()
    G_PlayerController:OpenLoginUI()
end

function UI_Main:Destruct()
    print("UI_Main Destruct")
    self:Release()
end

return UI_Main