--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

---@class UI_CmdHistoryCell
local UI_CmdHistoryCell = Class("UI.UI_Base")

--function UI_CmdHistoryCell:Tick(MyGeometry, InDeltaTime)
--end

function UI_CmdHistoryCell:Construct()
    self.Super.Construct(self)
    self.Button_Delete.OnClicked:Add(self, self.OnClicked_Delete)
end

function UI_CmdHistoryCell:OnListItemObjectSet(Item)
    self.Text_MsgType:SetText(Item.MsgType)
end

function UI_CmdHistoryCell:OnClicked_Delete()
    local Item = UE4.UUserObjectListEntryLibrary.GetListItemObject(self)
    UE4.UUserListEntryLibrary.GetOwningListView(self):RemoveItem(Item)
end


return UI_CmdHistoryCell
