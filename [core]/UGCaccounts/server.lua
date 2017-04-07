-------------------------------->
-- UGC: United Gaming Community
-- Author: Om Bhende (RipeMangoe69)
-- Date: 25 February 2017
-- Script: UGCaccounts/server.lua
-- Type: Server Sided
-------------------------------->

-- Configuration
local ShortServerName = "UGC:RPG" -- Short Server Name
local con = exports.UGCdb:getConnection()
dbExec(con, "CREATE TABLE IF NOT EXISTS `accounts` ( `id` INT NOT NULL AUTO_INCREMENT, `username` TEXT, `lastloginip` TEXT, `serial` TEXT, `data` TEXT, `custom_data` TEXT, PRIMARY KEY(id))")

function loginPlayer(player, username, password, rememberMe)
	if not player then return false end
	local account = getAccount(username, password)
	local serial = getPlayerSerial(player)
	for banID, ban in ipairs (getBans()) do
		if getBanSerial(ban) == serial then return triggerClientEvent(player, "UGCaccounts.setWindowWarning", resourceRoot, "You are banned from this server!", 255, 0, 0) end
	end
	-- Check if account exist
	if account then
		if logIn(player, account, password) then
			triggerClientEvent(player, "UGCaccounts.successAuthed", resourceRoot, rememberMe, username, password)
			fadeCamera(player, true, 1)
		else
			triggerClientEvent(player, "UGCaccounts.setWindowWarning", resourceRoot, "Error: Username is online/Account is blocked", 255, 0, 0)
		end
	else 
		triggerClientEvent(player, "UGCaccounts.setWindowWarning", resourceRoot, "Wrong Username/Password", 255, 0, 0)
	end
end
addEvent("UGCaccounts.loginPlayer", true)
addEventHandler("UGCaccounts.loginPlayer", resourceRoot, loginPlayer)


function registerPlayer(player, username, password)
	if not player then return false end
	local account = getAccount(username)
	local serial = getPlayerSerial(player)
	-- Check if account exist
	if account then
		triggerClientEvent(player, "UGCaccounts.setWindowWarning", resourceRoot, "Account already exist.", 255, 0, 0)
	else
		triggerClientEvent(player, "UGCaccounts.setWindowWarning", resourceRoot, "Account '" .. username .. "' has been created!", 0, 255, 0)
		addAccount(username, password)
		dbExec(con, "INSERT INTO `accounts` (username, lastloginip, serial, data, custom_data) VALUES (?,?,?,?,?)", username, getPlayerIP(player), getPlayerSerial(player), "[ { \"pos\": [ 1685, -2240, 13.5, 180, 0, 0 ] } ]", "[[]]")
	end
end
addEvent("UGCaccounts.createAccount", true)
addEventHandler("UGCaccounts.createAccount", resourceRoot, registerPlayer)

function disableLogout()
	outputChatBox("Logout has been disabled!", source, 255, 0, 0)
	cancelEvent()
end
addEventHandler("onPlayerLogout", root, disableLogout)

function getUpdate()
callRemote("http://ugcrpg.ga/MTA/updates.php", function(update) 
		triggerClientEvent("UGCaccounts.getUpdates", resourceRoot, update)
	end
)
end
addEvent("UGCaccounts.getUpdates", true)
addEventHandler("UGCaccounts.getUpdates", resourceRoot, getUpdate)
setTimer(getUpdate, 5000, 0)

addEventHandler("onPlayerQuit", getRootElement(), function()
	local data = {}
	local account = getPlayerAccount(source)
	if isGuestAccount(account) then return false end -- Return false if player is not logged in
	local x, y, z = getElementPosition(source)
	local rx, ry, rz = getElementRotation(source)
	local team = getPlayerTeam(source)
	if team == false then
	 team = getTeamFromName("Unemployed")
	end 
	local tr, tg, tb = getTeamColor(team) -- Team Color
	data["pos"] = {x, y, z+2, rz, getElementInterior(source), getElementDimension(source)}
	data["skin"] = getElementModel(source)
	data["team"] = {getTeamName(team), tr, tg, tb, getElementData(source, "Occupation")}
	data["money"] = getPlayerMoney(source)
	data["health"] = getElementHealth(source)
	data["crime"] = {getPlayerWantedLevel(source), getElementData(source, "wl")}
	dbExec(con, "UPDATE `accounts` SET data=? WHERE username=?", toJSON(data), getAccountName(account))
	data = {}
end)
addEventHandler("onPlayerLogin", getRootElement(), function() 
setPlayerTeam(source, getTeamFromName("Unemployed"))
end)
addEventHandler("onPlayerLogin", getRootElement(), function(_, account) 
	setPedStat(source, 24, 1000)
	local query = dbQuery(con, "SELECT * FROM `accounts` WHERE username=?", getAccountName(account))
	dbExec(con, "UPDATE `accounts` SET lastloginip=? WHERE username=?", getPlayerIP(source), getAccountName(account))
	local row = dbPoll(query, -1)
	local json = row[1].data or {}
	if json == false or json == nil then return false end
	local data = fromJSON(json)
	local dx, dy, dz = 1685, -2240, 13.5 -- If there's no position appended to account, then use default
	if data == nil then return false end -- If there's no data appended to account
	spawnPlayer(source, data["pos"][1] or dx, data["pos"][2] or dy, data["pos"][3] or dz, data["pos"][4] or 90, 0, data["pos"][5] or 0, data["pos"][6] or 0)
	setElementModel(source, data["skin"] or 0)
	setPlayerTeam(source, getTeamFromName(data["team"][1] or "Unemployed"))
	setPlayerNametagColor(source, data["team"][2] or 255, data["team"][3] or 255, data["team"][4] or 255)
	setPlayerMoney(source, data["money"] or 0)
	setElementHealth(source, data["health"])
	setElementData(source, "wl", data["crime"][2] or 0)
	setPlayerWantedLevel(source, data["crime"][1] or 0)
	setElementData(source, "Occupation", data["team"][5])
end)						

function getAllAccounts()
local accounts = #getAccounts()
outputChatBox("["..ShortServerName.."]#FFFFFF Total Accounts Registered: " .. accounts, thePlayer, 0, 255, 0, true)
end
addCommandHandler("accounts", getAllAccounts)

function getPlayerData(player)
	local account = getPlayerAccount(player)
	if isGuestAccount(account) then return false, "Guest Account" end
	local query = dbQuery(con, "SELECT * FROM `accounts` WHERE username=?", getAccountName(account))
	local row = dbPoll(query, -1)
	local json = row[1].data
	return json
end

function getPlayerID(player)
local account = getPlayerAccount(player)
	if isGuestAccount(account) then return error("getPlayerID: Player account is guest account!") end
	local query = dbQuery(con, "SELECT * FROM `accounts` WHERE username=?", getAccountName(account))
	local row = dbPoll(query, -1)
	local json = row[1].id
	return json
end
