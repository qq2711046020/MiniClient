--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

---@class UI_NotifyMsg
local UI_NotifyMsg = Class("UI.UI_Base")

function UI_NotifyMsg:Construct()
    self.Super.Construct(self)
end

function UI_NotifyMsg:SetMsg(Msg)
    self.Text_Msg:SetText(Msg)
    self:PlayAnimation(self.Fade)
end

function UI_NotifyMsg:OnAnimationFinished(Animation)
    if Animation == self.Fade then
        self:RemoveFromViewport()
    end
end

return UI_NotifyMsg
