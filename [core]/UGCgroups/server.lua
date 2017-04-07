--[[ 
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 20 March 2017
-- Script: UGCgroups/server.lua
-- Type: Server Sided
]]--

local perm = {
	[1] = "invite", -- Ability to invite player to group
	[2] = "kick", -- Ability to kick player from group
	[3] = "warn", -- Ability to warn player
	[4] = "color", -- Ability to change group color
	[5] = "rank", -- Ability to add/delete/edit ranks
	[6] = "info", -- Ability to change group information
	[7] = "name", -- Ability to change group name
}
local u2n = {}
local invitations = {}


-- MySQL Connections/Queries
local con = exports.UGCdb:getConnection()
dbExec(con, "CREATE TABLE IF NOT EXISTS `groups` ( `id` INT NOT NULL AUTO_INCREMENT, `name` TEXT, `creationdate` INT, `group_info` TEXT, `group_color` TEXT, `leader` TEXT, PRIMARY KEY(id))")
dbExec(con, "CREATE TABLE IF NOT EXISTS `group.members` ( `id` INT NOT NULL AUTO_INCREMENT, `group_id` INT, `player` TEXT, `joined` INT, `rank_id` INT, `warn` INT, PRIMARY KEY(id))")
dbExec(con, "CREATE TABLE IF NOT EXISTS `group.ranks` ( `id` INT NOT NULL AUTO_INCREMENT, `group_id` INT, `name` TEXT, `permission` TEXT, PRIMARY KEY(id))")
dbExec(con, "CREATE TABLE IF NOT EXISTS `group.logs` ( `id` INT NOT NULL AUTO_INCREMENT, `group_id` INT, `log` TEXT, `timestamp` INT, PRIMARY KEY(id))")


function user2nick()
	for _, v in ipairs(getElementsByType("player")) do
		if isGuestAccount(getPlayerAccount(v)) ~= true then
			u2n[getAccountName(getPlayerAccount(v))] = getPlayerName(v)
		end
	end
end
addEventHandler("onPlayerJoin", root, user2nick)
addEventHandler("onPlayerQuit", root, user2nick)
addEventHandler("onPlayerChangeNick", root, user2nick)
addEventHandler("onResourceStart", resourceRoot, user2nick)
setTimer(user2nick, 1000, 0)

function toggleWindow(thePlayer)
	if isPlayerInGroup(thePlayer) then
		local group = getPlayerGroupInfo(thePlayer)
		triggerClientEvent(thePlayer, "UGCgroups.toggleVisible", resourceRoot, toJSON(group), getGroupMembers(group["name"]), u2n, getPlayerPermission(thePlayer), getGroupFounder(group["name"]), getGroupList())
	else
		triggerClientEvent(thePlayer, "UGCgroups.toggleVisibleNGP", resourceRoot, invitations[thePlayer])
	end
end
addCommandHandler("group", toggleWindow)

-- Bind Key
addEventHandler("onResourceStart", resourceRoot, function()
	for _, player in ipairs(getElementsByType("player")) do
		bindKey(player, "F6", "down", toggleWindow)
	end
end)

setTimer(function()
	for _, player in ipairs(getElementsByType("player")) do
		if getPlayerGroupInfo(player) == false then return setElementData(player, "Group", nil) end
		setElementData(player, "Group", getPlayerGroupInfo(player)["name"] or nil)
	end
end, 2500, 0)

-- Bind Key on join
addEventHandler("onPlayerJoin", root, function()
	bindKey(source, "F6", "down", toggleWindow)
end)

