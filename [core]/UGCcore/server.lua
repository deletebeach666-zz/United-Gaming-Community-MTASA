-------------------------------->
-- UGC: United Gaming Community
-- Author: Om Bhende (RipeMangoe69)
-- Date: 27 February 2017
-- Script: UGCcore/server.lua
-- Type: Server Sided
-------------------------------->

-- Configuration
local password = "ksomk" -- Server Password
local time_hour, time_min = 0, 0
local gamemode = "UGC:RPG V1.0.0"
local fps_limit = 60

function onStartup()
	-- Set Configuration
	setServerPassword(password)
	setTime(time_hour, time_min)
	setGameType(gamemode)
	setFPSLimit(fps_limit)
	setMoney()

-- Teams
createTeam("Staffs", 128, 128, 128)
createTeam("Law Agents", 0, 0, 200)
createTeam("Emergency Services", 0, 255, 255)
createTeam("Criminals", 200, 0, 0)
createTeam("Civilian Workers", 255, 255, 0)
createTeam("Unemployed", 255, 255, 255)

-- Scoreboard Column
exports.scoreboard:scoreboardAddColumn("Money")
exports.scoreboard:scoreboardAddColumn("WL", root, 20)
exports.scoreboard:scoreboardAddColumn("Playtime")
exports.scoreboard:scoreboardAddColumn("Occupation", root, 100)
exports.scoreboard:scoreboardAddColumn("Group")
exports.scoreboard:scoreboardAddColumn("City", root, 25)

	print("Server Configuration Status: Success!")
end
addEventHandler("onResourceStart", resourceRoot, onStartup)

-- Set Money
function setMoney()
	for _, player in ipairs(getElementsByType("player")) do
		setElementData(player, "Money", "$" .. getPlayerMoney(player))
	end
end
setTimer(setMoney, 2500, 0)

-- Set City
function setCity()
	for _, player in ipairs(getElementsByType("player")) do
		setElementData(player, "City", exports.UGCchat:getPlayerZone(player))
	end
end
setTimer(setCity, 2500, 0)


-- Set Wanted Level
function setWL()
	for _, player in ipairs(getElementsByType("player")) do
		setElementData(player, "WL", getPlayerWantedLevel(player))
	end
end
setTimer(setWL, 2500, 0)

-- onResourceStop
function onStop()
	for _, player in ipairs(getElementsByType("player")) do
		redirectPlayer(player, "s1.ugcrpg.ga", 22003, password)
	end
end
addEventHandler("onResourceStop", resourceRoot, onStop)


-- If vehicle are not owned, destroy them on exploded
function destroyVehicles()
	local owned = getElementData(source, "owned")
	if owned ~= true then
		destroyElement(source)
	end
end
addEventHandler("onVehicleExplode", getRootElement(), destroyVehicles)
