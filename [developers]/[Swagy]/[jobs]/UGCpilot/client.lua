local allowedVehicles = {
	
	[519] = {true},
	[511] = {true},
	[512] = {true},
	[512] = {true},
	[593] = {true},
	[533] = {true}
}

local loadingPos = {
	
	["LS"] = {1896.9682617188, -2343.2312011719, 13.146875},
	["LV"] = {1572.4844970703, 1359.6658935547, 10.466644859314},
	["SF"] = {-1351.8878173828, -236.5905456543, 13.7484375}

}

function generateKey (city)

	if (city == "LS") then
		local key = math.random(2,3)
		if (key == 2) then generatedKey = "LV"
		elseif (key == 3) then generatedKey = "SF"
		end
	elseif (city == "LV") then
		local key = math.random(1,3)
		if (key == 2) then
			generatedKey = "LS"
		elseif (key == 1) then generatedKey = "LS"
		elseif (key == 3) then generatedKey = "SF" end
	elseif (city == "SF") then
		key = math.random(1,2)
		if (key == 1) then generatedKey = "LS"
		elseif (key == 2) then generatedKey = "LV" end
	end
	return generatedKey
end

function getElementSpeed(theElement, unit)
    -- Check arguments for errors
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    -- Default to m/s if no unit specified and 'ignore' argument type if the string contains a number
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    -- Setup our multiplier to convert the velocity to the specified unit
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    -- Return the speed by calculating the length of the velocity vector, after converting the velocity to the specified unit
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

function createPassengerMarker (plr)
	if (loadingMarker) and (loadingBlip) then return false end
	if (dropOffMarker) and (dropOffBlip) then return false end
	city = exports.UGCchat:getPlayerZone(plr)
	if (city == "NA") then return exports.UGCnoty:sendNotification("You're in an unknown place!",255,0,0) end
	cx,cy,cz = getElementPosition(plr)
	local x,y,z = unpack(loadingPos[city])
	distance = math.ceil(getDistanceBetweenPoints3D (x,y,z,cx,cy,cz))
	loadingMarker = createMarker(x,y,z, "checkpoint", 4,255,255,0,255)
	loadingBlip = createBlipAttachedTo(loadingMarker, 60)
	exports.UGCnoty:sendNotification("Head to the green man blip on your radar to pickup passengers!",255,255,0)
end
addEvent("UGCpilot:restartJob", true)
addEventHandler("UGCpilot:restartJob", root, createPassengerMarker)

function createDropOffMarker ()
	local key = generateKey(city)
	local x,y,z = unpack(loadingPos[key])
	distance = math.ceil(getDistanceBetweenPoints3D (x,y,z,cx,cy,cz))
	dropOffMarker = createMarker(x,y,z, "checkpoint", 4,255,255,0)
	dropOffBlip = createBlipAttachedTo(dropOffMarker, 41)
	exports.UGCnoty:sendNotification("Head to the waypoint blip to drop the passengers off!",255,255,0)
	destroyElement(loadingBlip)
	loadingBlip = nil
	destroyElement(loadingMarker)
	loadingMarker = nil
end

addEventHandler ("onClientMarkerHit", getRootElement(), function (h, dim)

	if (h ~= localPlayer) then return false end
	if not (dim) then return false end
	if (source ~= loadingMarker) then return false end
	if not (isPedInVehicle(h)) then return false end
	if (getElementSpeed(getPedOccupiedVehicle(h), 2) > 35) then return exports.UGCnoty:sendNotification("Slow down to taxi!",255,0,0) end
	local veh = getPedOccupiedVehicle(h)
	setElementFrozen(veh, true)
	progress = exports.UGCdx:drawProgressBar("Taxi", 5000, 255,150,0)
	setTimer(setElementFrozen, 5000, 1, veh, false)
	startJobTimer = setTimer(createDropOffMarker, 5000,1)
end)

addEventHandler ("onClientMarkerHit", getRootElement(), function (h, dim)

	if (h ~= localPlayer) then return false end
	if not (dim) then return false end
	if (source ~= dropOffMarker) then return false end
	if not (isPedInVehicle(h)) then return false end
	if (getElementSpeed(getPedOccupiedVehicle(h), 2) > 35) then return exports.UGCnoty:sendNotification("Slow down to taxi!",255,0,0) end
	local veh = getPedOccupiedVehicle(h)
	setElementFrozen(veh, true)
	progress = exports.UGCdx:drawProgressBar("Drop off", 5000, 255,150,0)
	setTimer(setElementFrozen, 5000, 1, veh, false)
	setTimer(cancelPilotJob, 5000,1,h)
	setTimer(createPassengerMarker, 5000,1,h)
	triggerServerEvent("UGCpilot:givePayment", resourceRoot, h, distance)
end)

function cancelPilotJob (p)

	if (p ~= localPlayer) then return false end
	if (loadingMarker) then
		destroyElement(loadingBlip)
		loadingBlip = nil
		destroyElement(loadingMarker)
		loadingMarker = nil
	elseif (dropOffMarker) then
		destroyElement(dropOffBlip)
		dropOffBlip = nil
		destroyElement(dropOffMarker)
		dropOffMarker = nil
	elseif (progress) then
		exports.UGCdx:destroyProgressBar(progress)
	elseif (isTimer(startJobTimer)) then
		killTimer(startJobTimer)
	end
end
addEvent("UGCpilot:cancelJob", true)
addEventHandler("UGCpilot:cancelJob", root, cancelPilotJob)


addEventHandler("onClientVehicleEnter", getRootElement(), function (p, seat)

	if (p ~= localPlayer) then return false end
	if (getElementData(p, "Occupation") ~= "Pilot") then return false end
	if not (allowedVehicles[getElementModel(source)]) then return false end
	createPassengerMarker(p)
end)

addEventHandler("onClientPlayerResign", getRootElement(), function (job)
    if (job ~= "Pilot") then return false end
    cancelPilotJob(localPlayer) 
end
)