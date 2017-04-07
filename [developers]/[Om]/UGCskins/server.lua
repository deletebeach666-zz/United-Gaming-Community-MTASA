-------------------------------->
-- UGC: United Gaming Community
-- Author: Om Bhende (RipeMangoe69)
-- Date: 13 March 2017
-- Script: UGCskins/server.lua
-- Type: Server Sided
-------------------------------->

addEvent("UGCskins.changeSkin", true)
addEventHandler("UGCskins.changeSkin", resourceRoot, function(id, skinName)
	if getPlayerOwnedSkin(client) == id then return outputChatBox("[Skin Shop] #FFFFFFYou already have that skin!", client, 255, 0, 0, true) end
	local account = getPlayerAccount(client)
	exports.UGCaccounts:setData(account, "skin.owned", id)
	takePlayerMoney(client, 500)
	if exports.UGCemployment:doesPlayerHaveJob(client) or getTeamName(getPlayerTeam(client)) == "Staffs" then
		exports.UGCnoty:sendNotification("You have to resign from your job to get your skin!", client, 0, 255, 0)
	else
		setElementModel(client, id)
	end
	outputChatBox("[Skin Shop] #FFFFFFYou have bought " .. skinName .. " for $500!", client, 0, 255, 0, true) 
end)

function getPlayerOwnedSkin(player)
	local acc = getPlayerAccount(player)
	if isGuestAccount(acc) then return false end
	if exports.UGCaccounts:getData(acc, "skin.owned") == nil then
		return 0
	else
		return exports.UGCaccounts:getData(acc, "skin.owned") 
	end
end