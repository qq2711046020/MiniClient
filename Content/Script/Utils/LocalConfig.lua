---@class LocalConfig
local LocalConfig = Class()

local CommonSection = "Common"
local ConfigFile = "/Saved/CommonConfig.ini"

--[[
    Section 可以不传，默认为CommonSection
    LocalConfig:GetValue(Key, Section)
    LocalConfig:SetValue(Key, Value, Section)
]]

function LocalConfig:GetValue(Key, Section)
    Section = Section or CommonSection
    local res = UE4.USupportLibrary.GetLocalConfig(
        Section, Key, ConfigFile)
    return res
end

function LocalConfig:SetValue(Key, Value, Section)
    Section = Section or CommonSection
    UE4.USupportLibrary.SetLocalConfig(
        Section, Key, Value, ConfigFile)
end

return LocalConfig