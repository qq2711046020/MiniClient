local FuncMap = {}

local function traceback(err)
    print("LUA ERROR: " .. tostring(err))
    print(debug.traceback())
end

function ProcessConsoleExec(Cmd)
    if FuncMap[Cmd] then
        xpcall(FuncMap[Cmd], traceback)
        return true
    else
        return false
    end
end

function FuncMap.Test()
    require("socket.core")
    NotifyMsg("Test")
end

function FuncMap.ReloadLua()
    UE4.UUnLuaFunctionLibrary.HotReload()
end

function FuncMap.LuaDebug()
    require("LuaPanda").start()
end