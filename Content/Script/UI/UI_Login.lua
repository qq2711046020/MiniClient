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
	NetMgr:Connect()
	self.Text_UserID:SetText(LocalConfig:GetValue("UserID", "Login"))
	self.Text_Token:SetText(LocalConfig:GetValue("Token", "Login"))
    self.Button_Login.OnClicked:Add(self, self.OnClicked_Login)

	self:RegEvent("s2c_ret_user_auth")
end

function UI_Login:OnClicked_Login()
	local UserID = self.Text_UserID:GetText()
	local Token = self.Text_Token:GetText()
	LocalConfig:SetValue("UserID", UserID, "Login")
	LocalConfig:SetValue("Token", Token, "Login")
    NetMgr:SendMessage("c2s_user_auth", {user_id = UserID .. NetMgr.Subfix, token = Token})
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
