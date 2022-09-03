--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

require "UnLua"

local function basicSerialize (o)
    local so = tostring(o)
    if type(o) == "number" or type(o) == "boolean" then
        return so
    else
        return string.format("%q", so)
    end
end

local function TableToString(t, prefix)
	local cart = ""
	local function addtocart (value, name, indent, saved, field)
		indent = indent or ""
		saved = saved or {}
		field = field or name
		cart = cart .. indent .. field
		if type(value) ~= "table" then
			cart = cart .. " = " .. basicSerialize(value) .. ",\n"
		else
			if saved[value] then
				cart = cart .. " = {}, -- " .. saved[value]
							.. " (self reference)\n"
				autoref = autoref ..  name .. " = " .. saved[value] .. ",\n"
			else
				saved[value] = name
				if not next(value) then
					cart = cart .. " = {},\n"
				else
					cart = cart .. " = {\n"
					for k, v in pairs(value) do
						k = basicSerialize(k)
						local fname = string.format("%s[%s]", name, k)
						field = string.format("[%s]", k)
						addtocart(v, fname, indent .. "\t", saved, field)
					end
					cart = cart .. indent .. "},\n"
				end
			end
		end
	end
    addtocart(t, prefix)
    return cart .. "\n\n"
end

---@class UI_Login
local UI_Login = Class()

function UI_Login:Construct()
    self.Button_Test.OnClicked:Add(self, self.OnClicked_Test)
    self.Button_Test_1.OnClicked:Add(self, self.OnClicked_Test_1)
    self.Button_Test_2.OnClicked:Add(self, self.OnClicked_Test_2)
    self.Button_Test_3.OnClicked:Add(self, self.OnClicked_Test_3)
    NetMgr:RegEvent("OnRecvMsg", self, self.OnRecvMsg)
end

function UI_Login:OnClicked_Test()
    NetMgr:Connect("140.143.246.73" , 10100)
end

function UI_Login:OnClicked_Test_1()
    NetMgr:SendMessage("c2s_user_auth", {user_id = "cjh001@100", token = "123"})
end

function UI_Login:OnClicked_Test_2()
    NetMgr:SendMessage("c2s_query_player_list")
end

function UI_Login:OnClicked_Test_3()
    NetMgr:SendMessage("c2s_enter_world", {player_id = 9432701205947492})
end

function UI_Login:OnRecvMsg(InMessageType, InMessage)
    local s = self.Text_Msg:GetText() .. TableToString(InMessage, InMessageType)
    self.Text_Msg:SetText(s)
end

return UI_Login
