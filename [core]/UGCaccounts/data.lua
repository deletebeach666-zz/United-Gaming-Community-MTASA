-------------------------------->
-- UGC: United Gaming Community
-- Author: Om Bhende (RipeMangoe69)
-- Date: 10 March 2017
-- Script: UGCaccounts/data.lua
-- Type: Server Sided
-------------------------------->

local con = exports.UGCdb:getConnection()

function getData(account, key)
	local query = dbQuery(con, "SELECT * FROM `accounts` WHERE username=?", getAccountName(account))
	local row = dbPoll(query, -1)
	local tbl = fromJSON(row[1].custom_data)
	return tbl[key]
end

function setData(account, key, value)
	local query = dbQuery(con, "SELECT * FROM `accounts` WHERE username=?", getAccountName(account))
	local row = dbPoll(query, -1)
	local tbl = fromJSON(row[1].custom_data)
	tbl[key] = value
	local exec = dbExec(con, "UPDATE `accounts` SET custom_data=? WHERE username=?", toJSON(tbl), getAccountName(account))	
	tbl = {}
	if exec then return true end
	return false
end