--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

---@class UI_PlayerProperty
local UI_PlayerProperty = Class()

--function UI_PlayerProperty:Initialize(Initializer)
--end

--function UI_PlayerProperty:PreConstruct(IsDesignTime)
--end

function UI_PlayerProperty:Construct()
    EventMgr:RegEvent("s2c_player_properties_update", self, self.s2c_player_properties_update)
end

function UI_PlayerProperty:SetPropertyType(EPlayerPropertiesName)
    self.PropertyType = EPlayerProperties[EPlayerPropertiesName]
    self.Text_Title:SetText(EPlayerPropertiesName)
    self:UpdateProperty()
end

function UI_PlayerProperty:UpdateProperty()
    self.Text_Value:SetText(PlayerData:GetProperty(self.PropertyType))
end

function UI_PlayerProperty:s2c_player_properties_update(Msg)
    for _, _t in pairs(Msg.player_properties) do
        for i, v in pairs(_t) do
            if self.PropertyType == i then
                self:PlayAnimation(self.Hint)
                self:UpdateProperty()
                return
            end
        end
    end
end

function UI_PlayerProperty:Destruct()
    print("UI_PlayerProperty Destruct")
    EventMgr:UnRegEvent("s2c_player_properties_update", self)
    self:Release()
end

return UI_PlayerProperty
