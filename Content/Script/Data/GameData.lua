local pb = require("pb")

GameData = Class()

function GameData:Init()
    EventMgr:RegEvent("s2c_result_msg", self, self.s2c_result_msg)
    EventMgr:RegEvent("s2c_notify_enter_world", self, self.s2c_notify_enter_world)
end

-- int32 err_id = 1;
-- int32 flag = 2;			// flag:普通返回为 0， gm命令返回为 1
function GameData:s2c_result_msg(Msg)
    NotifyMsg("error : " .. Msg.err_id)
end

-- int64 server_cur_time = 2;
-- int32 game_type = 3;
function GameData:s2c_notify_enter_world(Msg)
    self.ServerTimeOffset = Msg.server_cur_time - os.time()
end

function GameData:GetServerTime()
    return self.ServerTimeOffset + os.time()
end

GameData:Init()