local pilotVeh = {}

local allowedVehicles = {
	
	[519] = {4},
	[511] = {2},
	[512] = {1},
	[593] = {1},
	[553] = {5}
}

function givePayment (p, dist)

	if not (dist) then return false end
	local payment = exports.UGCemployment:getPlayerJobPayment(p, "Pilot", "distant", dist)
	exports.UGCemployment:givePlayerJobMoney(p, "Pilot", payment, "-Earned: $"..payment, "-Earned: "..tostring(dist).." XP")
	exports.UGCemployment:givePlayerProgress(p, "Pilot", dist)
end
addEvent("UGCpilot:givePayment", true)
addEventHandler("UGCpilot:givePayment", root, givePayment)

addEventHandler("onPlayerSpawnVehicle", root, function (id)

	if not (allowedVehicles[id]) then return false end
	local lvl = exports.UGCemployment:getPlayerJobRank(source, "Pilot")
	if (allowedVehicles[id][1] > lvl) then cancelEvent() return exports.UGCnoty:sendNotification("Your level doesn't allow you to use this aircraft!",source,255,0,0) end
end
)

addEventHandler("onVehicleExit", root, function (p, seat, jacker)

	if (getElementData(p, "Occupation") ~= "Pilot") then return false end
	if (exports.UGCspawners:getVehicleOwner(source) ~= p) then return false end
	triggerClientEvent(p,"UGCpilot:cancelJob", resourceRoot, p)
	setTimer(function (p) triggerClientEvent(p, "UGCpilot:restartJob", resourceRoot, p) end, 1000,1,p)
end)