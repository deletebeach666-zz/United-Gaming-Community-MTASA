------------------------------>
-- UGC: United Gaming Community
-- Author: Om Bhende (RipeMangoes69)
-- Date: 24 March 2017
-- Version: 1.0
-- File: UGCemployment/server.lua
-- Type: Server Sided
------------------------------>

-- Custom Events
addEvent("onPlayerTakeJob", true)
addEvent("onPlayerResign", true)

local jobs = {
	-- Medic
	{x = 1178.2017822266, y = -1319.1276855469, z = 13.708403205872, id="Doctor", division={"Doctor"}, color = {0, 255, 255}, pedid=70, pedrot=271, city="LS", skins={{"Doctor", 70}, {"Medic 1", 274}, {"Medic 2", 275}, {"Medic 3", 276}}},
	{x = -2640.4479980469, y = 633.25805664063, z = 14.054549789429, id="Doctor", division={"Doctor"}, color = {0, 255, 255}, pedid=70, pedrot=180, city="SF", skins={{"Doctor", 70}, {"Medic 1", 274}, {"Medic 2", 275}, {"Medic 3", 276}}},
	{x = 1601.5336914063, y = 1817.6479492188, z = 10.4203125, id="Doctor", division={"Doctor"}, color = {0, 255, 255}, pedid=70, pedrot=0, city="LV", skins={{"Doctor", 70}, {"Medic 1", 274}, {"Medic 2", 275}, {"Medic 3", 276}}},

	-- Pilot
	{x = 1969.0899658203, y = -2187.4860839844, z = 13.146875, id="Pilot", division={"Pilot"}, color={255, 255, 0}, pedid=61, pedrot=0, city="LS", skins={{"Male Pilot", 61}, {"Female Pilot", 141}}},
	{x = 1319.1166992188, y = 1250.9639892578, z = 10.420312, id="Pilot", division={"Pilot"}, color={255, 255, 0}, pedid=61, pedrot=0, city="LV", skins={{"Male Pilot", 61}, {"Female Pilot", 141}}},
	{x = -1257.4163818359, y = 45.764446258545, z = 13.737331008911, id="Pilot", division={"Pilot"}, color={255, 255, 0}, pedid=61, pedrot=227, city="SF", skins={{"Male Pilot", 61}, {"Female Pilot", 141}}},


	-- Police Officer
	{x = 1561.5316162109, y = -1678.4655761719, z = 15.791499710083, id="Police Officer", division={"Police Officer", "Police Chief"}, color={0, 0, 200}, pedid=295, pedrot=64, city="LS", skins={{"Officer 1", 280}, {"Officer 2", 281}, {"Officer 3", 282}, {"Officer 4", 283}, {"Officer 5", 284}}},

	-- Bus Driver
	{x = 1772.2845458984, y = -1927.3491210938, z = 13.153164482117, id="Bus Driver", division={"Street Driver"}, color={255, 255, 0}, pedid=253, pedrot=311, city="LS", skins={{"Bus Driver", 253}, {"Limo Driver", 255}}},
	{x = -2625.4111328125, y = 1317.7290039063, z = 6.787, id="Bus Driver", division={"Street Driver"}, color={255, 255, 0}, pedid=253, pedrot=228, city="SF", skins={{"Bus Driver", 253}, {"Limo Driver", 255}}},

	-- Pizza Boy
	{x = 2103.3488769531, y = -1803.3582763672, z = 13.1546875, id="Pizza Boy", division={"Pizza Boy"}, color={255, 255, 0}, pedid=155, pedrot=90, city="LS", skins={{"Pizza Boy", 155}}},

	-- Mechanic
	{x = 1012.7756347656, y = -1028.3218, z = 31.70, id="Mechanic", division={"Mechanic"}, color={255, 255, 0}, pedid=50, pedrot=180, city="LS", skins={{"Mechanic 1", 50}, {"Mechanic 2", 268}}},
	{x = 1935.610, y = 2154.824, z = 10.820, id="Mechanic", division={"Mechanic"}, color={255, 255, 0}, pedid=50, pedrot=90, city="LV", skins={{"Mechanic 1", 50}, {"Mechanic 2", 268}}},
	{x = -1928.554, y = 277.396, z = 41.047, id="Mechanic", division={"Mechanic"}, color={255, 255, 0}, pedid=50, pedrot=180, city="SF", skins={{"Mechanic 1", 50}, {"Mechanic 2", 268}}},
}

-- Payment Configuration
local min = 800 -- Starting Payment for players which.

