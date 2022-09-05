--
-- DESCRIPTION
--
-- @COMPANY **
-- @AUTHOR **
-- @DATE ${date} ${time}
--

---@class ClassName
local UI_Base = Class()

function UI_Base:Construct()
    self.Event = {}
end

function UI_Base:RegEvent(EventName)
    self.Event[EventName] = true
    EventMgr:RegEvent(EventName, self, self[EventName])
end

function UI_Base:Destruct()
    print(self:GetName() .. " Destruct")
    for EventName in pairs(self.Event) do
        EventMgr:UnRegEvent(EventName, self)
    end
    self:Release()
end

function UI_Base:SpawnListViewObject()
    return self:CreateObject("Blueprint'/Game/UI/Common/ListViewLuaObject.ListViewLuaObject_C'")
end

function UI_Base:CreateObject(Path)
    return NewObject(LoadClass(Path), self)
end

return UI_Base