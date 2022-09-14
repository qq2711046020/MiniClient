local UnrealNet = require("UnrealNet")
local pb = require("pb")
NetMgr = Class()
--测试用服务器1
NetMgr.IP = "140.143.246.73"
NetMgr.Port = 10100
NetMgr.Subfix = "@100"

--[[
--Server_V0.1.0
    NetMgr.IP = "140.143.246.73"
    NetMgr.Port = 10200
    NetMgr.Subfix = "@1"

--Internal_CSL
    NetMgr.IP = "192.168.1.66"
    NetMgr.Port = 10100
    NetMgr.Subfix = "@201"

--测试用服务器2
    NetMgr.IP = "192.168.1.6"
    NetMgr.Port = 10100
    NetMgr.Subfix = "@9201"

--Inter
    NetMgr.IP = "140.143.246.73"
    NetMgr.Port = 10200
    NetMgr.Subfix = "@101"

--测试用服务器1
    NetMgr.IP = "140.143.246.73"
    NetMgr.Port = 10100
    NetMgr.Subfix = "@100"

--Internal_GS
    NetMgr.IP = "192.168.1.21"
    NetMgr.Port = 10100
    NetMgr.Subfix = "@213"

--Internal_Cjh
    NetMgr.IP = "192.168.1.206"
    NetMgr.Port = 10100
    NetMgr.Subfix = "@206"

--Internal_Bing
    NetMgr.IP = "192.168.1.131"
    NetMgr.Port = 10500
    NetMgr.Subfix = "@55"
]]


local current_path = UE4.UKismetSystemLibrary.GetProjectDirectory()
local logFile = current_path .. "Saved/MsgDump.log"

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

function NetMgr:Create()
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
    UnrealNet.Close(self._connect_id)
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

    print("OnRecv:" .. StrMessageType)
    local dumpMsg = TableToString(TableMessage, StrMessageType)
    local f = io.open(logFile, 'a+')
    f:write(dumpMsg)
    f:flush()
    f:close()
    EventMgr:Call(StrMessageType, TableMessage)
end

function NetMgr:OnRecvTestPing(InPingInMS)
    print("OnRecvTestPing:" .. InPingInMS)
end

NetMgr:Create()