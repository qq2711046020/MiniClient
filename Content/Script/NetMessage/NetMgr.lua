local UnrealNet = require("UnrealNet")
local pb = require("pb")
NetMgr = Class()

NetMgr.ServerList = {
    [1] = {
        IP = "140.143.246.73",
        Port = 10100,
        ZoneID = 100,
        GroupName = "公共",
        Name = "主干开发"
    },
    [2] = {
        IP = "140.143.246.73",
        Port = 10200,
        ZoneID = 1,
        GroupName = "公共",
        Name = "Server_V0.1.0"
    },
    [3] = {
        IP = "192.168.1.6",
        Port = 10100,
        ZoneID = 9201,
        GroupName = "公共",
        Name = "测试用服务器2"
    },
    [4] = {
        IP = "192.168.1.66",
        Port = 10100,
        ZoneID = 201,
        GroupName = "私人",
        Name = "Internal_CSL"
    },
    [5] = {
        IP = "192.168.1.21",
        Port = 10100,
        ZoneID = 213,
        GroupName = "私人",
        Name = "Internal_GS"
    },
    [6] = {
        IP = "192.168.1.206",
        Port = 10100,
        ZoneID = 206,
        GroupName = "私人",
        Name = "Internal_Cjh"
    },
    [7] = {
        IP = "192.168.1.131",
        Port = 10500,
        ZoneID = 55,
        GroupName = "私人",
        Name = "Internal_Bing"
    },
    [8] = {
        IP = "140.143.246.73",
        Port = 10200,
        ZoneID = 101,
        GroupName = "",
        Name = "Inter"
    }
}


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

function NetMgr:Connect(IP, Port)
    self._connect_id = UnrealNet.CreateClient()
    UnrealNet.Connect(self._connect_id, IP , Port)
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