-- Create Group
---------------->
addEvent("UGCgroups.createGroup", true)
addEventHandler("UGCgroups.createGroup", resourceRoot, function(name)
	if doesGroupExist(name) then
		exports.UGCnoty:sendNotification(name .. " already in use!", client, 255, 0, 0)
	else
		local account = getAccountName(getPlayerAccount(client))
		dbExec(con, "INSERT INTO `groups` (name, creationdate, group_info, leader, group_color) VALUES (?,?,?,?,?)", name, getRealTime().timestamp, "No Group Info", account, toJSON({255, 255, 255}))
		local id = dbPoll(dbQuery(con, "SELECT * FROM `groups` WHERE name=?", name), -1)
		dbExec(con, "INSERT INTO `group.ranks` (group_id, name, permission) VALUES (?,?,?)", id[1].id, "Founder", "[ [ true, true, true, true, true, true, true, true ] ]")
		dbExec(con, "INSERT INTO `group.ranks` (group_id, name, permission) VALUES (?,?,?)", id[1].id, "Members", "[ [ false, false, false, false, false, false, false, false ] ]")
		local rankid = dbPoll(dbQuery(con, "SELECT * FROM `group.ranks` WHERE group_id=?", id[1].id), -1)
		dbExec(con, "INSERT INTO `group.members` (group_id, player, rank_id, joined, warn) VALUES (?,?,?,?,?)", id[1].id, account, rankid[1].id, getRealTime().timestamp, 0)
		exports.UGCnoty:sendNotification(name .. " has been created!", client, 0, 255, 0)
		triggerClientEvent(client, "UGCgroups.closeCreationWindow", resourceRoot)
		insertGroupLog(name, name .. " has been created by " .. getPlayerName(client) .. " (Account: " .. getAccountName(getPlayerAccount(client)) .. ")")
	end
end)

addEventHandler("onPlayerLogin", resourceRoot, function(_, acc)
	local account = getAccountName(acc)
	local result = dbPoll(dbQuery(con, "SELECT * FROM `group.members` WHERE player=?", account), -1)
	if result[1] == nil then return false end
	local res = dbPoll(dbQuery(con, "SELECT * FROM `groups` WHERE id=?", result[1].group_id), -1)
	if res[1] == nil then return false end
	setElementData(source, "Group", res[1].name)
end)

-- Group Chat
addCommandHandler("gc", function(thePlayer, _, ...)
	if isPlayerInGroup(thePlayer) ~= true then return end
    local msg = table.concat({...}, " ")
    local colorJson = getPlayerGroupInfo(thePlayer)["color"]
    local r, g, b = fromJSON(colorJson)[1], fromJSON(colorJson)[2], fromJSON(colorJson)[3]
    for _, v in ipairs(getOnlinePlayersInGroup(getPlayerGroupInfo(thePlayer)["name"])) do
    	outputChatBox("("..getPlayerGroupName(thePlayer)..") " .. getPlayerName(thePlayer) .. ": #FFFFFF" .. msg, v, r, g, b, true)
    end
end)

function outputGroupChat(player, ...)
local msg = table.concat({...}, " ")
    local colorJson = getPlayerGroupInfo(player)["color"]
    local r, g, b = fromJSON(colorJson)[1], fromJSON(colorJson)[2], fromJSON(colorJson)[3]
    for _, v in ipairs(getOnlinePlayersInGroup(getPlayerGroupInfo(player)["name"])) do
    	outputChatBox("("..getPlayerGroupName(player)..") #FFFFFF" .. msg, v, r, g, b, true)
    end
end

-- Invitation Handler

addEvent("UGCgroups.acceptInvite", true)
addEventHandler("UGCgroups.acceptInvite", resourceRoot, function(group)
	for _, v in ipairs(invitations[client]) do
		if v == group then
			local account = getAccountName(getPlayerAccount(client))
			triggerClientEvent(client, "UGCgroups.closeCreationWindow", resourceRoot)
			dbExec(con, "INSERT INTO `group.members` (group_id, player, rank_id, joined, warn) VALUES (?,?,?,?,?)", getGroupID(group), account, getGroupMemberRank(group), getRealTime().timestamp, 0)
			outputGroupChat(client, getPlayerName(client) .. " has joined your group!")
		end
	end
end)

-- Exports
---------->

function isPlayerInGroup(player)
	local account = getAccountName(getPlayerAccount(player))
	local result = dbPoll(dbQuery(con, "SELECT * FROM `group.members` WHERE player=?", account), -1)
	if #result ~= 0 then
		return true
	else
		return false
	end
