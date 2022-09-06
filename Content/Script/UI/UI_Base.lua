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
    self.Timer = {}
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
    self:ClearTimer()
    self:Release()
end

function UI_Base:SpawnListViewObject()
    return self:CreateObject("Blueprint'/Game/UI/Common/ListViewLuaObject.ListViewLuaObject_C'")
end

function UI_Base:CreateObject(Path)
    return NewObject(LoadClass(Path), self)
end

function UI_Base:StartTimer(key, ...)
    self:StopTimer(key)
    self.Timer[key] = UE4.UKismetSystemLibrary.K2_SetTimerDelegate(...)
end

function UI_Base:StopTimer(key)
    if self.Timer[key] then
        UE4.UKismetSystemLibrary.K2_ClearTimerHandle(self, self.Timer[key])
        self.Timer[key] = nil
    end
end

function UI_Base:ClearTimer()
    for key in pairs(self.Timer) do
        self:StopTimer(key)
    end
    self.Timer = {}
end

return UI_Base