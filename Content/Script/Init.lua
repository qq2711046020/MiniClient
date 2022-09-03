--require "UnLua"
local protoc = require("Thirdparty.protoc")
assert(protoc:load(require("NetMessage.proto")))
require("NetMessage.NetMgr")