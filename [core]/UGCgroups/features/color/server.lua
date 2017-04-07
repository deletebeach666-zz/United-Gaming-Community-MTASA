--[[ 
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 21 March 2017
-- Script: UGCgroups/tabs/color/server.lua
-- Type: Client Sided
]]--

local con = exports.UGCdb:getConnection()

addEvent("UGCgroups.setGroupRGB", true)
addEventHandler("UGCgroups.setGroupRGB", resourceRoot, function(r, g, b)
	local json = toJSON({r, g, b})
	dbExec(con, "UPDATE `groups` SET group_color=? WHERE name=?", json, getPlayerGroupInfo(client)["name"])
	outputGroupChat(client, getPlayerName(client) .. " has changed group color!")
	insertGroupLog(getPlayerGroupInfo(client)["name"], getPlayerName(client) .. " has updated group color!" .. " (Account: " .. getAccountName(getPlayerAccount(client)) .. ")")
end)