local pb = require("pb")

PlayerData = Class()

function PlayerData:Init()
    NetMgr:RegEvent("s2c_notify_enter_world", self, self.s2c_notify_enter_world)
    NetMgr:RegEvent("s2c_notify_player_data", self, self.s2c_notify_player_data)
end

-- int64 server_cur_time = 2;
-- int32 game_type = 3;
function PlayerData:s2c_notify_enter_world(Msg)
    self.ServerTime = Msg.server_cur_time
end

-- player_t player = 1;
-- group_t group = 2;
-- combat_data_t combat_data = 3;
-- main_offline_rewards_t main_offline_rewards = 4;
function PlayerData:s2c_notify_player_data(Msg)
    self.PlayerID = Msg.player.player_id
end

PlayerData:Init()