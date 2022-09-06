local pb = require("pb")

GroupData = Class()

function GroupData:Init()
    EventMgr:RegEvent("s2c_notify_player_data", self, self.s2c_notify_player_data)
    EventMgr:RegEvent("s2c_notify_update_my_request", self, self.s2c_notify_update_my_request)
end

-- player_t player = 1;
-- group_t group = 2;
-- combat_data_t combat_data = 3;
-- main_offline_rewards_t main_offline_rewards = 4;
function GroupData:s2c_notify_player_data(Msg)
    local GroupInfo = Msg.group
    self.requested_group = GroupInfo.requested_group
end

-- uint64 del_group_id				= 1;
function GroupData:s2c_notify_update_my_request(Msg)
    print(Msg.del_group_id)
end

GroupData:Init()