--[[ 
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 26 March 2017
-- Script: UGCspawners/server.lua
-- Type: Server Sided
]]--

-- Custom Events
---------------->
addEvent("onPlayerSpawnVehicle", true)
addEvent("onPlayerDestroyVehicle", true)


local markers = {
	-- Format: {x, y, z, vehicleTable, job, colorTable, vehRot}
	-- All Spawners
	{1184.1729736328, -1315.4672851563, 13.17313919067, {492, 546, 580, 566, 445}, "all", {255, 255, 255}, 270}, -- All Saints Hospital (LS)
	{1624.7918701172, 1818.8463134766, 10.4203125, {492, 546, 580, 566, 445}, "all", {255, 255, 255}, 0}, -- LV Hospital (LV)

	-- Job Spawners
	{1177.5740966797, -1308.7485351563, 13.455641365051, {416, 586}, "Doctor", {0, 255, 255}, 270}, -- All Saints Hospital (LS)
	{2097.0017089844, -1816.8937988281, 12.982812, {448}, "Pizza Boy", {255, 255, 0}, 90}, -- Pizza Boy (LS)
	{-1935.9616699219, 272.90399169922, 40.646875, {413}, "Mechanic", {255, 255, 0}, 180}, -- Mechanic Job (SF)
	{1021.3746337891, -1051.0081787109, 31.197343444824, {413}, "Mechanic", {255, 255, 0}, 2}, -- Mechanic Job (LS)
	{1908.5052490234, 2131.4084472656, 10.4203125, {413}, "Mechanic", {255, 255, 0}, 272}, -- Mechanic Job (LV)
	{1922.1813964844, -2254.1608886719, 13.146875, {519, 511, 512, 593, 553}, "Pilot", {255, 255, 0}, 180}, -- Pilot #1 (LS)
	{1779.4680175781, -1926.4010009766, 12.988926506042, {431, 437}, "Bus Driver", {255, 255, 0}, 0}, -- Bus Driver #1 (LS)
	{1788.3160400391, -1926.7700195313, 12.989261245728, {431, 437}, "Bus Driver", {255, 255, 0}, 0}, -- Bus Driver #2 (LS)
	{1798.2679443359, -1926.9200439453, 12.989187812805, {431, 437}, "Bus Driver", {255, 255, 0}, 0}, -- Bus Driver #3 (LS)

}

local vehicles = {}

addEventHandler("onResourceStart", resourceRoot, function()
	for _, v in ipairs(markers) do
		marker = createMarker(v[1], v[2], v[3]-0.6, "cylinder", 1.3, v[6][1], v[6][2], v[6][3])
		setElementData(marker, "UGCspawners:vehicleTable", v[4])
		setElementData(marker, "UGCspawners:job", v[5])
		setElementData(marker, "UGCspawners:jobColor", {v[6][1], v[6][2], v[6][3]})
		setElementData(marker, "UGCspawners:vehRot", v[7])
		addEventHandler("onMarkerHit", marker, openWindow)
	end
end)

function openWindow(hit, matchingDim)
	if (matchingDim) then
		if getElementType(hit) == "player" and isPedInVehicle(hit) ~= true and isPedOnGround(hit) == true then
			local vehTable = getElementData(source, "UGCspawners:vehicleTable")
			local job = getElementData(source, "UGCspawners:job")
			local rot = getElementData(source, "UGCspawners:vehRot")
			local x, y, z = getElementPosition(source)
			local r, g, b, a = getMarkerColor(source)
			if job == "all" then
				triggerClientEvent(hit, "UGCspawners.openWindow", resourceRoot, vehTable, rot, {x, y, z}, {r, g, b})
			else
				if getElementData(hit, "Occupation") == job or getTeamName(getPlayerTeam(hit)) == "Staffs" then
					triggerClientEvent(hit, "UGCspawners.openWindow", resourceRoot, vehTable, rot, {x, y, z}, {r, g, b})
				else
					exports.UGCnoty:sendNotification("You dont have access to this spawner", hit, 255, 0, 0)
				end
			end

		end
	end
end

addEvent("UGCspawners.spawnVehicle", true)
addEventHandler("UGCspawners.spawnVehicle", resourceRoot, function(veh, rot, pos, color)
	local vehid = getVehicleModelFromName(veh)
	if vehicles[client] then
		destroyElement(vehicles[client])
		vehicles[client] = nil
	end
	if triggerEvent("onPlayerSpawnVehicle", client, vehid) then
		vehicles[client] = createVehicle(vehid, pos[1], pos[2], pos[3]+3, 0, 0, rot, "UGC:RPG")
		setVehicleColor(vehicles[client], color[1], color[2], color[3])
		warpPedIntoVehicle(client, vehicles[client])
		setElementData(vehicles[client], "UGCspawners:getVehicleOwner", client)
	end
end)

addEventHandler("onPlayerQuit", getRootElement(), function()
	if vehicles[source] ~= nil then
		destroyElement(vehicles[source])
		vehicles[source] = nil
	end
end)

addCommandHandler("djv", function(player)
	if vehicles[player] then
		if triggerEvent("onPlayerDestroyVehicle", player) then
			if getPlayerOccupiedVehicle(player) == vehicles[player] then return exports.UGCnoty:sendNotification("You cannot destroy your vehicle if you're driving it!", player, 255, 0, 0) end
			destroyElement(vehicles[player])
			vehicles[player] = nil
			exports.UGCnoty:sendNotification("Thank you for keeping San Andreas clean!", player, 0, 255, 0)
		end
	else
		exports.UGCnoty:sendNotification("You don't have any vehicles spawned!", player, 255, 0, 0)
	end
end)

function getVehicleOwner(vehicle)
	if getElementType(vehicle) ~= "vehicle" then return false end
	return getElementData(vehicle, "UGCspawners:getVehicleOwner") or false
end

addEventHandler("onPlayerResign", getRootElement(), function()
	if vehicles[source] ~= nil then
		destroyElement(vehicles[source])
		vehicles[source] = nil
	end
end)
