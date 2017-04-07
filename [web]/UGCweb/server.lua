--[[ 
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 20 March 2017
-- Script: UGCweb/server.lua
-- Type: Server Sided
]]--

function getServerScoreboard()
	local player = {}
	for _, v in ipairs(getElementsByType("player")) do
		local tname = getTeamName(getPlayerTeam(v))
		local tr, tg, tb = getTeamColor(getPlayerTeam(v))
		player[getPlayerName(v)] = {wl  = getElementData(v, "Stars"), city = getElementData(v, "City"), money = getPlayerMoney(v), team = {tname, tr, tg, tb}, occupation = getElementData(v, "Occupation"), group = getElementData(v, "Group"), ping = getPlayerPing(v)}
	end
	return player
end

function getPlayerData()
	return #getElementsByType("player") .. "/" .. getMaxPlayers()
end