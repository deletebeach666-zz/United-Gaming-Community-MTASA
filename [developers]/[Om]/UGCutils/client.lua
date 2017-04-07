---------------------->
-- Project: UGCRPG
-- Author: Om (RipeMangoes69)
-- Data: 13 March 2017
-- Description: Utility Resources.
------------------------->

function centerWindow(center_window)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return guiSetPosition(center_window, x, y, false)
end

setTimer(function()
	if isChatBoxInputActive() or isConsoleActive() then
		triggerServerEvent("UGCutils.typing", getRootElement(), true)
	else
		triggerServerEvent("UGCutils.typing", getRootElement(), false)
	end
end, 500, 0)

addCommandHandler("pos", function(cmd, tp)
local x, y, z = getElementPosition(localPlayer)
local dim, int = getElementDimension(localPlayer), getElementInterior(localPlayer)
local rx, ry, rz = getElementRotation(localPlayer)
	if tp == nil then
		outputChatBox("{"..x..", "..y..", "..z - 0.4 .."}")
	elseif tp == "skinshop" then
		outputChatBox("{"..x..", "..y..", "..z - 0.4 ..", "..rz..", "..dim..", "..int.."},")
	elseif tp == "atm" then
		outputChatBox("{"..x..", "..y..", "..z - 0.4 ..", "..rz.."},")
	end
end)

function generatePlate()
	local city = exports.UGCchat:getPlayerZone()
	return city .. 0 .. math.random(0, 9) .. math.random(1000, 9999)
end
