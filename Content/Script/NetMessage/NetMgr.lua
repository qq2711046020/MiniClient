local UnrealNet = require("UnrealNet")
local pb = require("pb")
NetMgr = Class()

NetMgr.IP = "140.143.246.73"
NetMgr.Port = 10100
NetMgr.Subfix = "@100"


local function basicSerialize (o)
    local so = tostring(o)
    if type(o) == "number" or type(o) == "boolean" then
        return so
    else
        return string.format("%q", so)
    end
end

local function TableToString(t, prefix)
	local cart = ""
	local function addtocart (value, name, indent, saved, field)
		indent = indent or ""
		saved = saved or {}
		field = field or name
		cart = cart .. indent .. field
		if type(value) ~= "table" then
			cart = cart .. " = " .. basicSerialize(value) .. ",\n"
		else
			if saved[value] then
				cart = cart .. " = {}, -- " .. saved[value]
							.. " (self reference)\n"
				autoref = autoref ..  name .. " = " .. saved[value] .. ",\n"
			else
				saved[value] = name
				if not next(value) then
					cart = cart .. " = {},\n"
				else
					cart = cart .. " = {\n"
					for k, v in pairs(value) do
						k = basicSerialize(k)
						local fname = string.format("%s[%s]", name, k)
						field = string.format("[%s]", k)
						addtocart(v, fname, indent .. "\t", saved, field)
					end
					cart = cart .. indent .. "},\n"
				end
			end
		end
	end
    addtocart(t, prefix)
    return cart .. "\n\n"
end

function NetMgr:RegUnrealNetEvent(EventName)
    UnrealNet[EventName] = function(InConnectId, ...)
        if self._connect_id == InConnectId then
            self[EventName](self, ...)
        end
    end
end

function NetMgr:RegEvent(EventName, o, f)
    if not self.Event[EventName] then
        self.Event[EventName] = {}
    end
    self.Event[EventName][o] = f
end

function NetMgr:UnRegEvent(EventName, o)
    if self.Event[EventName] then
        self.Event[EventName][o] = nil
    end
end

function NetMgr:Create()
    self.Event = {}
    self._connect_id = -1
    UnrealNet.SetRemotePublicKey("WrapperAsset'/Game/Security/ServerRsaPublic.ServerRsaPublic'")
    self:RegUnrealNetEvent("OnConnect")
    self:RegUnrealNetEvent("OnClose")
    self:RegUnrealNetEvent("OnRecv")
    self:RegUnrealNetEvent("OnRecvTestPing")
end

function NetMgr:Connect()
    self._connect_id = UnrealNet.CreateClient()
    UnrealNet.Connect(self._connect_id, NetMgr.IP , NetMgr.Port)
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
    local MessageTable = InMessage:ToTable();
    InMessage = string.char(table.unpack(MessageTable))
    local TableMessage = pb.decode(StrMessageType, InMessage)

    print("OnRecv:" .. TableToString(TableMessage, StrMessageType))
    if self.Event[StrMessageType] then
        for o, f in pairs(self.Event[StrMessageType]) do
            f(o, TableMessage)
        end
    end
end

function NetMgr:OnRecvTestPing(InPingInMS)
    print("OnRecvTestPing:" .. InPingInMS)
end

NetMgr:Create()