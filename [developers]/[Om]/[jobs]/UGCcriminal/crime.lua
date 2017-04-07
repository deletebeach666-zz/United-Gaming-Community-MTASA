--[[ 
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 28 March 2017
-- Script: UGCcriminals/server.lua
-- Type: Server Sided
]]--

addEvent("onPlayerWantedLevelChange", true)

local crimes = {
	[0] = {"Criminal Activity", 2},
	[1] = {"Discharge of Weapon", 2},
	[2] = {"Small Burglary", 4},
	[3] = {"Stealing Bikes", 6},
	[4] = {"Stealing Vehickes", 8},
	[6] = {"Thief Activity", 10},
	[5] = {"Murder", 20},
	[6] = {"Grand Larceny", 75}
}

function givePlayerWL(player, crimeID)
	if getElementType(player) == "player" and crimes[crimeID] ~= nil then
		local current = getElementData(player, "UGCcriminal:wantedLevel") or 0
		if triggerEvent("onPlayerWantedLevelChange", player, crimeID, current+crimes[crimeID][2]) then 
			setElementData(player, "UGCcriminal:wantedLevel", current+crimes[crimeID][2])
			return true
		end
	end
	return false
end

addEventHandler("onPlayerWantedLevelChange", root, function(crimeID, total)
	if total > 75 then
		setPlayerWantedLevel(source, 6)
		elseif total > 60 then
		setPlayerWantedLevel(source, 5)
		elseif total > 35 then
		setPlayerWantedLevel(source, 4)
		elseif total > 25 then
		setPlayerWantedLevel(source, 3)
		elseif total > 10 then
		setPlayerWantedLevel(source, 2)
		elseif total > 1 then
		setPlayerWantedLevel(source, 1)
	end
end)

addEventHandler("onPlayerWasted", getRootElement(), function(_, killer)
	if getElementType(killer) == "player" then

	end
end)