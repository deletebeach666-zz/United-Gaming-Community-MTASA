local shops = {}

local buyR, buyG, buyB = nil

local vehShops = {
	
	{x = 2131.7006835938, y = -1149.6912841797, z = 22.838025665283,  lookAtX = 2134.5583496094, lookAtY = -1133.7883300781, lookAtZ = 25.289796447754, camX = 2112.16015625, camY = -1129.5274658203, camZ = 36.903737640381, carX = 2134.5583496094, carY = -1133.7883300781, carZ = 25.289796447754, type = "cars"}
}

local cars = {
	
	{"Bullet", 250000},
	{"Taxi", 80000}
}


for k,v in ipairs (vehShops) do

	marker = createMarker(v.x,v.y,v.z, "cylinder", 2.5,255,255,0,255)
	if (v.type == "cars") then
		blip = createBlipAttachedTo (marker, 55)
	elseif (v.type == "planes") then
		blip = createBlipAttachedTo(marker, 5)	
	elseif (v.type == "trucks") then
		blip = createBlipAttachedTo(marker, 11)	
	elseif (v.type == "bikes") then
		blip = exports.customblips:createCustomBlip(v.x, v.y, 20, 20, "images/bikes.png")	
	end
	shops[marker] = k
end		


VS = {
    gridlist = {},
    window = {},
    button = {},
    label = {}
}
       VS.window[1] = guiCreateWindow(10, 261, 281, 476, "UGC:RPG - Vehicle Store", false)
        guiWindowSetSizable(VS.window[1], false)

        VS.gridlist[1] = guiCreateGridList(9, 26, 267, 390, false, VS.window[1])
        guiGridListAddColumn(VS.gridlist[1], "ID", 0.2)
        guiGridListAddColumn(VS.gridlist[1], "Vehicle", 0.5)
        guiGridListAddColumn(VS.gridlist[1], "Price", 0.5)
        VS.button[1] = guiCreateButton(9, 422, 132, 22, "Buy", false, VS.window[1])
        guiSetFont(VS.button[1], "default-bold-small")
        guiSetProperty(VS.button[1], "NormalTextColour", "FFAAAAAA")
        VS.button[2] = guiCreateButton(141, 422, 130, 22, "Change Color", false, VS.window[1])
        guiSetFont(VS.button[2], "default-bold-small")
        guiSetProperty(VS.button[2], "NormalTextColour", "FFAAAAAA")
        VS.button[3] = guiCreateButton(9, 444, 132, 22, "Test Driving", false, VS.window[1])
        guiSetFont(VS.button[3], "default-bold-small")
        guiSetProperty(VS.button[3], "NormalTextColour", "FFAAAAAA")
        VS.button[4] = guiCreateButton(141, 444, 130, 22, "Cancel", false, VS.window[1])
        guiSetFont(VS.button[4], "default-bold-small")
        guiSetProperty(VS.button[4], "NormalTextColour", "FFAAAAAA")    

guiSetVisible(VS.window[1], false)


function onVehshopHit (hElem, matchingDim)

	if (matchingDim) then
		if (hElem == localPlayer) then
			if (shops[source]) and (isPedOnGround(hElem)) and not (isPedInVehicle(hElem)) then
				setElementData(hElem, "vehshopHit", source)
				local type = vehShops[shops[source]].type
				guiSetVisible(VS.window[1], true)
				showCursor(true)
				guiGridListClear(VS.gridlist[1])
				if (type == "cars") then
					for k,v in ipairs (cars) do
						local row = guiGridListAddRow ( VS.gridlist[1] )
                        guiGridListSetItemText ( VS.gridlist[1], row, 1, getVehicleModelFromName(v[1]), false, false )
                        guiGridListSetItemText ( VS.gridlist[1], row, 2, v[1], false, false )
                        guiGridListSetItemText ( VS.gridlist[1], row, 3, tostring(v[2]), false, false )
                     end 
                elseif (type == "planes") then 
					for k,v in ipairs (planes) do
						local row = guiGridListAddRow ( VS.gridlist[1] )
                        guiGridListSetItemText ( VS.gridlist[1], row, 1, getVehicleModelFromName(v[1]), false, false )
                        guiGridListSetItemText ( VS.gridlist[1], row, 2, v[1], false, false )
                        guiGridListSetItemText ( VS.gridlist[1], row, 3, tostring(v[2]), false, false )
                     end
                elseif (type == "trucks") then 
                	for k,v in ipairs (trucks) do
						local row = guiGridListAddRow ( VS.gridlist[1] )
                        guiGridListSetItemText ( VS.gridlist[1], row, 1, getVehicleModelFromName(v[1]), false, false )
                        guiGridListSetItemText ( VS.gridlist[1], row, 2, v[1], false, false )
                        guiGridListSetItemText ( VS.gridlist[1], row, 3, tostring(v[2]), false, false )
                     end 
                elseif (type == "bikes") then
					for k,v in ipairs (bikes) do
						local row = guiGridListAddRow ( VS.gridlist[1] )
                        guiGridListSetItemText ( VS.gridlist[1], row, 1, getVehicleModelFromName(v[1]), false, false )
                        guiGridListSetItemText ( VS.gridlist[1], row, 2, v[1], false, false )
                        guiGridListSetItemText ( VS.gridlist[1], row, 3, tostring(v[2]), false, false )
                     end      
                end   
            end
        end
    end
