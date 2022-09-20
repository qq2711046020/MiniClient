--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

---@class UI_Login
local UI_Login = Class("UI.UI_Base")

function UI_Login:Construct()
	self.Super.Construct(self)
	self.Text_UserID:SetText(LocalConfig:GetValue("UserID", "Login"))
	self.Text_Token:SetText(LocalConfig:GetValue("Token", "Login"))
    self.Button_Login.OnClicked:Add(self, self.OnClicked_Login)
    self.ListView_ServerList.BP_OnItemClicked:Add(self, self.OnClicked_Server)

	self:RegEvent("s2c_ret_user_auth")

    local LastSelectedServerID = tonumber(LocalConfig:GetValue("Server", "Login"))
    local SelectedIndex = 1
    for i, Info in ipairs(NetMgr.ServerList) do
        local Item = self:SpawnListViewObject()
        for k, v in pairs(Info) do
            Item[k] = v
        end
        self.ListView_ServerList:AddItem(Item)
        if Item.ZoneID == LastSelectedServerID then
            SelectedIndex = i
        end
    end
    self.ListView_ServerList:SetSelectedIndex(SelectedIndex - 1)
end

function UI_Login:OnClicked_Server(Item)

end

function UI_Login:OnClicked_Login()
    local ServerItem = self.ListView_ServerList:BP_GetSelectedItem()
    LocalConfig:SetValue("Server", ServerItem.ZoneID, "Login")
    NetMgr:Connect(ServerItem.IP, ServerItem.Port)
    self:StartTimer("InnerLogin", {self, self.InnerLogin}, 0.1, false)
end

function UI_Login:InnerLogin()
    local ServerItem = self.ListView_ServerList:BP_GetSelectedItem()
    local UserID = self.Text_UserID:GetText()
	local Token = self.Text_Token:GetText()
	LocalConfig:SetValue("UserID", UserID, "Login")
	LocalConfig:SetValue("Token", Token, "Login")
    local user_id = string.format("%s@%s", UserID, ServerItem.ZoneID)
    NetMgr:SendMessage("c2s_user_auth", {user_id = user_id, token = Token})
end

-- bool is_queue_up = 1;		// 是否需要排队进入
-- int64 queue_size = 2;		// 总排队人数 （is_queue_up 为 true 是有效）
-- int64 my_order = 3;			// 当前玩家在排队中的位置 （is_queue_up 为 true 是有效）
function UI_Login:s2c_ret_user_auth(Msg)
	if not Msg.is_queue_up then
		self:RemoveFromViewport()
		G_PlayerController:OpenSelectRoleUI()
	else
		NotifyMsg("Is In Queue")
	end
end

return UI_Login
