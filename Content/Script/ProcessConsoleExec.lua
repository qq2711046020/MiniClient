local FuncMap = {}

local function traceback(err)
    print("LUA ERROR: " .. tostring(err))
    print(debug.traceback())
end

local function SplitStr(str, separator)
    separator = separator or "%s"
    local result = {}
    string.gsub(str, '[^' .. separator ..']+', function (word)
        table.insert(result, word)
    end)
    return result;
end


function ProcessConsoleExec(Cmd)
    local args = SplitStr(Cmd)
    local funcName = table.remove(args, 1)--args[1]
    if not funcName then return false end
    funcName = string.lower(funcName)
    if FuncMap[funcName] then
        xpcall(FuncMap[funcName], traceback, args)
        return true
    else
        return false
    end
end

function FuncMap.test()
    require("socket.core")
    NotifyMsg("Test")
end

function FuncMap.reloadLua()
    UE4.UUnLuaFunctionLibrary.HotReload()
end

function FuncMap.luadebug()
    require("LuaPanda").start()
end

function FuncMap.send(args) -- send c2s_modify_player_name {name="newname"}
    local cmd = table.remove(args, 1)
    local argStr = table.concat(args, "")
    local result, Msg = pcall(load("return " .. argStr))
    if result then
        NetMgr:SendMessage(cmd, Msg)
    end
end

function FuncMap.gm(args) -- gm add_item 2 100
    local cmd = table.remove(args, 1)
    NetMgr:SendMessage("c2s_gm_cmd", {cmd = cmd, args = args})
end