end                  
addEventHandler("onClientMarkerHit", root, onVehshopHit)

function closeShopWindow ()

	if (source == VS.button[4]) then
		guiSetVisible(VS.window[1], false)
		showCursor(false)
		setCameraTarget(localPlayer)
		if (isElement(previewVehicle)) then
			destroyElement(previewVehicle)
			exports.cpicker:closePicker(previewVehicle)
		end	
	end
end
addEventHandler("onClientGUIClick", root, closeShopWindow)	


function buttonsHandlers()

	if (source == VS.gridlist[1]) then
		local marker = getElementData(localPlayer, "vehshopHit")
		local camX = vehShops[shops[marker]].camX
		local camY = vehShops[shops[marker]].camY	
		local camZ = vehShops[shops[marker]].camZ
		local lookAtX = vehShops[shops[marker]].lookAtX
		local lookAtY = vehShops[shops[marker]].lookAtY
		local lookAtZ = vehShops[shops[marker]].lookAtZ
		local id = guiGridListGetItemText ( VS.gridlist[1], guiGridListGetSelectedItem ( VS.gridlist[1] ), 1 )
		if (tonumber(id)) then
			if not (isElement(previewVehicle)) then
				setCameraMatrix(camX, camY, camZ, lookAtX, lookAtY, lookAtZ)
				previewVehicle = createVehicle(tonumber(id), lookAtX, lookAtY, lookAtZ)
			else 
				destroyElement(previewVehicle)
				setCameraMatrix(camX, camY, camZ, lookAtX, lookAtY, lookAtZ)
				previewVehicle = createVehicle(tonumber(id), lookAtX, lookAtY, lookAtZ)
			end
		end			
	elseif (source == VS.button[2]) then
		if (isElement(previewVehicle)) then
			exports.cpicker:openPicker(localPlayer, "#FFAAAAAA", "Choose a color;")	
		else
			exports.UGCnoty:sendNotification("You need to select a vehicle first!", 255,0,0)	
			guiSetVisible(VS.window[1], false)
			showCursor(false)
			setCameraTarget(localPlayer)
		end	
	elseif (source == VS.button[1]) then	
		local marker = getElementData(localPlayer, "vehshopHit")
		if (isElement(previewVehicle)) then
			local x,y,z = getElementPosition(previewVehicle)
			local r,g,b = getVehicleColor(previewVehicle)
			local id = getVehicleModel(previewVehicle)
			local price = guiGridListGetItemText ( VS.gridlist[1], guiGridListGetSelectedItem ( VS.gridlist[1] ), 1 )
			if (price) then
				triggerServerEvent("vehicles:buyVehicle", resourceRoot, localPlayer, id, x,y,z, buyR, buyG, buyB, tonumber(price))
				destroyElement(previewVehicle)	
				setCameraTarget(localPlayer)
				guiSetVisible(VS.window[1], false)
				showCursor(false)
			else
				exports.UGCnoty:sendNotification("You didn't select a vehicle!",255,0,0)
			end		
		else
			exports.UGCnoty:sendNotification("You didn't select a vehicle!",255,0,0)	
		end	
	end
end
addEventHandler("onClientGUIClick", root, buttonsHandlers)		


addEventHandler("onColorPickerChange", resourceRoot, 
function(element, hex, r, g, b)
	if (isElement(previewVehicle)) then
		setVehicleColor(previewVehicle, r, g, b)
		buyR, buyG, buyB = r,g,b
	end	
end)
