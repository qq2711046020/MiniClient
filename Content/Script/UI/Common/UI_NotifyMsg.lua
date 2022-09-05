--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

---@class UI_NotifyMsg
local UI_NotifyMsg = Class()

--function UI_NotifyMsg:Initialize(Initializer)
--end

--function UI_NotifyMsg:PreConstruct(IsDesignTime)
--end

-- function UI_NotifyMsg:Construct()
-- end

--function UI_NotifyMsg:Tick(MyGeometry, InDeltaTime)
--end

function UI_NotifyMsg:SetMsg(Msg)
    self.Text_Msg:SetText(Msg)
    self:PlayAnimation(self.Fade)
end

function UI_NotifyMsg:OnAnimationFinished(Animation)
    if Animation == self.Fade then
        self:RemoveFromViewport()
    end
end

function UI_NotifyMsg:Destruct()
    print("UI_NotifyMsg Destruct")
    self:Release()
end

return UI_NotifyMsg