addEventHandler("onResourceStart", resourceRoot, function()
	for _, v in ipairs(jobs) do
		local ped = createPed(v.pedid, v.x, v.y, v.z, v.pedrot)
		setElementFrozen(ped, true)
		marker = createMarker(v.x, v.y, v.z, "cylinder", 1, v.color[1], v.color[2], v.color[3])
		createBlipAttachedTo(marker, 56, 2, 255, 0, 0, 255, 0, 800)
		setElementAlpha(marker, 0)
		setElementData(ped, "UGCemployment:employment", true)
		setElementData(marker, "UGCemployment:city", v.city)
		setElementData(marker, "UGCemployment:job", v.id)
		setElementData(ped, "UGCemployment:job", v.id)
		setElementData(ped, "UGCemployment:jobcolor", v.color)
		addEventHandler("onMarkerHit", marker, openInterface)
	end
end)

function openInterface(hitElement, matchingDim)
	if isPedOnGround(hitElement) ~= true or isPedInVehicle(hitElement) then return end
	if matchingDim then
		local city = getElementData(source, "UGCemployment:city")
		local job = getElementData(source, "UGCemployment:job")
		for _, v in ipairs(jobs) do
			if v.city == city and v.id == job then
				triggerClientEvent(hitElement, "UGCemployment.openEMWindow", resourceRoot, city, job, v.skins, v.division, v.color, getJobInfo(v.id))
				break
			end
		end
	end
end

addEvent("UGCemployment.onPlayerTakeJob", true)
addEventHandler("UGCemployment.onPlayerTakeJob", resourceRoot, function(job, division, skin)
	if triggerEvent("onPlayerTakeJob", client, job, division, skin) then
		setElementModel(client, skin)
		setElementData(client, "Occupation", job)
		if job == "Doctor" then
			setPlayerTeam(client, getTeamFromName("Emergency Services"))
		elseif job == "Police Officer" then
			setPlayerTeam(client, getTeamFromName("Law Agents"))
		else
			setPlayerTeam(client, getTeamFromName("Civilian Workers"))
		end
	end
end)

function doesPlayerHaveJob(player)
	local occupation = getElementData(player, "Occupation")
	for _, v in ipairs(jobs) do
		if v.id == occupation then
			return true
		end
	end
	return false
end

function doesJobExist(job)
	for _, v in ipairs(jobs) do
		if v.id == job then
			return true
		end
	end
	return false
end

addCommandHandler("resign", function(thePlayer)
	if doesPlayerHaveJob(thePlayer) or getTeamName(getPlayerTeam(thePlayer)) == "Staffs" then
		if triggerEvent("onPlayerResign", thePlayer, getElementData(thePlayer, "Occupation")) then
			triggerClientEvent(thePlayer, "UGCemployment.resign", resourceRoot, getElementData(thePlayer, "Occupation"))
			exports.UGCnoty:sendNotification("You have resigned as " .. getElementData(thePlayer, "Occupation"), thePlayer, 0, 255, 0)
			setElementData(thePlayer, "Occupation", nil)
			setPlayerTeam(thePlayer, getTeamFromName("Unemployed"))
			setElementModel(thePlayer, exports.UGCskins:getPlayerOwnedSkin(thePlayer))
		end
	end
end)

addEvent("UGCemployment.resignPlayer", true)
addEventHandler("UGCemployment.resignPlayer", resourceRoot, function()
	if doesPlayerHaveJob(client) or getTeamName(getPlayerTeam(client)) == "Staffs" then
		if triggerEvent("onPlayerResign", client, getElementData(client, "Occupation")) then
			triggerClientEvent(client, "UGCemployment.resign", resourceRoot, getElementData(client, "Occupation"))
			setElementData(client, "Occupation", nil)
			setPlayerTeam(client, getTeamFromName("Unemployed"))
			setElementModel(client, exports.UGCskins:getPlayerOwnedSkin(client))
		end
	end
end)

function givePlayerJobMoney(player, job, money, ...)
local ab = table.concat({...}, "\n")
givePlayerMoney(player, money)
local account = getPlayerAccount(player)
local current = math.ceil(exports.UGCaccounts:getData(account,  job .. "-Total_Cash_Earned") or 0)
exports.UGCaccounts:setData(account, job .. "-Total_Cash_Earned", current+money)
triggerClientEvent(player, "UGCemployment.givePlayerJobMoney", resourceRoot, job, ab)
end

function getPlayerJobPayment(player, job, payment_type, dist)
	payment_type = payment_type or "static"
	if payment_type == "distant" then
		local payment = math.ceil(dist+min*getPlayerJobRank(player, job)) * 0.4 / 2
		return payment
	else
		local payment = math.ceil(min*getPlayerJobRank(player, job)) * 0.65
		return payment
	end
end

function getPlayerTotalEarnedMoney(player, job)
	local account = getPlayerAccount(player)
	return exports.UGCaccounts:getData(account,  job .. "-Total_Cash_Earned") or 0
end