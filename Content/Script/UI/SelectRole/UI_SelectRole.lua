--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

require "UnLua"

---@class UI_SelectRole
local UI_SelectRole = Class()

--function UI_SelectRole:Initialize(Initializer)
--end

--function UI_SelectRole:PreConstruct(IsDesignTime)
--end

function UI_SelectRole:Construct()
    self.Button_CreateRole.OnClicked:Add(self, self.OnClicked_CreateRole)
    NetMgr:RegEvent("s2c_ret_query_player_list", self, self.s2c_ret_query_player_list)
    NetMgr:RegEvent("s2c_ret_create_player", self, self.s2c_ret_create_player)
    NetMgr:RegEvent("s2c_notify_enter_world", self, self.s2c_notify_enter_world)
    NetMgr:SendMessage("c2s_query_player_list")
end

-- repeated mini_player_data_t players = 1;		// 玩家列表
function UI_SelectRole:s2c_ret_query_player_list(Msg)
    self.ListView_Role:ClearListItems()
    for i, v in ipairs(Msg.players) do
        local Item = self:SpawnListViewObject(v)
        self.ListView_Role:AddItem(Item)
    end
end

-- mini_player_data_t player = 1;
function UI_SelectRole:s2c_ret_create_player(Msg)
    local Item = self:SpawnListViewObject(Msg.player)
    self.ListView_Role:AddItem(Item)
end

-- int64 server_cur_time = 2;
-- int32 game_type = 3;
function UI_SelectRole:s2c_notify_enter_world(Msg)
    self:RemoveFromViewport()
    G_PlayerController:OpenMainUI()
end

function UI_SelectRole:OnClicked_CreateRole()
    local Profession = tonumber(self.ComboBox_Profession:GetSelectedOption())
	local Name = self.Text_Name:GetText()
    NetMgr:SendMessage("c2s_create_player", {profession = Profession, name = Name})
end

function UI_SelectRole:SpawnListViewObject(mini_player_data_t)
    local Item = NewObject(LoadClass("Blueprint'/Game/UI/Common/ListViewLuaObject.ListViewLuaObject_C'"), self)
    for k, v in pairs(mini_player_data_t) do
        Item[k] = v
    end
    return Item
end

function UI_SelectRole:Destruct()
    print("UI_SelectRole Destruct")
    NetMgr:UnRegEvent("s2c_ret_query_player_list", self)
    NetMgr:UnRegEvent("s2c_ret_create_player", self)
    NetMgr:UnRegEvent("s2c_notify_enter_world", self)
    self:Release()
end

return UI_SelectRole
