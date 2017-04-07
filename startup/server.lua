-------------------------------->
-- UGC: United Gaming Community
-- Author: Om Bhende (RipeMangoe69)
-- Date: 25 February 2017
-- Description: Server Startup Script
-- Script: startup/server.lua
-- Type: Server Sided
-------------------------------->

-- MTA Default Resources
------------------------>
local mtaResources = {
	"scoreboard",
	"admin",
	"runcode",
	"acpanel"
}

-- Main Function
---------------->
function onServerStart()
	--Load the resources with startup enabled
	local resources = getResources()
	for i, res in ipairs(resources) do
		local startup = getResourceInfo(res, "startup")
		if (startup == "true") then
			startResource(res, true)
		end
	end

	-- Default MTA resources
	for _, v in ipairs(mtaResources) do
		local resource = getResourceFromName(v)
		startResource(resource, true)
	end
end
addEventHandler("onResourceStart", resourceRoot, onServerStart)

--[[

-- Protected Resources
---------------------->
local protectedResources = {
	["admin"] = true,
	["acpanel"] = true
}
-
function onResourceStop(resource)
	local name = getResourceName(resource)
	if protectedResources[name] then
		cancelEvent()
		print("["..getResourceName(getThisResource()).."] Resource: " .. name .. " is protected!")
	end
end
addEventHandler("onResourceStop", getRootElement(), onResourceStop)

]]--