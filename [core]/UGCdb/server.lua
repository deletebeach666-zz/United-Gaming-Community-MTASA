-------------------------------->
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 2 March 2017
-- Script: UGCdb/server.lua
-- Type: Server Sided
-------------------------------->

-- Global Configuration
local host = "127.0.0.1"
local username = "username"
local password = "password"
local db = "database"

function getConnection()
	return dbConnect("mysql", "dbname=" .. db .. ";host=" .. host, username, password, "share=1")
end

function onStart()
local isConnected = getConnection()
	if isConnected then
		print("[MySQL] MySQL has been connected to server!")
	else
		print("[MySQL] Failed to connect to MySQL server")
	end
end
addEventHandler("onResourceStart", resourceRoot, onStart)
