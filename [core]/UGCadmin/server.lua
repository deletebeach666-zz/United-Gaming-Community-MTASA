--[[
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 15 March 2017
-- Project: UGC:RPG
-- Script: UGCadmin/server.lua
-- Type: Server Sided
]]--

local ranks = {
	["L1"] = "Trial Staff",
	["L2"] = "Junior Staff",
	["L3"] = "Regular Staff",
	["L4"] = "Senior Staff",
	["L5"] = "Head Staff",
	["L6"] = "Founder",	
}

function isPlayerInACL(player, acl)
	local account = getPlayerAccount (player)
	if (isGuestAccount (account)) then
		return false
	end
        return isObjectInACLGroup( "user."..getAccountName (account), aclGetGroup(acl))
end


addCommandHandler("staff", function(player, _, skin)
	if hasObjectPermissionTo(player, "function.gostaff") then
		if type(skin) ~= "number" then skin = 217 end
		local model = skin or 217
		if getTeamName(getPlayerTeam(player)) == "Staffs" and getElementModel(player) == model then return false end
		if triggerEvent("onPlayerResign", player, getElementData(player, "Occupation")) then
			triggerClientEvent(player, "UGCemployment.resign", getRootElement(), getElementData(player, "Occupation"))
			setPlayerTeam(player, getTeamFromName("Staffs"))
			setElementModel(player, model)
			if isPlayerInACL(player, "L6") then
				setElementData(player, "Occupation", ranks["L6"])
				exports.UGCnoty:sendNotification("You have switched to staff team as " .. (ranks["L6"]), player, 0, 255, 0)
			elseif isPlayerInACL(player, "L5") then
				setElementData(player, "Occupation", ranks["L5"])
				exports.UGCnoty:sendNotification("You have switched to staff team as " .. (ranks["L5"]), player, 0, 255, 0)
			elseif isPlayerInACL(player, "L4") then
				setElementData(player, "Occupation", ranks["L4"])
				exports.UGCnoty:sendNotification("You have switched to staff team as " .. (ranks["L4"]), player, 0, 255, 0)
			elseif isPlayerInACL(player, "L3") then
				setElementData(player, "Occupation", ranks["L3"])
				exports.UGCnoty:sendNotification("You have switched to staff team as " .. (ranks["L3"]), player, 0, 255, 0)
			elseif isPlayerInACL(player, "L2") then
				setElementData(player, "Occupation", ranks["L2"])
				exports.UGCnoty:sendNotification("You have switched to staff team as " .. (ranks["L2"]), player, 0, 255, 0)
			elseif isPlayerInACL(player, "L1") then
				setElementData(player, "Occupation", ranks["L1"])
				exports.UGCnoty:sendNotification("You have switched to staff team as " .. (ranks["L1"]), player, 0, 255, 0)
			elseif isPlayerInACL(player, "Developers") then
				setElementData(player, "Occupation", "Developer")
				exports.UGCnoty:sendNotification("You have switched to staff team as " .. "Developer", player, 0, 255, 0)
			end
		end
	end
end)

addCommandHandler("jetpack", function(player)
	if getTeamName(getPlayerTeam(player)) == "Staffs" then
			if (doesPedHaveJetPack(player)) then
				removePedJetPack(player)
			else
				givePedJetPack(player) 
			end
	end
end)

addCommandHandler("fly", function(player)
	if getTeamName(getPlayerTeam(player)) == "Staffs" then
			triggerClientEvent(player, "UGCadmin.setAdminFly", resourceRoot)
	end
end)

function isAdmin(player)
return hasObjectPermissionTo(player, "function.gostaff")
end