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

function UI_Main:Construct()
    self.Button_Logout.OnClicked:Add(self, self.OnClicked_Logout)
    self:UpdateUI()
end

function UI_Main:UpdateUI()
    self.Text_PlayerID:SetText(PlayerData.PlayerID)
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
