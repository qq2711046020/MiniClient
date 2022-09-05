return {
    name = "PlayerPropertiesConfig",
    properties = {
        {id = 1, name = "name", type = "string", default = ""},                             -- 玩家名字
        {id = 2, name = "create_time", type = "integer", default = 0},                      -- 创建角色时间
        {id = 3, name = "last_login_time", type = "integer", default = 0},                  -- 最后登入时间
        {id = 4, name = "last_logout_time", type = "integer", default = 0},                 -- 上次登出时间
        {id = 5, name = "level", type = "integer", default = 1},                            -- 玩家等级
		{id = 7, name = "icon", type = "integer", default = 0},                             -- 玩家头像
        {id = 8, name = "profession", type = "integer", default = 0},                       -- 职业
        {id = 9, name = "conch", type = "integer", default = 0},                            -- 贝壳
        {id = 10, name = "starfish", type = "integer", default = 0},                        -- 海星
        {id = 11, name = "pearl", type = "integer", default = 0},                           -- 珍珠
        {id = 12, name = "newfans", type = "integer", default = 0},                         -- 新粉丝数量
        {id = 13, name = "shop_refresh_num", type = "integer", default = 0},                -- 黑市已刷新次数
        {id = 14, name = "next_shop_refresh_time", type = "integer", default = 0},          -- 黑市下次刷新时间
        {id = 15, name = "exp", type = "integer", default = 0},                             -- 经验
        {id = 16, name = "daily_reward_id", type = "integer", default = 0},                 -- 每日任务积分奖励id（DailyQuest表的id）
        {id = 17, name = "daily_quest_score", type = "integer", default = 0},               -- 每日任务积分
        {id = 18, name = "week_reward_id", type = "integer", default = 0},                  -- 每周任务积分奖励id（WeekQuest表的id）
        {id = 19, name = "week_quest_score", type = "integer", default = 0},                -- 每周任务积分
        {id = 20, name = "wishpool_id", type = "integer", default = 0},                     -- 当前许愿奖励id（WishpoolReward表的id）
        {id = 21, name = "wishpool_score", type = "integer", default = 0},                  -- 许愿值
        {id = 22, name = "next_daily_refresh_time", type = "integer", default = 0},         -- 下次每日任务刷新时间
        {id = 23, name = "next_week_refresh_time", type = "integer", default = 0},          -- 下次每周任务刷新时间 
        {id = 24, name = "last_login_logic_time", type = "integer", default = 0},           -- 上次触发登录逻辑的时间
        {id = 25, name = "talent_point", type = "integer", default = 0},                    -- 天赋点数
        {id = 26, name = "attr_point", type = "integer", default = 0},                      -- 未分配的属性点
        {id = 27, name = "attr_point1", type = "integer", default = 0},                     -- 主属性属性点
        {id = 28, name = "attr_point2", type = "integer", default = 0},                     -- 体能属性点
        {id = 29, name = "attr_point3", type = "integer", default = 0},                     -- 技巧属性点
		{id = 30, name = "pet_research_level", type = "integer", default = 1},              -- 宠物研究等级
        {id = 31, name = "adventure_next_refresh_time", type = "integer", default = 0},     -- 探险点下次刷新时间
        {id = 32, name = "reset_point_count", type = "integer", default = 0},               -- 已重置属性点次数
        {id = 33, name = "is_ever_reset_point", type = "boolean", default = false},         -- 是否重置过属性点
        {id = 34, name = "map_loot_field", type = "string", default = ""},                  -- 关卡掉落
        {id = 35, name = "main_progress", type = "integer", default = 0},                   -- 地图进度
        {id = 36, name = "catch_status", type = "integer", default = 1},                    -- 捕捉状态
        {id = 37, name = "put_food_id", type = "integer", default = 0},                     -- 捕捉投放的美食id
        {id = 38, name = "catch_deadline_time", type = "integer", default = 0},             -- 捕捉截止时间
        {id = 39, name = "catch_type", type = "integer", default = 0},                      -- 捕捉类型 美食捕捉\盛宴捕捉
        {id = 40, name = "fight_pet", type = "integer", default = 0},                       -- 当前出战宠物id
        {id = 41, name = "combat_value", type = "integer", default = 0},                    -- 战斗力
        {id = 42, name = "theme_action_id", type = "integer", default = 0},                 -- 主题动作ID
        {id = 43, name = "theme_border_id", type = "integer", default = 0},                 -- 主题边框ID
        {id = 44, name = "theme_background_id", type = "integer", default = 0},             -- 主题背景ID
        {id = 45, name = "icon_border_id", type = "integer", default = 0},                  -- 头像边框ID
        {id = 46, name = "chat_bubble_id", type = "integer", default = 0},                  -- 聊天气泡ID
        {id = 47, name = "title_id", type = "integer", default = 0},                        -- 称号ID
        {id = 48, name = "address", type = "integer", default = 0},                         -- 地理位置ID
        {id = 49, name = "gender", type = "integer", default = 1},                          -- 性别
        {id = 50, name = "achievement_level", type = "integer", default = 0},               -- 成就等级
        {id = 51, name = "fashion_coin", type = "integer", default = 0},                    -- 时装货币
        {id = 52, name = "clan_coin", type = "integer", default = 0},                       -- 部落货币
        {id = 53, name = "token_level", type = "integer", default = 0},                     -- 令牌等级
        {id = 54, name = "island_adventure_next_refresh_time", type = "integer", default = 0},     -- 佣兽岛探险点下次刷新时间
        {id = 55, name = "skill_basic", type = "integer", default = 0},                     -- 技能系统开放赠送技能卡
    },
}
 