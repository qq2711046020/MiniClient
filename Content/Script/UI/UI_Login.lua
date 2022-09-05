--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

require "UnLua"

---@class UI_Login
local UI_Login = Class()

function UI_Login:Construct()
	NetMgr:Connect()
    self.Button_Login.OnClicked:Add(self, self.OnClicked_Login)
    EventMgr:RegEvent("s2c_ret_user_auth", self, self.s2c_ret_user_auth)
end

function UI_Login:OnClicked_Login()
	local UserID = self.Text_UserID:GetText() .. NetMgr.Subfix
	local Token = self.Text_Token:GetText()
    NetMgr:SendMessage("c2s_user_auth", {user_id = UserID, token = Token})
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

function UI_Login:Destruct()
    print("UI_Login Destruct")
	EventMgr:UnRegEvent("s2c_ret_user_auth", self)
    self:Release()
end

return UI_Login
