-------------------------------->
-- UGC: United Gaming Community
-- Author: Om Bhende (RipeMangoe69)
-- Date: 14 March 2017
-- Script: UGCbanking/server.lua
-- Type: Server Sided
-------------------------------->
local markers = {}

local con = exports.UGCdb:getConnection()
dbExec(con, "CREATE TABLE IF NOT EXISTS `banking.logs` (`id` INT NOT NULL AUTO_INCREMENT, `time` TEXT, `user_id` INT, `trans_type` TEXT, `amount` TEXT, `log` TEXT, PRIMARY KEY(id))")

-- Bank Balance
addCommandHandler("bankbalance", function(thePlayer)
exports.UGCnoty:sendNotification("You currently have $" .. exports.UGCutils:formatNumber(getPlayerBankBalance(thePlayer)) .. " in your bank!", thePlayer, 0, 255, 0)
end)

-- Total Balance
addCommandHandler("totalbalance", function(thePlayer)
exports.UGCnoty:sendNotification("You Total Balance: $" .. exports.UGCutils:formatNumber(getPlayerBankBalance(thePlayer) + getPlayerMoney(thePlayer)), thePlayer, 0, 255, 0)
end)

-- Actual Banking System
------------------------------>
local markers = {
	{1433.8974609375, -1011.8145141602, -57.8671875, 0, 0}, 
	{1433.9204101563, -1008.3360595703, -57.8671875, 0, 0},
	{1433.9205322266, -1004.6892089844, -57.8671875, 0, 0},
	{1437.8674316406, -998.65179443359, -57.8671875, 0, 0},
	{1433.7575683594, -993.74548339844, -57.8671875, 0, 0},
	{1433.9104003906, -990.02294921875, -57.8671875, 0, 0},
	{1433.8090820313, -986.16296386719, -57.8671875, 0 ,0},
}

local bankBlips = {
	{1457.3239746094, -1010.8208618164, 26.44375}
}

addEventHandler("onResourceStart", resourceRoot, function()
	for k, v in ipairs(markers) do
		marker = createMarker(v[1], v[2], v[3], "cylinder", 1.3, 0, 255, 0, 175)
		setElementInterior(marker, v[4])
		--createBlipAttachedTo(marker, 52, 1, 255, 0, 0, 0, 0, 300)
		setElementDimension(marker, v[5])
		markers[marker] = k
	end
	for k, v in ipairs(bankBlips) do
		blips = createBlip(v[1], v[2], v[3], 52, 1, 255, 0, 0, 0, 0, 300)
	end
end)

function onBankMarkersHit(hitElement, matchingDim)
	if (matchingDim) then
		if isElement(hitElement) and getElementType(hitElement) == "player" and markers[source] then
			triggerClientEvent(hitElement, "UGCbanking.openBankWindow", resourceRoot, getPlayerName(hitElement), getPlayerBankBalance(hitElement))
		end
	end
end
addEventHandler("onMarkerHit", root, onBankMarkersHit)

function onBankMarkersLeave(hitElement, matchingDim)
	if (matchingDim) then
		if isElement(hitElement) and getElementType(hitElement) == "player" and markers[source] then
			triggerClientEvent(hitElement, "UGCbanking.closeBankWindow", resourceRoot)
		end
	end
end
addEventHandler("onMarkerLeave", root, onBankMarkersLeave)

-- Transaction Logs
addEvent("UGCbanking.requestLogs", true)
addEventHandler("UGCbanking.requestLogs", resourceRoot, function()
local id = exports.UGCaccounts:getPlayerID(client)
local result = dbPoll(dbQuery(con, "SELECT * FROM `banking.logs` WHERE `user_id`=?", id), -1)
triggerClientEvent(client, "UGCbanking.showTransactionInterface", resourceRoot, result)
end)

