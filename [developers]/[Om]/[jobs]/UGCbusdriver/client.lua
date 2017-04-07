--[[ 
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 27 March 2017
-- Script: UGCpolice/client.lua
-- Type: Client Sided
]]--

local cur_stop = 1 -- Current Bus Stop
local distance = 0 -- Total distance that player will travel
local vehicles = {
	[431] = true,-- Bus
	[437] = true,-- Coach
}

local LS = {
	{1824.080078125,-1827.07421875,12.4140625,},
	{1977.1884765625,-1755.560546875,12.3828125,},
	{2165.810546875,-1755.71484375,12.386846542358,},
	{2320.1513671875,-1753.3046875,12.378902435303,},
	{2410.224609375,-1950.625,12.3828125,},
	{2236.3095703125,-1969.380859375,12.347677230835,},
	{2216.9443359375,-2143.2412109375,12.3828125,},
	{1981.59765625,-2107.0927734375,12.343952178955,},
	{1910.0009765625,-2162.8662109375,12.3828125,},
	{1489.7529296875,-2191.1025390625,12.375,},
	{1668.7412109375,-2256.798828125,12.358600616455,},
	{1623.693359375,-2316.138671875,12.386850357056,},
	{1284.083984375,-2445.4140625,7.0364227294922,},
	{1059.8505859375,-1829.890625,12.551038742065,},
	{1066.02734375,-1431.33203125,12.362535476685,},
	{1003.1171875,-1137.35546875,22.654819488525,},
	{534.8642578125,-1242.0966796875,15.529403686523,},
	{390.6064453125,-1213.3349609375,51.077972412109,},
	{365.7705078125,-1166.9619140625,76.901725769043,},
	{924.517578125,-840.2607421875,92.808654785156,},
	{1370.4111328125,-887.7734375,36.519187927246,},
	{2249.9462890625,-1145.7177734375,25.204362869263,},
	{2338.9453125,-1468.3388671875,22.826374053955,},
	{2271.4716796875,-1729.0048828125,12.3828125,},
	{2014.58984375,-1809.0869140625,12.3828125,},
	{1905.7529296875,-1929.0830078125,12.385165214539,},
}

addEventHandler("onClientPlayerTakeJob", getRootElement(), function(job, division)
	if source == localPlayer then
		if job == "Bus Driver" then
			exports.UGCnoty:sendNotification("Please make your way towards vehicle spawner to start working..", 0, 255, 0)
			cur_stop = 1
		end
	end
end)

function triggerBusDriverJob()
	if blip ~= nil and marker ~= nil then
		destroyElement(blip)
		destroyElement(marker)
		blip = nil
		marker = nil
	end
	if (exports.UGCchat:getPlayerZone() == "LS") then
	if LS[cur_stop] == nil then cur_stop = 1 end
	x, y, z = 1775.4382324219, -1923.1293945313, 12.985974884039
	dist = getDistanceBetweenPoints3D(x, y, z, LS[cur_stop][1], LS[cur_stop][2], LS[cur_stop][3])
	blip = createBlip(LS[cur_stop][1], LS[cur_stop][2], LS[cur_stop][3], 41)
    marker = createMarker(LS[cur_stop][1], LS[cur_stop][2], LS[cur_stop][3]-1, "checkpoint")
    addEventHandler("onClientMarkerHit", marker, missionComplete)
    cur_stop = cur_stop + 1
    end
end

addEventHandler("onClientVehicleEnter", getRootElement(),
    function(thePlayer, seat)
        if thePlayer == localPlayer then
           	local id = getElementModel(source)
           	if vehicles[id] == true and getElementData(localPlayer, "Occupation") == "Bus Driver" then
           		triggerBusDriverJob()
           	end
        end
    end
)

function missionComplete(hit, matchingDim)
	if (matchingDim) then
		if getElementType(hit) ~= "player" then return end
		if isPedInVehicle(hit) ~= true then return false end
		local veh = getPedOccupiedVehicle(hit)
		local id = getElementModel(veh)
		if vehicles[id] == true and getElementData(localPlayer, "Occupation") == "Bus Driver" then
			local sx, sy, sz = getElementVelocity(veh)
			local speed = (sx^2 + sy^2 + sz^2)^(0.5)
			local kmh = speed * 180
			if kmh >= 20 then return exports.UGCnoty:sendNotification("You are too fast!", 255, 0, 0) end
			exports.UGCdx:drawProgressBar("Progress", 5000)
			setElementFrozen(veh, true)
			setTimer(function()
				setElementFrozen(veh, false)
			end, 5000, 1)
			triggerBusDriverJob()
			triggerServerEvent("UGCbusjob.givePlayerPayment", resourceRoot, dist)
		end
	end
end

addEventHandler("onClientPlayerResign", root, function(job)
	if source == localPlayer and getElementData(localPlayer, "Occupation") == "Bus Driver" then
		if blip ~= nil and marker ~= nil then
			destroyElement(blip)
			destroyElement(marker)
			blip = nil
			marker = nil
		end
	end
end)