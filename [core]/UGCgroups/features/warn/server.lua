--[[ 
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 24 March 2017
-- Script: UGCgroups/features/warn/server.lua
-- Type: Server Sided
]]--


local con = exports.UGCdb:getConnection()
local isMemberOnline = false

addEvent("UGCgroups.openWarnWindow", true)
addEventHandler("UGCgroups.openWarnWindow", resourceRoot, function(accname)
	local warn = getAccountWarning(accname)
	triggerClientEvent(client, "UGCgroups.openWarnWindow", resourceRoot, accname, warn)
end)

addEvent("UGCgroups.issueWarning", true)
addEventHandler("UGCgroups.issueWarning", resourceRoot, function(accname, wl, warning)
	local warn = getAccountWarning(accname)
	--if warn + wl >= 100 then return exports.UGCnoty:sendNotification("You cannot issue more than 100% warning!", client, 255, 0, 0) end
	local player = accname
	isMemberOnline = false
	if getAccountPlayer(getAccount(accname)) then 
		player = getAccountPlayer(getAccount(accname)) 
		isMemberOnline = true
	end
	if isMemberOnline == true then 
		if getRankTotalPermissions(getPlayerRank(client)) <= getRankTotalPermissions(getPlayerRank(player)) then return exports.UGCnoty:sendNotification("You cannot set warning level for this rank!", client, 255, 0, 0) end
	else
		if getRankTotalPermissions(getPlayerRank(client)) <= getRankTotalPermissions(getAccountRank(accname)) then return exports.UGCnoty:sendNotification("You cannot set warning level for this rank!", client, 255, 0, 0) end
	end
	dbExec(con, "UPDATE `group.members` SET warn=? WHERE player=?", wl, accname)
	triggerClientEvent(client, "UGCgroups.warnedPlayer", resourceRoot)	
	if type(player) == "string" then 
		name = player 
		else
		 name = getPlayerName(player)
		  end
	outputGroupChat(client, getPlayerName(client) .. " has changed " .. name .. "'s warning level to " .. wl .. "%! (" .. warning .. ")")
	insertGroupLog(getPlayerGroupName(client), getPlayerName(client) .. " has changed " .. name .. "'s warning level to " .. wl .. "%! (" .. warning .. ")")
end)