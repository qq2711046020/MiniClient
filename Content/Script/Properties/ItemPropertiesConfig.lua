return {
    name = "ItemPropertiesConfig",
    properties = {
        {id = 1, name = "count", type = "integer", default = 0},
        {id = 2, name = "lock", type = "integer", default = 0},                 -- 是否锁定
        {id = 3, name = "base_attr_value", type = "integer", default = 0},      -- 装备基础属性值
        {id = 4, name = "intensify_level", type = "integer", default = 0},      -- 装备强化等级
        {id = 5, name = "process_count", type = "integer", default = 0},        -- 宝石已加工次数
        {id = 6, name = "max_process_count", type = "integer", default = 0},    -- 宝石最大可加工次数
        {id = 7, name = "best_slot", type = "integer", default = 0},            -- 宝石最佳装备部位
        {id = 8, name = "durability", type = "integer", default = 0},           -- 耐久度
        {id = 9, name = "original_or_gem_id", type = "integer", default = 0},   -- template_id(当作为原石时表示宝石ID,当作为宝石时作为原石ID)
    },
}