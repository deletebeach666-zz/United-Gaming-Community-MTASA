-------------------------
-- UGC: United Gaming Community
-- Author: Om
-- Date: 13 March 2017
-- File UGCnoty/client.lua
-- Type: Client Sided
-------------------------
local messages = {}

local sX,sY = guiGetScreenSize()
local aX,aY,aW,aH = sX*(0.25), (sY*0.95)-20, sX*0.75, sY*0.95
if (sX <= 1280) then
	aX,aY,aW,aH = (sX/2)-(1280/4), (sY*0.95)-20, (sX/2)+(1280/4), sY*0.95
end

local font = "default-bold"
local DISPLAY_TIME = 7500


function sendNotification(text, r, g, b)
	if text == nil then return error("sendNotification: No Text Parameter Given") end
	if (type(text) ~= "string") then return false end
	r = r or 255
	g = g or 255
	b = b or 255
	if (r > 255 or g > 255 or b > 255) then return false end
	if (#messages == math.floor((sY*0.2)/20)) then
		table.remove(messages, 1)
	end
	
	local tick = getTickCount()+DISPLAY_TIME
	dxTable = {text, r, g, b, tick}
	table.insert(messages, dxTable)
	
	if (#messages == 1) then
		addEventHandler("onClientRender", root, renderNotification)
	end
	outputConsole(text)
	return true
end
addEvent("UGCnoty.sendNotification", true)
addEventHandler("UGCnoty.sendNotification", root, sendNotification)


function renderNotification()
	if (not isPlayerHudComponentVisible("radar") or isPlayerMapVisible()) then return end
	if (#messages == 0) then
		removeEventHandler("onClientRender", root, renderNotification)
	end
	
	local toRemove = 0
	for i,v in ipairs(messages) do
		if (v[5] > getTickCount()) then
			dxDrawRectangle(aX, aY-( (i-1) *20), aW-aX, aH-aY, tocolor(0, 0, 0, 200))
			dxDrawText(v[1], aX, aY-( (i-1) *20), aW, aH-( (i-1) *20), tocolor(v[2], v[3], v[4], 255), 1, font, "center", "center", false, false, false, true)
		else
			toRemove = toRemove + 1
		end
	end
	if (toRemove > 0) then
		for i=1,toRemove do
			table.remove(messages, 1)
		end
	end
	local i = #messages - 1
end