end

function doesGroupExist(name)
	local result = dbPoll(dbQuery(con, "SELECT * FROM `groups` WHERE name=?", name), -1)
	if #result ~= 0 then
		return true
	else
		return false
	end
end

function getPlayerGroupID(player)
	local account = getAccountName(getPlayerAccount(player))
	local result = dbPoll(dbQuery(con, "SELECT * FROM `group.members` WHERE player=?", account), -1)
	for _, v in ipairs(result) do
		return v.group_id
	end
end

function getGroupID(group)
local result = dbPoll(dbQuery(con, "SELECT * FROM `groups` WHERE name=?", group), -1)
for _, v in ipairs(result) do
	return v.id
end
end

function getRankNameFromID(group, id)
	local result = dbPoll(dbQuery(con, "SELECT * FROM `group.ranks` WHERE id=? AND group_id=?", id, getGroupID(group)), -1)
	for _, v in ipairs(result) do
		return v.name
	end
end

function getRankNameFromRankId(id)
	local result = dbPoll(dbQuery(con, "SELECT * FROM `group.ranks` WHERE id=?", id), -1)
	for _, v in ipairs(result) do
		return v.name
	end
end

function getRankIDFromName(name)
	local result = dbPoll(dbQuery(con, "SELECT * FROM `group.ranks` WHERE name=?", name), -1)
	for _, v in ipairs(result) do
		return v.id
	end
end

function getPlayerGroupInfo(player)
	local account = getAccountName(getPlayerAccount(player))
	local result = dbPoll(dbQuery(con, "SELECT * FROM `group.members` WHERE player=?", account), -1)
	if result[1] == nil then return false end
	local res = dbPoll(dbQuery(con, "SELECT * FROM `groups` WHERE id=?", result[1].group_id), -1)
	if res[1] == nil then return false end
	local group = {}
	group["name"] = res[1].name
	group["creation"] = res[1].creationdate
	group["info"] = res[1].group_info
	group["color"] = res[1].group_color
	return group
end

function getGroupMembers(group)
	local result = dbPoll(dbQuery(con, "SELECT * FROM `group.members` WHERE group_id=?", getGroupID(group)), -1)
	local t = {}
	for _, v in ipairs(result) do
		local perm = getRankTotalPermissions(v.rank_id)
		local name = getRankNameFromID(group, v.rank_id)
		if (t[perm] == nil) then t[perm] = {} end
		table.insert(t[perm], {v.player, v.joined, v.warn, name})
	end
	return t
end

function getGroupRanks(group)
local ranks = {}
local result = dbPoll(dbQuery(con, "SELECT * FROM `group.ranks` WHERE group_id=?", getGroupID(group)), -1)
if result[1] == nil then return false end
for _, v in ipairs(result) do
	table.insert(ranks, {v.name, getRankTotalPermissions(v.id)})
end
return ranks
end

function getPlayerRank(player)
	if isPlayerInGroup(player) ~= true then return false end
	local account = getAccountName(getPlayerAccount(player))
	local result = dbPoll(dbQuery(con, "SELECT * FROM `group.members` WHERE player=?", account), -1)
	for _, v in ipairs(result) do
 		return v.rank_id
	end
end

function getPlayerPermission(player)
	local result = dbPoll(dbQuery(con, "SELECT * FROM `group.ranks` WHERE id=?", getPlayerRank(player)), -1) 
	if result[1] == nil then return false end
	for _, v in ipairs(result) do
		return v.permission
	end
end

function doesPlayerHavePermission(player, id)
	local result = dbPoll(dbQuery(con, "SELECT * FROM `group.ranks` WHERE id=?", getPlayerRank(player)), -1) 
	if result[1] == nil then return false end
	local tbl = fromJSON(result[1].permission)
	return tbl[id] or false
end

