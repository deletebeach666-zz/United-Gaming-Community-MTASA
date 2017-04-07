----------------------------------------------------------------------
--  Script Author: Swagy                                            --
--  Copyrights@Unitec Gaming Community 2017                         --
--  Description: Basic Housing System                               --
--  forum.curtcreation.net                                          --
----------------------------------------------------------------------

local font = guiCreateFont("font.ttf", 20)

label = guiCreateLabel(419, 415, 523, 85, "Press H to see House information", false)
guiSetFont(label, font)
guiLabelSetColor(label, 146, 189, 0)
guiSetVisible(label, false)


function popUp ()

	guiSetVisible(label,true)
end
addEvent("housing:Popup", true)	
addEventHandler("housing:Popup", root, popUp)

function popOut ()

	guiSetVisible(label,false)
end
addEvent("housing:Popout", true)	
addEventHandler("housing:Popout", root, popOut)



H = {
    button = {},
    window = {},
    edit = {},
    label = {}
}
H.window[1] = guiCreateWindow(426, 274, 545, 247, "UGC - Housing", false)
guiWindowSetMovable(H.window[1], false)
guiWindowSetSizable(H.window[1], false)

H.label[1] = guiCreateLabel(19, 29, 86, 19, "House owner:", false, H.window[1])
guiSetFont(H.label[1], "default-bold-small")
guiLabelSetColor(H.label[1], 187, 123, 0)
H.label[2] = guiCreateLabel(19, 68, 86, 19, "House price:", false, H.window[1])
guiSetFont(H.label[2], "default-bold-small")
guiLabelSetColor(H.label[2], 187, 123, 0)
H.label[3] = guiCreateLabel(19, 111, 86, 19, "House Interior:", false, H.window[1])
guiSetFont(H.label[3], "default-bold-small")
guiLabelSetColor(H.label[3], 187, 123, 0)
H.label[4] = guiCreateLabel(19, 158, 86, 19, "For sale:", false, H.window[1])
guiSetFont(H.label[4], "default-bold-small")
guiLabelSetColor(H.label[4], 187, 123, 0)
H.edit[1] = guiCreateEdit(20, 198, 194, 33, "Price...", false, H.window[1])
H.button[1] = guiCreateButton(219, 196, 92, 35, "Buy House", false, H.window[1])
guiSetProperty(H.button[1], "NormalTextColour", "FFAAAAAA")
H.button[2] = guiCreateButton(321, 196, 92, 35, "Set on sale", false, H.window[1])
guiSetProperty(H.button[2], "NormalTextColour", "FFAAAAAA")
H.button[3] = guiCreateButton(423, 196, 92, 35, "Enter house", false, H.window[1])
guiSetProperty(H.button[3], "NormalTextColour", "FFAAAAAA")
H.label[5] = guiCreateLabel(106, 27, 206, 21, "", false, H.window[1])
guiSetFont(H.label[5], "default-bold-small")
H.label[6] = guiCreateLabel(106, 66, 206, 21, "", false, H.window[1])
guiSetFont(H.label[6], "default-bold-small")
H.label[7] = guiCreateLabel(106, 109, 206, 21, "", false, H.window[1])
guiSetFont(H.label[7], "default-bold-small")
H.label[8] = guiCreateLabel(106, 156, 206, 21, "", false, H.window[1])
guiSetFont(H.label[8], "default-bold-small")
H.edit[2] = guiCreateEdit(321, 141, 92, 36, "Password...", false, H.window[1])
H.button[4] = guiCreateButton(423, 141, 92, 35, "Set password", false, H.window[1])
guiSetProperty(H.button[4], "NormalTextColour", "FFAAAAAA")
H.button[5] = guiCreateButton(423, 95, 92, 35, "Set new owner", false, H.window[1])
guiSetProperty(H.button[5], "NormalTextColour", "FFAAAAAA")
H.edit[3] = guiCreateEdit(321, 94, 92, 36, "Account name...", false, H.window[1])
H.button[6] = guiCreateButton(499, 21, 36, 31, "X", false, H.window[1])
guiSetFont(H.button[6], "default-bold-small")
guiSetProperty(H.button[6], "NormalTextColour", "FFFF0000")

