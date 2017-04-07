--[[ 
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 26 March 2017
-- Script: UGCspawners/client.lua
-- Type: Client Sided
]]--

local vehRot = nil
local vehPos = nil
local vehColor = nil

spawner = {
    gridlist = {},
    window = {},
    button = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        spawner.window[1] = guiCreateWindow(558, 244, 240, 304, "Vehicle Spawner", false)
        guiWindowSetSizable(spawner.window[1], false)
        guiSetVisible(spawner.window[1], false)
        exports.UGCutils:centerWindow(spawner.window[1])

        spawner.gridlist[1] = guiCreateGridList(9, 24, 224, 240, false, spawner.window[1])
        veh = guiGridListAddColumn(spawner.gridlist[1], "Vehicle", 0.9)
        spawner.button[1] = guiCreateButton(9, 268, 109, 28, "Close", false, spawner.window[1])
        guiSetFont(spawner.button[1], "default-bold-small")
        guiSetProperty(spawner.button[1], "NormalTextColour", "FFAAAAAA")
        spawner.button[2] = guiCreateButton(118, 268, 115, 28, "Spawn", false, spawner.window[1])
        guiSetFont(spawner.button[2], "default-bold-small")
        guiSetProperty(spawner.button[2], "NormalTextColour", "FFAAAAAA")    
    end
)

addEvent("UGCspawners.openWindow", true)
addEventHandler("UGCspawners.openWindow", resourceRoot, function(vehTable, Rot, pos, color)
	vehRot = Rot
	vehPos = pos
    vehColor = color
    guiSetVisible(spawner.window[1], true)
    showCursor(true)
    guiGridListClear(spawner.gridlist[1])
    for _, v in ipairs(vehTable) do
        local row = guiGridListAddRow(spawner.gridlist[1])
        guiGridListSetItemText(spawner.gridlist[1], row, veh, getVehicleNameFromModel(v), false, false)
    end
end)

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if source == spawner.button[1] and btn == "left" then
        guiSetVisible(spawner.window[1], false)
        showCursor(false)
    end
end)

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if source == spawner.button[2] and btn == "left" then
    	local veh = guiGridListGetItemText(spawner.gridlist[1], guiGridListGetSelectedItem(spawner.gridlist[1]), 1)
    	if veh == "" or veh == nil then return exports.UGCnoty:sendNotification("You have to select vehicle to spawn it!", 255, 0, 0) end
    	triggerServerEvent("UGCspawners.spawnVehicle", resourceRoot, veh, vehRot, vehPos, vehColor)
        guiSetVisible(spawner.window[1], false)
        showCursor(false)
    end
end)

function getVehicleOwner(vehicle)
    if getElementType(vehicle) ~= "vehicle" then return false end
    return getElementData(vehicle, "UGCspawners:getVehicleOwner") or false
end
