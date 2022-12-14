--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

---@class UI_Main
local UI_Main = Class("UI.UI_Base")

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
    self.Super.Construct(self)
    self.Button_Logout.OnClicked:Add(self, self.OnClicked_Logout)
    self.Button_Group.OnClicked:Add(self, self.OnClicked_Group)
    self.Button_Cmd.OnClicked:Add(self, self.OnClicked_Cmd)
    self:UpdateUI()
end

function UI_Main:UpdateUI()
    self:UpdateServerTime()
    self:StartTimer("UpdateServerTime", {self, self.UpdateServerTime}, 1, true)
    self.Text_PlayerID:SetText(PlayerData.PlayerID)
    for i, v in ipairs(ShowPropertyList) do
        local widget = self:CreateObject("WidgetBlueprint'/Game/UI/Main/UI_PlayerProperty.UI_PlayerProperty_C'")
        self.VerticalBox_Properties:AddChildToVerticalBox(widget)
        widget:SetPropertyType(v)
    end
end

function UI_Main:UpdateServerTime()
    self.Text_GameTime:SetText(FormatTime(GameData:GetServerTime()))
end

function UI_Main:OnClicked_Logout()
    NetMgr:SendMessage("c2s_logout", {})
    self:RemoveFromViewport()
    G_PlayerController:OpenLoginUI()
end

function UI_Main:OnClicked_Group()
    G_PlayerController:OpenGroupUI()
end

function UI_Main:OnClicked_Cmd()
    G_PlayerController:OpenCmdUI()
end

return UI_Main