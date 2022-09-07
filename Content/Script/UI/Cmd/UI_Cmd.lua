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

function UI_Cmd:OnSelectMsg(SelectedItem, SelectionType)
    if SelectionType == UE4.ESelectInfo.Direct then return end
    if self.ComboBox_Msg:GetSelectedIndex() == 0 then return end
    local function GetFields(msgType, t)
        for _name, _number, _type in pb.fields(msgType) do
            if not _type:find("%.") then
                t[_name] = _type
            else
                t[_name] = {}
                GetFields(_type, t[_name])
            end
        end
    end
    local Msg = {}
    GetFields(SelectedItem, Msg)
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
