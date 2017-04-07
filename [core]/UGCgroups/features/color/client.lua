--[[ 
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 21 March 2017
-- Script: UGCgroups/tabs/color/client.lua
-- Type: Client Sided
]]--

addEventHandler("onColorPickerOK", root, 
function(element, hex, r, g, b)
	if getElementData(localPlayer, "UGCgroups.editingRGB") then
		triggerServerEvent("UGCgroups.setGroupRGB", resourceRoot, r, g, b)
		setElementData(localPlayer, "UGCgroups.editingRGB", nil)
	end
end)
