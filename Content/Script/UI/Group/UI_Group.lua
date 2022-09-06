--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

---@class UI_Group
local UI_Group = Class("UI.UI_Base")

--function UI_Group:Tick(MyGeometry, InDeltaTime)
--end

function UI_Group:Construct()
    self.Super.Construct(self)
    self.Text_JoinGroup:SetText(LocalConfig:GetValue("RequestGroupID", "Group"))
    self.Button_JoinGroup.OnClicked:Add(self, self.OnClicked_JoinGroup)
    self.Button_Close.OnClicked:Add(self, self.OnClicked_Close)

    local requested_group = GroupData.requested_group
    local s = ""
    for k, v in pairs(requested_group) do
        s = s .. string.format("id:%s, time:%s\n", k, v)
    end
    self.Text_RequestedList:SetText(s)
end

function UI_Group:OnClicked_JoinGroup()
    local GroupID = tonumber(self.Text_JoinGroup:GetText())
    LocalConfig:SetValue("RequestGroupID", GroupID, "Group")
    NetMgr:SendMessage("c2s_group_join", {id = GroupID, password = ""})
end

function UI_Group:OnClicked_Close()
    self:RemoveFromViewport()
end

return UI_Group
