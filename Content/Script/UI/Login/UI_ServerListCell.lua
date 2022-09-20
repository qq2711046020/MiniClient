--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

---@class UI_ServerListCell
local UI_ServerListCell = Class("UI.UI_Base")

--function UI_ServerListCell:Tick(MyGeometry, InDeltaTime)
--end

function UI_ServerListCell:Construct()
    self.Super.Construct(self)
end

function UI_ServerListCell:OnListItemObjectSet(Item)
    self.Text_ServerName:SetText(Item.GroupName .. " " .. Item.Name)
    local bIsSelected = UE4.UUserListEntryLibrary.IsListItemSelected(self)
    self:UpdateSelectedUI(bIsSelected)
end

function UI_ServerListCell:BP_OnItemSelectionChanged(bIsSelected)
    self:UpdateSelectedUI(bIsSelected)
end

function UI_ServerListCell:UpdateSelectedUI(bIsSelected)
    self.Border_BG:SetIsEnabled(not bIsSelected)
end


return UI_ServerListCell
