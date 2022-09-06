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
    for _name, _basename, _type in pb.types() do
        if _name:find("c2s") then
            self.ComboBox_Msg:AddOption(_basename)
        end
    end
    self.ComboBox_Msg.OnSelectionChanged:Add(self, self.OnSelectMsg)
    self.Button_Send.OnClicked:Add(self, self.OnClicked_Send)
end

function UI_Cmd:OnSelectMsg(SelectedItem)
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
        NetMgr:SendMessage(self.ComboBox_Msg:GetSelectedOption(), Msg)
    else
        print(result)
    end
end

return UI_Cmd
