--[[ 
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 21 March 2017
-- Script: UGCgroups/features/info/server.lua
-- Type: Server Sided
]]--


local con = exports.UGCdb:getConnection()

addEvent("UGCgroups.openInfoWindow", true)
addEventHandler("UGCgroups.openInfoWindow", resourceRoot, function()
	triggerClientEvent(client, "UGCgroups.openInfoWindow", resourceRoot, getPlayerGroupInfo(client)["name"], getPlayerGroupInfo(client)["info"])
end)

addEvent("UGCgroups.updateGroupInfo", true)
addEventHandler("UGCgroups.updateGroupInfo", resourceRoot, function(info)
	dbExec(con, "UPDATE `groups` SET group_info=? WHERE id=?", info, getGroupID(getPlayerGroupInfo(client)["name"]))
	triggerClientEvent(client, "UGCgroups.refreshGroupInfo", resourceRoot, info)
	outputGroupChat(client, getPlayerName(client) .. " has updated the group info!")
	insertGroupLog(getPlayerGroupInfo(client)["name"], getPlayerName(client) .. " has updated the group info!" .. " (Account: " .. getAccountName(getPlayerAccount(client)) .. ")")
end)