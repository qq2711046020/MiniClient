local protoc = require("Thirdparty.protoc")
assert(protoc:load(require("NetMessage.proto")))

require("Utils.EventMgr")
require("Utils.LocalConfig")
require("Utils.BaseFunction")
require("NetMessage.NetMgr")
-- Data
require("Data.PlayerData")
require("Data.GroupData")