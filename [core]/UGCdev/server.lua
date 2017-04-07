----------------------->
-- United Gaming Community
-- Author: Om (RipeMangoes69)
-- Project: United Gaming Community
-- Date: 21 February 2017
-- Script: UGCdev/server.lua
-- Type: Server Sided
------------------------>

-- Table to send client-side
local resource = {}

-- Whitelist Table (If you're whitelisted, does not matter if you're in acl group or not, you'll get the panel's access)
------------------------------------------------------------------------------------------------------------------------>
local whitelist = {
	{username = "RipeMangoes69"} -- Om
} 


function fetchResource(player)
	table.sort(resource)
    for k, v in ipairs(getResources()) do
        local author = getResourceInfo(v, "author")
	    if author == false then
	    	resource[getResourceName(v)] = {getResourceState(v), "Unspecified"}
	    else
	    	resource[getResourceName(v)] = {getResourceState(v), getResourceInfo(v, "author"), getResourceInfo(v, "name")}
	    end
    end
    triggerClientEvent(player, "UGCdev.openDevelopersPanel", resourceRoot, resource)
end

function refreshTable()
	table.sort(resource)
   for k, v in ipairs(getResources()) do
        local author = getResourceInfo(v, "author")
	    if author == false then
	    	resource[getResourceName(v)] = {getResourceState(v), "Unspecified"}
	    else
	    	resource[getResourceName(v)] = {getResourceState(v), getResourceInfo(v, "author"), getResourceInfo(v, "name")}
	    end
    end
end

function toggleWindow(thePlayer)
local accountName = getAccountName(getPlayerAccount(thePlayer))
	for k, v in ipairs(whitelist) do
		if v.username == accountName or isObjectInACLGroup("user."..accountName, aclGetGroup("Developer")) then
			fetchResource(thePlayer)
		end
	end
end
addCommandHandler("resources", toggleWindow)

function startResources(player, resource)
	local res = getResourceFromName(resource)
	if getResourceState(res) == "running" then return outputChatBox("Resource: " .. resource .. " is already running!", player, 255, 0, 0) end
	if resource == nil or resource == "" then return outputChatBox("Resource: Please select a resource from gridlist!", player, 255, 0, 0) end
	startResource(res)
	outputChatBox("Resource: " .. resource .. " has been successfully started!", player, 0, 255, 0)
	refreshTable() -- Refreshes the resource table
	executeCommandHandler("refresh", player)
	executeCommandHandler("resources", player)
end
addEvent("UGCdev.startResource", true)
addEventHandler("UGCdev.startResource", resourceRoot, startResources)

function stopResources(player, resource)
if resource == nil or resource == "" then return outputChatBox("Resource: Please select a resource from gridlist!", player, 255, 0, 0) end
local res = getResourceFromName(resource)
if getResourceState(res) ~= "running" then return outputChatBox("Resource: " .. resource .. " is already stopped!", player, 255, 0, 0) end
stopResource(res)
outputChatBox("Resource: " .. resource .. " has been stopped!", player, 0, 255, 0)
refreshTable() -- Refreshes the resource table
setTimer(function()
	executeCommandHandler("refresh", player)
	executeCommandHandler("resources", player)
	end, 250, 1)
end
addEvent("UGCdev.stopResource", true)
addEventHandler("UGCdev.stopResource", resourceRoot, stopResources)

function restartResources(player, resource)
if resource == nil or resource == "" then return outputChatBox("Resource: Please select a resource from gridlist!", player, 255, 0, 0) end
local res = getResourceFromName(resource)
if getResourceState(res) ~= "running" then return outputChatBox("Resource: " .. resource .. " is stopped!", player, 255, 0, 0) end
restartResource(res)
outputChatBox("Resource: " .. resource .. " has been restarted!", player, 0, 255, 0)
refreshTable() -- Refreshes the resource table
setTimer(function()
	executeCommandHandler("refresh", player)
	executeCommandHandler("resources", player)
	end, 250, 1)
end
addEvent("UGCdev.restartResource", true)
addEventHandler("UGCdev.restartResource", resourceRoot, restartResources)

function refreshResourcesForClient(player)
refreshTable() -- Refreshes the resource table
	setTimer(function()
		executeCommandHandler("refresh", player)
		executeCommandHandler("resources", player)
		outputChatBox("Resource: Master Resource List has been successfully updated!", player, 0, 255, 0)
		end, 250, 1)
end
addEvent("UGCdev.refreshResources", true)
addEventHandler("UGCdev.refreshResources", resourceRoot, refreshResourcesForClient)