guiSetVisible(H.window[1], false)

--Enter House GUI

EH = {
    button = {},
    window = {},
    edit = {},
    label = {}
}
EH.window[1] = guiCreateWindow(538, 299, 271, 138, "UGC Housing - Enter House", false)
guiWindowSetSizable(EH.window[1], false)

EH.label[1] = guiCreateLabel(72, 35, 127, 18, "Enter House Password", false, EH.window[1])
guiSetFont(EH.label[1], "default-bold-small")
EH.edit[1] = guiCreateEdit(28, 63, 218, 30, "N/A", false, EH.window[1])
EH.button[1] = guiCreateButton(28, 103, 103, 25, "Enter", false, EH.window[1])
guiSetProperty(EH.button[1], "NormalTextColour", "FFAAAAAA")
EH.button[2] = guiCreateButton(143, 103, 103, 25, "Close", false, EH.window[1])
guiSetProperty(EH.button[2], "NormalTextColour", "FFAAAAAA")

guiSetVisible(EH.window[1], false)

--House Creation Window


HC = {
    button = {},
    window = {},
    edit = {},
    label = {}
}
HC.window[1] = guiCreateWindow(38, 41, 366, 435, "UGC Housing - Add house", false)
guiWindowSetSizable(HC.window[1], false)

HC.label[1] = guiCreateLabel(10, 24, 103, 19, "Entry X (Outside)", false, HC.window[1])
guiSetFont(HC.label[1], "default-bold-small")
HC.edit[1] = guiCreateEdit(9, 53, 103, 28, "", false, HC.window[1])
HC.label[2] = guiCreateLabel(10, 91, 103, 19, "Entry Y (Outside)", false, HC.window[1])
guiSetFont(HC.label[2], "default-bold-small")
HC.edit[2] = guiCreateEdit(9, 120, 103, 28, "", false, HC.window[1])
HC.label[3] = guiCreateLabel(9, 158, 103, 19, "Entry Z (Outside)", false, HC.window[1])
guiSetFont(HC.label[3], "default-bold-small")
HC.edit[3] = guiCreateEdit(9, 187, 103, 28, "", false, HC.window[1])
HC.button[1] = guiCreateButton(9, 222, 103, 40, "Copy my position", false, HC.window[1])
guiSetProperty(HC.button[1], "NormalTextColour", "FFAAAAAA")
HC.label[4] = guiCreateLabel(10, 272, 103, 19, "Exit X (Inside)", false, HC.window[1])
guiSetFont(HC.label[4], "default-bold-small")
HC.edit[4] = guiCreateEdit(9, 301, 103, 28, "", false, HC.window[1])
HC.label[5] = guiCreateLabel(10, 339, 103, 19, "Exit Y (Inside)", false, HC.window[1])
guiSetFont(HC.label[5], "default-bold-small")
HC.edit[5] = guiCreateEdit(9, 368, 103, 28, "", false, HC.window[1])
HC.label[6] = guiCreateLabel(146, 24, 103, 19, "Exit Z (Inside)", false, HC.window[1])
guiSetFont(HC.label[6], "default-bold-small")
HC.edit[6] = guiCreateEdit(146, 53, 103, 28, "", false, HC.window[1])
HC.button[2] = guiCreateButton(146, 91, 103, 40, "Copy my position", false, HC.window[1])
guiSetProperty(HC.button[2], "NormalTextColour", "FFAAAAAA")
HC.label[7] = guiCreateLabel(146, 158, 103, 19, "Dimension", false, HC.window[1])
guiSetFont(HC.label[7], "default-bold-small")
HC.edit[7] = guiCreateEdit(146, 187, 103, 28, "", false, HC.window[1])
HC.label[8] = guiCreateLabel(146, 225, 103, 19, "Interior", false, HC.window[1])
guiSetFont(HC.label[8], "default-bold-small")
HC.edit[8] = guiCreateEdit(146, 254, 103, 28, "", false, HC.window[1])
HC.label[9] = guiCreateLabel(146, 292, 103, 19, "Owner", false, HC.window[1])
guiSetFont(HC.label[9], "default-bold-small")
HC.edit[9] = guiCreateEdit(146, 311, 103, 28, "", false, HC.window[1])
HC.label[10] = guiCreateLabel(146, 348, 103, 19, "Price", false, HC.window[1])
guiSetFont(HC.label[10], "default-bold-small")
HC.edit[10] = guiCreateEdit(146, 368, 103, 28, "", false, HC.window[1])
HC.button[3] = guiCreateButton(10, 401, 102, 23, "Create House", false, HC.window[1])
guiSetProperty(HC.button[3], "NormalTextColour", "FFAAAAAA")
HC.button[4] = guiCreateButton(146, 401, 102, 23, "Close", false, HC.window[1])
guiSetProperty(HC.button[4], "NormalTextColour", "FFAAAAAA")
HC.label[11] = guiCreateLabel(255, 25, 102, 112, "Notes:\n\n*Two houses\nwith the same \ninterior and same\n dimension\nwill cause BUGS !", false, HC.window[1])
guiSetFont(HC.label[11], "default-bold-small")
guiLabelSetColor(HC.label[11], 255, 0, 0)

