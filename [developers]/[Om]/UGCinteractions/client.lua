--[[ 
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 26 March 2017
-- Script: UGCinteractions/client.lua
-- Type: Client Sided
]]--

local sx, sy = guiGetScreenSize()
local showing = false


vehicle = {
    gridlist = {},
    window = {},
    button = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        vehicle.window[1] = guiCreateWindow(556, 224, 320, 252, "UGC:RPG - Vehicle Interactions", false)
        guiWindowSetSizable(vehicle.window[1], false)
        exports.UGCutils:centerWindow(vehicle.window[1])
        guiSetVisible(vehicle.window[1], false)

        vehicle.button[1] = guiCreateButton(10, 213, 147, 29, "Close", false, vehicle.window[1])
        guiSetFont(vehicle.button[1], "default-bold-small")
        guiSetProperty(vehicle.button[1], "NormalTextColour", "FFAAAAAA")
        vehicle.button[2] = guiCreateButton(157, 213, 147, 29, "Destroy", false, vehicle.window[1])
        guiSetEnabled(vehicle.button[2], false)
        guiSetFont(vehicle.button[2], "default-bold-small")
        guiSetProperty(vehicle.button[2], "NormalTextColour", "FFAAAAAA")
        vehicle.gridlist[1] = guiCreateGridList(9, 23, 295, 185, false, vehicle.window[1])
        key = guiGridListAddColumn(vehicle.gridlist[1], "Key", 0.5)
        value = guiGridListAddColumn(vehicle.gridlist[1], "Value", 0.5)    
    end
)


function renderInfo()
    dxDrawText("Click on an element", 0 - 1, sy*(219 - 1/768), sx*(1366/1366) - 1, sy*(289/768) - 1, tocolor(0, 0, 0, 255), 2.00, "bankgothic", "center", "top", false, false, false, false, false)
    dxDrawText("Click on an element", 0 + 1, sy*(219 + 1/768), sx*(1366/1366) + 1, sy*(289/768) - 1, tocolor(0, 0, 0, 255), 2.00, "bankgothic", "center", "top", false, false, false, false, false)
    dxDrawText("Click on an element", 0 - 1, sy*(219 - 1/768), sx*(1366/1366) - 1, sy*(289/768) + 1, tocolor(0, 0, 0, 255), 2.00, "bankgothic", "center", "top", false, false, false, false, false)
    dxDrawText("Click on an element", 0 + 1, sy*(219 + 1/768), sx*(1366/1366) + 1, sy*(289/768) + 1, tocolor(0, 0, 0, 255), 2.00, "bankgothic", "center", "top", false, false, false, false, false)
    dxDrawText("Click on an element", 0, sy*(219/768), sx*(1366/1366), sy*(289/768), tocolor(255, 255, 255, 255), 2.00, "bankgothic", "center", "top", false, false, false, false, false)
end

bindKey("x", "down", function()
	showCursor(not isCursorShowing())
	if isCursorShowing() == true then
		addEventHandler("onClientRender", root, renderInfo)
		showing = true
	else
		removeEventHandler("onClientRender", root, renderInfo)
		showing = false
	end
end)


addEventHandler("onClientClick", root, function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
	if button == "left" and showing == true and state == "down" then
		if type(clickedElement) ~= "boolean" then
			local x, y, z = getElementPosition(localPlayer)
			local ix, iy, iz = getElementPosition(clickedElement)
			local dist = getDistanceBetweenPoints3D(x, y, z, ix, iy, iz)
			if dist >= 25 then return exports.UGCnoty:sendNotification("You cant click on far objects!", 255, 0, 0) end
			--removeEventHandler("onClientRender", root, renderInfo)
			--showCursor(false)
			if getElementType(clickedElement) == "vehicle" then
				local veh = {}
				if exports.UGCspawners:getVehicleOwner(clickedElement) then
					veh["Vehicle Owner"] = getPlayerName(exports.UGCspawners:getVehicleOwner(clickedElement))
					veh["Spawned Vehicle"] = true
				end
				guiGridListClear(vehicle.gridlist[1])
				for k, v in pairs(veh) do
					local row = guiGridListAddRow(vehicle.gridlist[1])
					if k == "Vehicle Owner" then
						if getPlayerFromName(v) == localPlayer then
							guiSetEnabled(vehicle.button[2], true)
						end
					end
					guiGridListSetItemText(vehicle.gridlist[1], row, key, k, false, false)
					guiGridListSetItemText(vehicle.gridlist[1], row, value, tostring(v), false, false)
				end
				guiSetVisible(vehicle.window[1], true)
				showCursor(true)
			end
		end
	end
end)

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
	if source == vehicle.button[1] and btn == "left" then
		removeEventHandler("onClientRender", root, renderInfo)
		guiSetVisible(vehicle.window[1], false)
		showCursor(false)
	end
end)

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
	if source == vehicle.button[2] and btn == "left" then
		guiSetVisible(vehicle.window[1], false)
		showCursor(false)
		removeEventHandler("onClientRender", root, renderInfo)
		exports.UGCnoty:sendNotification("This feature is under development, use /djv instead.", 255, 0, 0)
	end
end)

