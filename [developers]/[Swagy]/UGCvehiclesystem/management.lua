
M = {
    gridlist = {},
    window = {},
    button = {}
}
M.window[1] = guiCreateWindow(278, 209, 759, 317, "UGC:RPG - My Vehicles", false)
guiWindowSetSizable(M.window[1], false)

M.gridlist[1] = guiCreateGridList(139, 22, 614, 286, false, M.window[1])
guiGridListAddColumn(M.gridlist[1], "ID", 0.2)
guiGridListAddColumn(M.gridlist[1], "Vehicle", 0.4)
guiGridListAddColumn(M.gridlist[1], "Health", 0.3)
guiGridListAddColumn(M.gridlist[1], "City", 0.4)
guiGridListAddColumn(M.gridlist[1], "x", 0.1)
guiGridListAddColumn(M.gridlist[1], "y", 0.1)
guiGridListAddColumn(M.gridlist[1], "z", 0.1)
guiGridListAddColumn(M.gridlist[1], "rot", 0.1)
guiGridListAddColumn(M.gridlist[1], "r", 0.1)
guiGridListAddColumn(M.gridlist[1], "g", 0.1)
guiGridListAddColumn(M.gridlist[1], "b", 0.1)
guiGridListAddColumn(M.gridlist[1], "Plate", 0.4)
M.button[1] = guiCreateButton(9, 24, 124, 32, "Spawn Vehicle", false, M.window[1])
guiSetProperty(M.button[1], "NormalTextColour", "FFAAAAAA")
M.button[2] = guiCreateButton(9, 66, 124, 32, "Despawn Vehicle", false, M.window[1])
guiSetProperty(M.button[2], "NormalTextColour", "FFAAAAAA")
M.button[3] = guiCreateButton(9, 108, 124, 32, "Recover", false, M.window[1])
guiSetProperty(M.button[3], "NormalTextColour", "FFAAAAAA")
M.button[4] = guiCreateButton(9, 150, 124, 32, "Mark", false, M.window[1])
guiSetProperty(M.button[4], "NormalTextColour", "FFAAAAAA")
M.button[5] = guiCreateButton(9, 192, 124, 32, "Unmark", false, M.window[1])
guiSetProperty(M.button[5], "NormalTextColour", "FFAAAAAA")
M.button[6] = guiCreateButton(9, 234, 124, 32, "Spectate", false, M.window[1])
guiSetProperty(M.button[6], "NormalTextColour", "FFAAAAAA")
M.button[7] = guiCreateButton(9, 276, 124, 32, "Sell", false, M.window[1])
guiSetProperty(M.button[7], "NormalTextColour", "FFAAAAAA")

guiSetVisible(M.window[1], false)


function openManagementWindow(table)

	if (guiGetVisible(M.window[1]) == false) then
		guiSetVisible(M.window[1], true)
		showCursor(true)
		guiGridListClear(M.gridlist[1])
		for k,v in ipairs (table) do
			row = guiGridListAddRow (M.gridlist[1])
			guiGridListSetItemText ( M.gridlist[1], row, 1, v.id, false, false )
			guiGridListSetItemText ( M.gridlist[1], row, 2, getVehicleNameFromModel(v.id), false, false )
			if (v.spawned == "true") then
				guiGridListSetItemColor (M.gridlist[1] , row, 2, 255, 255, 0 )
			else
				guiGridListSetItemColor (M.gridlist[1] , row, 2, 255, 0, 0 )
			end	
			local hp = tonumber(v.health)
			local health = math.ceil(hp/10)
			guiGridListSetItemText ( M.gridlist[1], row, 3, ""..health.."%", false, false )
			guiGridListSetItemText ( M.gridlist[1], row, 4, tostring(getZoneName(v.x, v.y, v.z, true)), false, false )
			guiGridListSetItemText ( M.gridlist[1], row, 5, v.x, false, false )
			guiGridListSetItemText ( M.gridlist[1], row, 6, v.y, false, false )
			guiGridListSetItemText ( M.gridlist[1], row, 7, v.z, false, false )
			guiGridListSetItemText ( M.gridlist[1], row, 8, v.rot, false, false )
			guiGridListSetItemText ( M.gridlist[1], row, 9, v.r, false, false )
			guiGridListSetItemText ( M.gridlist[1], row, 10, v.g, false, false )
			guiGridListSetItemText ( M.gridlist[1], row, 11, v.b, false, false )
			guiGridListSetItemText ( M.gridlist[1], row, 12, v.plate, false, false )
		end	
	else
		guiSetVisible(M.window[1], false)
		showCursor(false)
		guiGridListClear(M.gridlist[1])		
	end
end
addEvent("management:openManagementWindow", true)
addEventHandler("management:openManagementWindow", root, openManagementWindow)	


function despawnVehicle ()

	if (source == M.button[2]) then
		local id = guiGridListGetItemText ( M.gridlist[1], guiGridListGetSelectedItem ( M.gridlist[1] ), 1 )
		guiSetVisible(M.window[1], false)
		showCursor(false)
		guiGridListClear(M.gridlist[1])	
		triggerServerEvent("vehicles:despawnVehicle", resourceRoot, localPlayer, id)
	elseif (source == M.button[1]) then
		local id = guiGridListGetItemText ( M.gridlist[1], guiGridListGetSelectedItem ( M.gridlist[1] ), 1 )
		local x = tonumber(guiGridListGetItemText ( M.gridlist[1], guiGridListGetSelectedItem ( M.gridlist[1] ), 5 ))
		local y = tonumber(guiGridListGetItemText ( M.gridlist[1], guiGridListGetSelectedItem ( M.gridlist[1] ), 6 ))
		local z = tonumber(guiGridListGetItemText ( M.gridlist[1], guiGridListGetSelectedItem ( M.gridlist[1] ), 7 ))
		local r = tonumber(guiGridListGetItemText ( M.gridlist[1], guiGridListGetSelectedItem ( M.gridlist[1] ), 9 ))
		local g = tonumber(guiGridListGetItemText ( M.gridlist[1], guiGridListGetSelectedItem ( M.gridlist[1] ), 10 ))
		local b = tonumber(guiGridListGetItemText ( M.gridlist[1], guiGridListGetSelectedItem ( M.gridlist[1] ), 11 ))
		local rot = tonumber(guiGridListGetItemText ( M.gridlist[1], guiGridListGetSelectedItem ( M.gridlist[1] ), 8 ))
		local hp = guiGridListGetItemText ( M.gridlist[1], guiGridListGetSelectedItem ( M.gridlist[1] ), 3 )
		local plate = guiGridListGetItemText ( M.gridlist[1], guiGridListGetSelectedItem ( M.gridlist[1] ), 12 )
		guiSetVisible(M.window[1], false)
		showCursor(false)
		guiGridListClear(M.gridlist[1])	
		triggerServerEvent("vehicles:spawnVehicle", resourceRoot, localPlayer, tonumber(id), x, y, z, r, g, b, rot, hp, plate)	
	elseif (source == M.button[3]) then
		triggerServerEvent("vehicles:recoverVehicle", resourceRoot, localPlayer)	
	elseif (source == M.button[4]) then
		triggerServerEvent("vehicles:markVehicle", resourceRoot, localPlayer)	
	elseif (source == M.button[5]) then
		triggerServerEvent("vehicles:unmarkVehicle", resourceRoot, localPlayer)	
	elseif (source == M.button[6]) then
		triggerServerEvent("vehicles:spectateVehicle", resourceRoot, localPlayer)	
	end		
end
addEventHandler("onClientGUIClick", root, despawnVehicle)