guiSetVisible(HC.window[1], false)



function closeAllGUIs ()
	guiSetVisible(H.window[1], false)
	guiSetVisible(EH.window[1], false)
	showCursor(false)
end	


function openOwnerWindow (owner, sale, price, interior)

	guiSetVisible(H.window[1], true)
	exports.UGCutils:centerWindow(H.window[1])
	showCursor(true)
	guiSetEnabled(H.button[1], false)
	if (tonumber(sale) == 0) then
		guiSetEnabled(H.button[2], true)
		guiSetText(H.label[8], "Yes")
	else
		guiSetEnabled(H.button[2], true)	
		guiSetText(H.label[8], "No")
	end
	guiSetText(H.label[5], tostring(owner))
	guiSetText(H.label[6], "$"..tostring(exports.UGCutils:tocomma(price)).."")
	guiSetText(H.label[7], tostring(interior))
end
addEvent("housing:openOwnerWindow", true)
addEventHandler("housing:openOwnerWindow", root, openOwnerWindow)

function openWindow (owner, sale, price, interior)

	guiSetVisible(H.window[1], true)
	exports.UGCutils:centerWindow(H.window[1])
	guiSetText(H.label[5], tostring(owner))
	guiSetText(H.label[6], "$"..tostring(exports.UGCutils:tocomma(price)).."")
	guiSetText(H.label[7], tostring(interior))
	if (tonumber(sale) ~= 0) then
		guiSetEnabled(H.button[1], false)
		guiSetEnabled(H.button[2], false)
		guiSetEnabled(H.button[4], false)
		guiSetEnabled(H.button[5], false)
		guiSetEnabled(H.edit[1], false)
		guiSetEnabled(H.edit[2], false)
		guiSetEnabled(H.edit[3], false)
	else
		guiSetEnabled(H.button[1], true)
		guiSetEnabled(H.button[2], false)
		guiSetEnabled(H.button[4], false)
		guiSetEnabled(H.button[5], false)
		guiSetEnabled(H.edit[1], false)
		guiSetEnabled(H.edit[2], false)
		guiSetEnabled(H.edit[3], false)
	end	
	showCursor(true)
end
addEvent("housing:openWindow", true)
addEventHandler("housing:openWindow", root, openWindow)

function closeWindow()

	if (source == H.button[6]) then
		guiSetVisible(H.window[1], false)
		showCursor(false) 
	end
end
addEventHandler("onClientGUIClick", root, closeWindow)		


function enterHouseWindowHandlers ()

	if (source == H.button[3]) then
		guiSetVisible(H.window[1], false)
		guiSetVisible(EH.window[1], true)
	elseif (source == EH.button[1]) then
		triggerServerEvent("checkServerAccess", resourceRoot, localPlayer)	
	end
