	--[[ 
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 27 March 2017
-- Script: UGCdx/progress.lua
-- Type: Client Sided
]]--


local progressBars = {}
local sx, sy = guiGetScreenSize()
local x = 0
local start = {}

function drawProgressBar(progress_id, progress_time, progress_r, progress_g, progress_b, progress_reverse)
	progress_reverse = progress_reverse or false
	progress_id = progress_id or "null"
	progress_time = progress_time or 5000
	local tr, tg, tb = getTeamColor(getPlayerTeam(localPlayer))
	progress_r, progress_g, progress_b = progress_r or tr, progress_g or tg, progress_b or tb
	progressBars[x] = {id = progress_id, time = progress_time, no = x, color = {progress_r, progress_g, progress_b}, tp = progress_reverse}
	start[x] = getTickCount()
	x = x + 1
	return x - 1
end
addEvent("UGCdx:drawProgressBar", true)
addEventHandler("UGCdx:drawProgressBar", resourceRoot, drawProgressBar)

addEventHandler("onClientRender", root, function()
	   	for k, v in pairs(progressBars) do
	   		if #progressBars >= 0 then
	   			local now = {}
	   			local seconds = {}
	   			local color = {}
	   			local with = {}
	   			local text = {}
	   			local colorTable = {}
	   			colorTable[k] = {255, 255, 255}
	   			now[k] = getTickCount()
			    seconds[k] = v.time
				color[k] = v.color or tocolor(0,0,0,170)
				if v.tp == true then
					with[k] = interpolateBetween(183,0,0,0,0,0, (now[k] - start[k]) / ((start[k] + seconds[k]) - start[k]), "Linear")
			    	text[k] = interpolateBetween(100,0,0,0,0,0,(now[k] - start[k]) / ((start[k] + seconds[k]) - start[k]),"Linear")
				else
					with[k] = interpolateBetween(0,0,0,183,0,0, (now[k] - start[k]) / ((start[k] + seconds[k]) - start[k]), "Linear")
			    	text[k] = interpolateBetween(0,0,0,100,0,0,(now[k] - start[k]) / ((start[k] + seconds[k]) - start[k]),"Linear")
				end
			    if (v.color[1] > 200 and v.color[2] > 200 and v.color[3] > 200) then colorTable[k] = {0, 0, 0} end
	   			dxDrawRectangle(1162, 600 - k * 40, 194, 36, tocolor(0, 0, 0, 138), false)
		   		dxDrawRectangle(1167, 606 - k * 40, with[k], 24, tocolor(v.color[1], v.color[2], v.color[3], 255), false)
		   		dxDrawText( v.id .. ": " .. math.floor(text[k], 2) .."%", 1167+1, 705 - k * 80+1 - 200, 1350, 730, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	      	 	dxDrawText( v.id .. ": " .. math.floor(text[k], 2) .."%", 1167, 705 - k * 80 - 200, 1350, 730, tocolor(colorTable[k][1], colorTable[k][2], colorTable[k][3], 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	    		if now[k] > start[k] + v.time then
	    			progressBars[k] = nil
	    			x = x - 1
				end
	   		end
	   	end
end)

function destroyProgressBar(id)
	if progressBars[id] == nil then return false end
	progressBars[id] = nil
	x = x - 1
end