function getGroupFounder(group)
	local result = dbPoll(dbQuery(con, "SELECT * FROM `groups` WHERE name=?", group), -1)
	if result[1] == nil then return false end
	if getAccount(result[1].leader) then
		if getAccountPlayer(getAccount(result[1].leader)) then
			return getAccountPlayer(getAccount(result[1].leader))
		else
				for _, v in ipairs(result) do
					return v.leader
				end
		end
	end
end

function getRankPermissions(rankid)
	local result = dbPoll(dbQuery(con, "SELECT * FROM `group.ranks` WHERE id=?", rankid), -1) 
	if result[1] == nil then return false end
	for _, v in ipairs(result) do
		tbl = fromJSON(v.permission)
	end
	return tbl
end

function getOnlinePlayersInGroup(group)
	local result = dbPoll(dbQuery(con, "SELECT * FROM `group.members` WHERE group_id=?", getGroupID(group)), -1)
	local members = {}
	for _, v in ipairs(result) do
		if getAccountPlayer(getAccount(v.player)) then
			table.insert(members, getAccountPlayer(getAccount(v.player)))
		end
	end
	return members
end

function getPlayerGroupName(player)
	return getPlayerGroupInfo(player)["name"]
end

function insertGroupLog(group, log)
	local id = getGroupID(group)
	local query = dbExec(con, "INSERT INTO `group.logs` (group_id, log, timestamp) VALUES (?,?,?)", id, log, getRealTime().timestamp)
	if query then return true end
	return false
end

function getGroupTotalMembers(group)
	local result = dbPoll(dbQuery(con, "SELECT * FROM `group.members` WHERE group_id=?", getGroupID(group)), -1)
	return #result
end

function getGroupList()
	local result = dbPoll(dbQuery(con, "SELECT * FROM `groups`"), -1)
	local groups = {}
	for _, v in ipairs(result) do
		table.insert(groups, {v.name, v.leader, getGroupTotalMembers(v.name)})
	end
	return groups
end

function getGroupMemberRank(group)
	local result = dbPoll(dbQuery(con, "SELECT * FROM `group.ranks` WHERE group_id=? AND name=?", getGroupID(group), "Members"), -1) 
	for _, v in ipairs(result) do
		return v.id
	end
end

function getRankTotalPermissions(id)
	local result = dbPoll(dbQuery(con, "SELECT * FROM `group.ranks` WHERE id=?", id), -1) 
	local total = {}
	if result[1] == nil then return false end
	local tbl = fromJSON(result[1].permission)
	for _, v in ipairs(tbl) do
		if v == true then
			table.insert(total, v)
		end
	end
	return #total
end

function getPermissionTable()
	return perm
end

function getAccountWarning(accname)
	if getAccount(accname) then
		local result = dbPoll(dbQuery(con, "SELECT * FROM `group.members` WHERE player=?", accname), -1) 
		for _, v in ipairs(result) do
			return v.warn
		end
	end
end

-- Offline Account Based System
-------------------------------->
function getAccountRank(accname)
	local account = accname
	local result = dbPoll(dbQuery(con, "SELECT * FROM `group.members` WHERE player=?", account), -1)
	if result[1] == nil then return false end
	return result[1].rank_id
end

addEvent("UGCgroups.refreshMembers", true)
addEventHandler("UGCgroups.refreshMembers", resourceRoot, function()
	triggerClientEvent(client, "UGCgroups.refreshMembers", resourceRoot, getGroupMembers(getPlayerGroupName(client)), u2n)
end)

-- Group Invitations

addEventHandler("onResourceStart", resourceRoot, function()
	for _, v in ipairs(getElementsByType("player")) do
		local account = getPlayerAccount(v)
		if isPlayerInGroup(v) ~= true and isGuestAccount(account) ~= true then
			invitations[v] = {}
		end
	end
end)

addEventHandler("onPlayerLogin", getRootElement(), function(_, account)
	if isPlayerInGroup(source) ~= true and isGuestAccount(account) ~= true then
		invitations[source] = {}
	end
end)

addEventHandler("onPlayerQuit", getRootElement(), function()
	local account = getPlayerAccount(source)
	if invitations[source] ~= nil then
		invitations[source] = nil
	end
end)