-- Transfer Money
addEvent("UGCbanking.transferMoney", true)
addEventHandler("UGCbanking.transferMoney", resourceRoot, function(amount, accName)
	if amount and accName then
		local acc = getAccount(accName)
		if acc then
			if getPlayerBankBalance(client) < tonumber(amount) then return exports.UGCnoty:sendNotification("You dont have sufficient cash", client, 255, 0, 0) end
			exports.UGCnoty:sendNotification("You have sent $" .. amount .. " to '" .. accName .. "'!", client, 0, 255, 0)
			removeMoneyFromBank(client, tonumber(amount), "Money Transfer: Sent $" .. amount .. " to account name '" .. accName .. "'.", true)
			giveMoneyByAccount(accName, tonumber(amount))
			triggerClientEvent(client, "UGCbanking.updateBalance", resourceRoot, exports.UGCutils:formatNumber(getPlayerBankBalance(client)))
		else
			exports.UGCnoty:sendNotification("Account Name: '" .. accName .. "' does not exist.", client, 255, 0, 0)
		end	
	end
end)

-- Exports
---------->

function getPlayerBankBalance(player)
if getElementType(player) ~= "player" then return error("Argument #1 [Expected Player, got " .. getElementType(player) .. "!") end
local result = dbPoll(dbQuery(con, "SELECT * FROM `accounts` WHERE username=?", getAccountName(getPlayerAccount(player))), -1)
return result[1].bank
end

function addMoneyToBank(player, amount, reason)
if reason == nil or reason == "" then return error("addMoneyToBank: No log reason specified!") end
if getElementType(player) ~= "player" then return error("Argument #1 [Expected Player, got " .. getElementType(player) .. "!") end
if amount == nil or type(amount) ~= "number" then return error("Number expected at Argument #2, got " .. type(amount) .. "!") end
local query = dbExec(con, "UPDATE `accounts` SET `bank`=? WHERE `username`=?", amount+getPlayerBankBalance(player), getAccountName(getPlayerAccount(player)))
dbExec(con, "INSERT INTO `banking.logs` (time, user_id, trans_type, amount, log) VALUES (?,?,?,?,?)", getRealTime().timestamp,  exports.UGCaccounts:getPlayerID(player), "added", amount, reason)
if query ~= true then return false end
return true
end

function removeMoneyFromBank(player, amount, reason, isTransfer)
	if isTransfer == true then
		ttype = "transfer"
	else
		ttype = "removed"
	end
if reason == nil or reason == "" then return error("removeMoneyFromBank: No log reason specified!") end
if getElementType(player) ~= "player" then return error("Argument #1 [Expected Player, got " .. getElementType(player) .. "!") end
if amount == nil or type(amount) ~= "number" then return error("Number expected at Argument #2, got " .. type(amount) .. "!") end
if getPlayerBankBalance(player) < amount then return false end
local query = dbExec(con, "UPDATE `accounts` SET `bank`=? WHERE `username`=?", getPlayerBankBalance(player)-amount, getAccountName(getPlayerAccount(player)))
dbExec(con, "INSERT INTO `banking.logs` (time, user_id, trans_type, amount, log) VALUES (?,?,?,?,?)", getRealTime().timestamp,  exports.UGCaccounts:getPlayerID(player), ttype, amount, reason)
if query ~= true then return false end
return true
end

-- Housing Exports
------------------->
function getAccountBankBalance(accName)
local account = getAccount(accName)
if account == false then return error("Account `"..accName.."` does not exist!") end
local result = dbPoll(dbQuery(con, "SELECT * FROM `accounts` WHERE username=?", getAccountName(account)), -1)
return result[1].bank
end

function giveMoneyByAccount(accName, amount)
local account = getAccount(accName)
if account == false then return error("Account `"..accName.."` does not exist!") end
if amount == nil or type(amount) ~= "number" then return error("Number expected at Argument #2, got " .. type(amount) .. "!") end
local query = dbExec(con, "UPDATE `accounts` SET `bank`=? WHERE `username`=?", amount+getAccountBankBalance(accName), getAccountName(account))
if query ~= true then return false end
return true
end