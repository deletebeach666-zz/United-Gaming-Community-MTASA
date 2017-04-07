--[[ 
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 27 March 2017
-- Script: UGCpolice/server.lua
-- Type: Server Sided
]]--

addEvent("UGCbusjob.givePlayerPayment", true)
addEventHandler("UGCbusjob.givePlayerPayment", getRootElement(), function(distance)
local payment = exports.UGCemployment:getPlayerJobPayment(client, "Bus Driver", "distant", distance)
exports.UGCemployment:givePlayerJobMoney(client, "Bus Driver", math.ceil(payment / 10 + math.random(20, 29)), "+ $" .. math.ceil(payment / 10 + math.random(20, 29)) .. " Earned", "+1 Bus Trip")
exports.UGCemployment:givePlayerProgress(client, "Bus Driver", 1) 
end)
