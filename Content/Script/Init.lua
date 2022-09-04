--require "UnLua"
local protoc = require("Thirdparty.protoc")
assert(protoc:load(require("NetMessage.proto")))

require("NetMessage.NetMgr")
require("Utils.LocalConfig")
require("Utils.BaseFunction")
-- Data
require("Data.PlayerData")