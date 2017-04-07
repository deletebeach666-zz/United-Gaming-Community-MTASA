--[[ 
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 20 March 2017
-- Script: UGCgroups/tabs/ranks/server.lua
-- Type: Server Sided
]]--

local con = exports.UGCdb:getConnection()

addEvent("UGCgroups.openRanksWindow", true)
addEventHandler("UGCgroups.openRanksWindow", resourceRoot, function()
	triggerClientEvent(client, "UGCgroups.openRanksWindow", resourceRoot, exports.UGCgroups:getGroupRanks(getPlayerGroupInfo(client)["name"]))
end)

addEvent("UGCgroups.openRankEditWindow", true)
addEventHandler("UGCgroups.openRankEditWindow", resourceRoot, function(rank_name)
	triggerClientEvent(client, "UGCgroups.openRankEditWindow", resourceRoot, getRankPermissions(getRankIDFromName(rank_name)), rank_name)
end)

addEvent("UGCgroups.updateRankPerm", true)
addEventHandler("UGCgroups.updateRankPerm", resourceRoot, function(name, perm)
	local json = toJSON(perm)
	dbExec(con, "UPDATE `group.ranks` SET permission=? WHERE id=?", json, getRankIDFromName(name))
	outputGroupChat(client, getPlayerName(client) .. " has updated the ranks permission!")
	insertGroupLog(getPlayerGroupInfo(client)["name"], getPlayerName(client) .. " has updated the rank permission!" .. " (Account: " .. getAccountName(getPlayerAccount(client)) .. ")")
end)

addEvent("UGCgroups.createRank", true)
addEventHandler("UGCgroups.createRank", resourceRoot, function(name)
	local groupid = getGroupID(getPlayerGroupInfo(client)["name"])
	dbExec(con, "INSERT INTO `group.ranks` (group_id, name, permission) VALUES (?,?,?)", groupid, name, "[ [ false, false, false, false, false, false, false] ]")
	insertGroupLog(getPlayerGroupInfo(client)["name"], getPlayerName(client) .. " has updated group ranks!" .. " (Account: " .. getAccountName(getPlayerAccount(client)) .. ")")
end)

addEvent("UGCgroups.deleteRank", true)
addEventHandler("UGCgroups.deleteRank", resourceRoot, function(name)
	local id = getRankIDFromName(name)
	local result = dbPoll(dbQuery(con, "SELECT * FROM `group.members` WHERE rank_id=?", id), -1)
	if #result ~= 0 then return exports.UGCnoty:sendNotification("You cannot remove this rank until there are no members assigned to this rank.", client, 255, 0, 0) end
	dbExec(con, "DELETE FROM `group.ranks` WHERE id=?", id)
	insertGroupLog(getPlayerGroupInfo(client)["name"], getPlayerName(client) .. " has updated group ranks!" .. " (Account: " .. getAccountName(getPlayerAccount(client)) .. ")")
end)