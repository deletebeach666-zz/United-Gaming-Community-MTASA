	--[[ 
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 27 March 2017
-- Script: UGCdx/server.lua
-- Type: Server Sided
]]--

function drawProgressBar(player, text, time, r, g, b, reverse)
	player = player or root
	triggerClientEvent(player, "UGCdx:drawProgressBar", resourceRoot, text, time, r, g, b, reverse)
	return true
end
