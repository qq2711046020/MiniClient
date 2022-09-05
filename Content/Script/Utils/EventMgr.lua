---@class EventMgr
EventMgr = Class()

function EventMgr:Init()
    self.Event = {}
end

function EventMgr:RegEvent(EventName, o, f)
    if not self.Event[EventName] then
        self.Event[EventName] = {}
    end
    self.Event[EventName][o] = f
end

function EventMgr:UnRegEvent(EventName, o)
    if self.Event[EventName] then
        self.Event[EventName][o] = nil
    end
end

function EventMgr:ClearEvent(EventName)
    self.Event[EventName] = nil
end

function EventMgr:Call(EventName, ...)
    if self.Event[EventName] then
        for o, f in pairs(self.Event[EventName]) do
            f(o, ...)
        end
    end
end

EventMgr:Init()