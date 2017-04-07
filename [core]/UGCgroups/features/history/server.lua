--[[ 
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 21 March 2017
-- Script: UGCgroups/features/history/server.lua
-- Type: Server Sided
]]--

local con = exports.UGCdb:getConnection()

addEvent("UGCgroups.openHistoryWindow", true)
addEventHandler("UGCgroups.openHistoryWindow", resourceRoot, function()
	local logs = {}
	local group = getPlayerGroupInfo(client)["name"]
	local id = getGroupID(group)
	local result = dbPoll(dbQuery(con, "SELECT * FROM `group.logs` WHERE group_id=?", id), -1)
	for _, v in ipairs(result) do
		local ts = v.timestamp
		local date = string.format("%02d/%02d/%02d", getRealTime(ts).monthday, getRealTime(ts).month, getRealTime(ts).year)
		local time = string.format("%02d:%02d:%02d", getRealTime(ts).hour, getRealTime(ts).minute, getRealTime(ts).second)
		table.insert(logs, "["..time.."] ["..date.."] " .. v.log)
	end
	triggerClientEvent(client, "UGCgroups.openHistoryWindow", resourceRoot, logs)
end)