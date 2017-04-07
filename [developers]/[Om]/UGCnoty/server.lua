-------------------------
-- UGC: United Gaming Community
-- Author: Om
-- Date: 13 March 2017
-- File UGCnoty/server.lua
-- Type: Server Sided
-------------------------

function sendNotification(text, player, r, g, b)
if text == nil then return error("sendNotification: No Text Parameter Given") end
local visTo = player or root
local red = r or 255
local green = g or 255
local blue = b or 255
triggerClientEvent(visTo, "UGCnoty.sendNotification", resourceRoot, text, red, green, blue)
end

local msgs = {
	[1] = "United Gaming Community -|- https://ugcrpg.com",
	[2] = "Developers and staffs can be identified by [UGC] Tags",
	[3] = "New Player? No Problem! Make sure you read everything from F1 Docs.",  
}

setTimer(function()
end, 30000, 0)