end
addEventHandler("onClientGUIClick", root, enterHouseWindowHandlers)		

function closeEnterHouseWindow ()

	if (source == EH.button[2]) then
		guiSetVisible(EH.window[1], false)
		showCursor(false)
	end
end
addEventHandler("onClientGUIClick", root, closeEnterHouseWindow)		


function checkAccessToHouse (password, hx, hy, hz, interior)

	local pass = guiGetText (EH.edit[1])
	if (pass == tostring(password)) or (tostring(password) == "N/A") or (tostring(password) == "false") then
		triggerServerEvent("housing:enterHouse", resourceRoot, localPlayer, hx, hy, hz, interior)
		closeAllGUIs()
	else
		outputChatBox("Wrong password ! Try again", 255,0,0)
	end
end
addEvent("housing:checkAccess", true)
addEventHandler("housing:checkAccess", root, checkAccessToHouse)

function setNewPassword ()

	local password = guiGetText(H.edit[2])
	if (source == H.button[4]) then
		triggerServerEvent("housing:changePassword", resourceRoot, localPlayer, password)
		closeAllGUIs()
	end
end
addEventHandler("onClientGUIClick", root, setNewPassword)		


function putOnSale ()

	local price = guiGetText(H.edit[1])
	if (source == H.button[2]) then
		triggerServerEvent("housing:putOnSale", resourceRoot, localPlayer, price)
		closeAllGUIs()
	end
end
addEventHandler("onClientGUIClick", root, putOnSale)	

function setNewOwner ()

	local owner = guiGetText(H.edit[3])
	if (source == H.button[5]) then
		triggerServerEvent("housing:changeOwner", resourceRoot, localPlayer, owner)
		closeAllGUIs()
	end
end
addEventHandler("onClientGUIClick", root, setNewOwner)

function buyHouse ()

	if (source == H.button[1]) then
		triggerServerEvent("housing:buyHouse", resourceRoot, localPlayer)
		closeAllGUIs()
	end
end
addEventHandler("onClientGUIClick", root, buyHouse)


function openHouseBuildingWindow()

	guiSetVisible(HC.window[1], true)
	showCursor(true)
	exports.UGCutils:centerWindow(HC.window[1])

end
addEvent("housing:openBuildingWindow", true)
addEventHandler("housing:openBuildingWindow", root, openHouseBuildingWindow)

function closeBuildingWindow()

	if (source == HC.button[4]) then
		guiSetVisible(HC.window[1], false)
		showCursor(false)
	elseif (source == HC.button[1]) then
		local x,y,z = getElementPosition(localPlayer)
		guiSetText(HC.edit[1], tostring(x))
		guiSetText(HC.edit[2], tostring(y))
		guiSetText(HC.edit[3], tostring(z))
	elseif (source == HC.button[2]) then
		local x,y,z = getElementPosition(localPlayer)
		guiSetText(HC.edit[4], tostring(x))
		guiSetText(HC.edit[5], tostring(y))
		guiSetText(HC.edit[6], tostring(z))	
	end
end
addEventHandler("onClientGUIClick", root, closeBuildingWindow)		

function createHouse ()

	if (source == HC.button[3]) then
		local x = guiGetText (HC.edit[1])
		local y = guiGetText (HC.edit[2])
		local z = guiGetText (HC.edit[3])
		local hx = guiGetText (HC.edit[4])
		local hy = guiGetText (HC.edit[5])
		local hz = guiGetText (HC.edit[6])
		local dimension = guiGetText (HC.edit[7])
		local interior = guiGetText (HC.edit[8])
		local owner = guiGetText (HC.edit[9])
		local price = guiGetText (HC.edit[10])

		triggerServerEvent("housing:createHouse", resourceRoot, localPlayer, x,y,z,hx,hy,hz,dimension,interior,owner,price)
	end	

end
addEventHandler("onClientGUIClick", root, createHouse)	