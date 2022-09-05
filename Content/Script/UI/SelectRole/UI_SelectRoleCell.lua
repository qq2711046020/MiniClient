--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

---@class UI_SelectRoleCell
local UI_SelectRoleCell = Class()

--function UI_SelectRoleCell:Initialize(Initializer)
--end

--function UI_SelectRoleCell:PreConstruct(IsDesignTime)
--end

function UI_SelectRoleCell:Construct()
    self.Button_Enter.OnClicked:Add(self, self.OnClicked_Enter)
end

-- // 用于创角、选角界面的玩家信息
-- message mini_player_data_t
-- {
-- 	int64 player_id = 1;
-- 	bytes name = 2;
-- 	int64 profession = 3;
-- 	int64 level = 4;
-- 	int64 last_logout_time = 5;
-- }
function UI_SelectRoleCell:OnListItemObjectSet(Item)
    self.PlayerID = Item.player_id
    self.Text_ID:SetText(Item.player_id)
    self.Text_Name:SetText(Item.name)
    self.Text_Profession:SetText(Item.profession)
    self.Text_Level:SetText(Item.level)
    self.Text_LogoutTime:SetText(Item.last_logout_time)
end

function UI_SelectRoleCell:OnClicked_Enter()
    NetMgr:SendMessage("c2s_enter_world", {player_id = self.PlayerID})
end

function UI_SelectRoleCell:Destruct()
    print("UI_SelectRoleCell Destruct")
    self:Release()
end


return UI_SelectRoleCell
