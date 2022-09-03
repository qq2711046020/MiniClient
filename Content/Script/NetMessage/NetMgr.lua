local UnrealNet = require("UnrealNet")
local pb = require("pb")
NetMgr = Class()

function NetMgr:RegUnrealNetEvent(EventName)
    UnrealNet[EventName] = function(InConnectId, ...)
        if self._connect_id == InConnectId then
            self[EventName](self, ...)
        end
    end
end

function NetMgr:RegEvent(EventName, o, f)
    self.Event[EventName] = function(...)
        f(o, ...)
    end
end


function NetMgr:Create()
    self.Event = {}
    self._connect_id = UnrealNet.CreateClient()
    UnrealNet.SetRemotePublicKey("WrapperAsset'/Game/Security/ServerRsaPublic.ServerRsaPublic'")
    self:RegUnrealNetEvent("OnConnect")
    self:RegUnrealNetEvent("OnClose")
    self:RegUnrealNetEvent("OnRecv")
    self:RegUnrealNetEvent("OnRecvTestPing")
end

function NetMgr:Connect(Ip, Port)
    UnrealNet.Connect(self._connect_id, Ip , Port)
end

function NetMgr:SendMessage(InMessageType, InMessage)
    InMessage = InMessage or {}
    local NumMessageType = pb.enum("proto_type", InMessageType)
    local BinaryMessage = pb.encode(InMessageType, InMessage)
    UnrealNet.SendMessage(self._connect_id, NumMessageType, BinaryMessage)
end

function NetMgr:OnConnect(NetConnectionState)
    print("OnConnect" .. NetConnectionState)
end

function NetMgr:OnClose()
    print("OnClose")
end

function NetMgr:OnRecv(InMessageType, InMessage)
    local StrMessageType = pb.enum("proto_type", InMessageType)
    if StrMessageType == nil then
        warn(("===========Network_OnNewMessageReceived receive unrecognized message[%d]"):format(InMessageType))
        return
    end
    print("OnRecv ", StrMessageType, InMessageType)
    local MessageTable = InMessage:ToTable();
    InMessage = string.char(table.unpack(MessageTable))
    local TableMessage = pb.decode(StrMessageType, InMessage)
    --Network_HandleMessage(self, StrMessageType, TableMessage)
    for i, v in pairs(self.Event) do
        v(StrMessageType, TableMessage)
    end
end

function NetMgr:OnRecvTestPing(InPingInMS)
    print("OnRecvTestPing:" .. InPingInMS)
end

NetMgr:Create()