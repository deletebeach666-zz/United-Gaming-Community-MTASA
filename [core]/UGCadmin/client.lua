--[[
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 15 March 2017
-- Project: UGC:RPG
-- Script: UGCadmin/client.lua
-- Type: Client Sided
]]--
local canFly = false

addEvent("UGCadmin.setAdminFly", true)
addEventHandler("UGCadmin.setAdminFly", resourceRoot, function()
	 if (canFly == false) then 
            canFly = true 
            setWorldSpecialPropertyEnabled("aircars", true) 
			exports.UGCnoty:sendNotification("Fly Mode: On", 0, 255, 0)
        else 
            canFly = false 
            setWorldSpecialPropertyEnabled("aircars", false) 
			exports.UGCnoty:sendNotification("Fly Mode: Off", 0, 255, 0)
        end 
end)
