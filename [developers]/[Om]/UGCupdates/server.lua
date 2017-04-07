--[[ 
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 19 March 2017
-- Script: UGCupdates/server.lua
-- Type: Server Sided
]]--

addCommandHandler("updates", function(thePlayer)
	callRemote("http://ugcrpg.ga/MTA/updates.php", function(updates)
           triggerClientEvent(thePlayer, "UGCupdates.toggleWindow", resourceRoot, updates)
	end)
end)

function onUpdateRelease(update)
	outputChatBox("* (Update) " .. update, root, 255, 215, 0)
	exports.UGCirc:ircSay(exports.UGCirc:ircGetChannelFromName("#ugcrpg"), "* (Update) " .. update)
end