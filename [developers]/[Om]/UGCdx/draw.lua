--[[ 
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 19 March 2017
-- Script: client.lua
-- Type: Client Sided
]]--

local timer = {}
local start = {}
local x = 0



-- Draw Text on Element
--------------------------->
function createTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font,checkBuildings,checkVehicles,checkPeds,checkDummies,seeThroughStuff,ignoreSomeObjectsForCamera,ignoredElement)
local x, y, z = getElementPosition(TheElement)
local x2, y2, z2 = getElementPosition(localPlayer)
local distance = distance or 20
local height = height or 1
local checkBuildings = checkBuildings or true
local checkVehicles = checkVehicles or false
local checkPeds = checkPeds or false
local checkObjects = checkObjects or true
local checkDummies = checkDummies or true
local seeThroughStuff = seeThroughStuff or false
local ignoreSomeObjectsForCamera = ignoreSomeObjectsForCamera or false
local ignoredElement = ignoredElement or nil
if (isLineOfSightClear(x, y, z, x2, y2, z2, checkBuildings, checkVehicles, checkPeds , checkObjects,checkDummies,seeThroughStuff,ignoreSomeObjectsForCamera,ignoredElement)) then
	local sx, sy = getScreenFromWorldPosition(x, y, z+height)
	if(sx) and (sy) then
		local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
		if(distanceBetweenPoints < distance) then
			dxDrawText(text, sx+4, sy+4, sx, sy, tocolor(0, 0, 0, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
			dxDrawText(text, sx+3, sy+3, sx, sy, tocolor(0, 0, 0, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
			dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
			end
		end
	end
end
