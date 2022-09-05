--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

---@class UI_PlayerProperty
local UI_PlayerProperty = Class("UI.UI_Base")

function UI_PlayerProperty:Construct()
    self.Super.Construct(self)

    self:RegEvent("PlayerPropertyUpdate")
end

function UI_PlayerProperty:SetPropertyType(EPlayerPropertiesName)
    self.PropertyType = EPlayerProperties[EPlayerPropertiesName]
    self.Text_Title:SetText(EPlayerPropertiesName)
    self:UpdateProperty()
end

function UI_PlayerProperty:UpdateProperty()
    self.Text_Value:SetText(PlayerData:GetProperty(self.PropertyType))
end

function UI_PlayerProperty:PlayerPropertyUpdate(PropertyType)
    if self.PropertyType == PropertyType then
        self:PlayAnimation(self.Hint)
        self:UpdateProperty()
    end
end

return UI_PlayerProperty
