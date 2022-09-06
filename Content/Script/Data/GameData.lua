local pb = require("pb")

GameData = Class()

function GameData:Init()
    EventMgr:RegEvent("s2c_notify_enter_world", self, self.s2c_notify_enter_world)
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