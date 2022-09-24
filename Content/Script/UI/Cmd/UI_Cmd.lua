--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

---@class UI_Cmd
local UI_Cmd = Class("UI.UI_Base")

local pb = require("pb")
local serpent = require("Thirdparty.serpent")
--function UI_Cmd:Tick(MyGeometry, InDeltaTime)
--end

function UI_Cmd:Construct()
    self.Super.Construct(self)

    -- proto
    local showList = {}
    for _name, _basename, _type in pb.types() do
        if _basename:find("c2s") then
            table.insert(showList, _basename)
        end
    end
    table.sort(showList)
    for i, v in ipairs(showList) do
        self.ComboBox_Msg:AddOption(v)
    end

    -- history
    local tList = self:LoadHistory()
    for i, v in ipairs(tList) do
        self:AddHistoryItem(v.MsgType, v.MsgStr)
    end

    self.ComboBox_Msg.OnSelectionChanged:Add(self, self.OnSelectMsg)
    self.ListView_History.BP_OnItemClicked:Add(self, self.OnClicked_History)
    self.Button_Mask.OnClicked:Add(self, self.OnClicked_Mask)
    self.Button_Send.OnClicked:Add(self, self.OnClicked_Send)
    self.Button_Close.OnClicked:Add(self, self.OnClicked_Close)
    self.Button_Clear.OnClicked:Add(self, self.OnClicked_Clear)
end

function UI_Cmd:OnClicked_History(Object)
    self.ComboBox_Msg:SetSelectedOption(Object.MsgType)
    self.Text_Msg:SetText(Object.MsgStr)
end

function UI_Cmd:AddHistoryItem(MsgType, MsgStr)
    local Item = self:SpawnListViewObject()
    Item.MsgType = MsgType
    Item.MsgStr = MsgStr
    self.ListView_History:AddItem(Item)
end

function UI_Cmd:ClearHistoryItems()
    self.ListView_History:ClearListItems()
end

function UI_Cmd:SaveHistory()
    local ListItems = self.ListView_History:GetListItems():ToTable()
    local tList = {}
    for i, Item in ipairs(ListItems) do
        tList[i] = {
            MsgType = Item.MsgType,
            MsgStr = Item.MsgStr
        }
    end
    local str = serpent.line(tList)
    LocalConfig:SetValue("History", str, "Cmd")
end

function UI_Cmd:LoadHistory()
    local str = LocalConfig:GetValue("History", "Cmd")
    if not str or str == "" then return {} end
    local result, tList = pcall(load("return " .. str))
    if result then
        return tList
    else
        print(result)
        return {}
    end
end

local function create_default(type)
    local function _default(type)
        local lua_table = pb.decode(type)
        if not lua_table then
            error("lua-protobuf create default fail. type = " .. type)
            return
        end

        for name, tag, subtype in pb.fields(type) do
            print(name, tag, subtype, pb.type(subtype))
            if not lua_table[name] then
                local sname, _, sty = pb.type(subtype)
                if sty =="message" and sname ~= type then
                    -- 只支持 message，且不支持循环嵌套
                    lua_table[name] = _default(subtype)
                end
            end
        end
        return lua_table
    end

    return _default(type)
end

function UI_Cmd:OnSelectMsg(SelectedItem, SelectionType)
    if SelectionType == UE4.ESelectInfo.Direct then return end
    if self.ComboBox_Msg:GetSelectedIndex() == 0 then return end

    local Msg = create_default(SelectedItem)
    self.Text_Msg:SetText(serpent.block(Msg))
end

function UI_Cmd:OnClicked_Send()
    if self.ComboBox_Msg:GetSelectedIndex() == 0 then return end
    local str = self.Text_Msg:GetText()
    local result, Msg = pcall(load("return " .. str))
    if result then
        local MsgType = self.ComboBox_Msg:GetSelectedOption()
        NetMgr:SendMessage(MsgType, Msg)
        self:AddHistoryItem(MsgType, str)
    else
        print(result)
    end
end

function UI_Cmd:OnClicked_Mask()
    self:RemoveFromViewport()
end

function UI_Cmd:OnClicked_Close()
    self:RemoveFromViewport()
end

function UI_Cmd:OnClicked_Clear()
    self:ClearHistoryItems()
end

function UI_Cmd:Destruct()
    self:SaveHistory()
    self.Super.Destruct(self)
end

return UI_Cmd
