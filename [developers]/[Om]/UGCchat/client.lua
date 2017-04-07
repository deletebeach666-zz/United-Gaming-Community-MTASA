-------------------------------->
-- UGC: United Gaming Community
-- Author: Om Bhende (RipeMangoe69)
-- Date: 27 February 2017
-- Script: UGCchat/client.lua
-- Type: Client Sided
-------------------------------->

function outputMainChat(playerName, message)
triggerServerEvent("UGCchat.outputMainChat", resourceRoot, playerName, message)
end

-- Actual Chat System
local tab =  { 
        ['Los Santos'] = 'LS', 
        ['Red County'] = 'LS',
        ['Flint County'] = 'LS',
        ['Las Venturas'] = 'LV',
        ['Bone County'] = 'LV',
        ['San Fierro'] = 'SF',
        ['Tierra Robada'] = 'SF',
        ['Whetstone'] = 'SF',
    } 

function getPlayerZone()
    if getElementType(localPlayer) ~= "player" then return false, "Element is not player." end
    local x, y, z = getElementPosition(localPlayer)
    local zone = getZoneName(x, y, z, true)
    local zone = tab[zone]
    return zone
end