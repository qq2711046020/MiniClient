local pb = require("pb")

PlayerData = Class()

EPlayerProperties = {
    name = 1,		-- 玩家名字
    create_time = 2,		-- 创建角色时间
    last_login_time = 3,		-- 最后登入时间
    last_logout_time = 4,		-- 上次登出时间
    level = 5,		-- 玩家等级
    icon = 7,		-- 玩家头像
    profession = 8,		-- 职业
    conch = 9,		-- 贝壳
    starfish = 10,		-- 海星
    pearl = 11,		-- 珍珠
    newfans = 12,		-- 新粉丝数量
    shop_refresh_num = 13,		-- 黑市已刷新次数
    next_shop_refresh_time = 14,		-- 黑市下次刷新时间
    exp = 15,		-- 经验
    daily_reward_id = 16,		-- 每日任务积分奖励id（DailyQuest表的id）
    daily_quest_score = 17,		-- 每日任务积分
    week_reward_id = 18,		-- 每周任务积分奖励id（WeekQuest表的id）
    week_quest_score = 19,		-- 每周任务积分
    wishpool_id = 20,		-- 当前许愿奖励id（WishpoolReward表的id）
    wishpool_score = 21,		-- 许愿值
    next_daily_refresh_time = 22,		-- 下次每日任务刷新时间
    next_week_refresh_time = 23,		-- 下次每周任务刷新时间 
    last_login_logic_time = 24,		-- 上次触发登录逻辑的时间
    talent_point = 25,		-- 天赋点数
    attr_point = 26,		-- 未分配的属性点
    attr_point1 = 27,		-- 主属性属性点
    attr_point2 = 28,		-- 体能属性点
    attr_point3 = 29,		-- 技巧属性点
    pet_research_level = 30,		-- 宠物研究等级
    adventure_next_refresh_time = 31,		-- 探险点下次刷新时间
    reset_point_count = 32,		-- 已重置属性点次数
    is_ever_reset_point = 33,		-- 是否重置过属性点
    map_loot_field = 34,		-- 关卡掉落
    main_progress = 35,		-- 地图进度
    catch_status = 36,		-- 捕捉状态
    put_food_id = 37,		-- 捕捉投放的美食id
    catch_deadline_time = 38,		-- 捕捉截止时间
    catch_type = 39,		-- 捕捉类型 美食捕捉\盛宴捕捉
    fight_pet = 40,		-- 当前出战宠物id
    combat_value = 41,		-- 战斗力
    theme_action_id = 42,		-- 主题动作ID
    theme_border_id = 43,		-- 主题边框ID
    theme_background_id = 44,		-- 主题背景ID
    icon_border_id = 45,		-- 头像边框ID
    chat_bubble_id = 46,		-- 聊天气泡ID
    title_id = 47,		-- 称号ID
    address = 48,		-- 地理位置ID
    gender = 49,		-- 性别
    achievement_level = 50,		-- 成就等级
    fashion_coin = 51,		-- 时装货币
    clan_coin = 52,		-- 部落货币
    token_level = 53,		-- 令牌等级
    island_adventure_next_refresh_time = 54,		-- 佣兽岛探险点下次刷新时间
    skill_basic = 55,		-- 技能系统开放赠送技能卡
}

function PlayerData:Init()
    self.PlayerProperties = {}
    local PlayerPropertiesConfig = require("Properties.PlayerPropertiesConfig")
    for i, v in pairs(PlayerPropertiesConfig.properties) do
        self.PlayerProperties[i] = v.default
    end

    EventMgr:RegEvent("s2c_notify_enter_world", self, self.s2c_notify_enter_world)
    EventMgr:RegEvent("s2c_notify_player_data", self, self.s2c_notify_player_data)
    EventMgr:RegEvent("s2c_player_properties_update", self, self.s2c_player_properties_update)
end

function PlayerData:GetProperty(EPlayerProperties)
    return self.PlayerProperties[EPlayerProperties]
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
    self:UpdateProperties(Msg.player.player_properties)
end

function PlayerData:s2c_player_properties_update(Msg)
    self:UpdateProperties(Msg.player_properties)
end

function PlayerData:UpdateProperties(player_properties)
    for _, _t in pairs(player_properties) do
        for i, v in pairs(_t) do
            self.PlayerProperties[i] = v
            EventMgr:Call("PlayerPropertyUpdate", i)
        end
    end
end

PlayerData:Init()