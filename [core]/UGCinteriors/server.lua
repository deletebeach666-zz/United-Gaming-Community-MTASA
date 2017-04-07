local ints = {}
local intsInside = {}

local interiors = {
	
	{x = 1457.0247802734, y = -1010.9696655273, z = 27.44375, tox = 1465.1256103516, toy = -998.52716064453, toz = -56.2671875, torot=90, int=0, dim=0},
}


for k,v in ipairs (interiors) do

	intMarker = createMarker(v.x, v.y, v.z, "arrow", 1 ,255,255,0,255)
	intInsideMarker = createMarker(v.tox, v.toy, v.toz, "arrow", 1 ,255,255,0,255)
	setElementInterior(intMarker, v.int)
	setElementDimension(intMarker, v.dim)
	ints[intMarker] = k
	intsInside[intInsideMarker] = k

end 


function onInteriorMarkerHit (hElem, mDim)

	if not (mDim) then return false end
		if (getElementType(hElem) ~= "player") then return false end
			if (ints[source]) then
				if not (getElementData(hElem, "recentlyTeleported")) then
					local x = interiors[ints[source]].tox
					local y = interiors[ints[source]].toy
					local z = interiors[ints[source]].toz
					local int = interiors[ints[source]].int or 0
					local dim = interiors[ints[source]].dim or 0
					local rot = interiors[ints[source]].torot
					setElementData(hElem,"recentlyTeleported", true)
					setTimer(function()
						setElementInterior(hElem, int)
						setElementDimension(hElem, dim)
						setElementPosition(hElem, x, y, z, true)
						setElementData(hElem,"recentlyTeleported", false)
						setElementRotation(hElem, 0, 0, rot)
					end, 1000, 1)
				end	
			elseif (intsInside[source]) then
				if not (getElementData(hElem, "recentlyTeleported")) then	
					local x = interiors[intsInside[source]].x
					local y = interiors[intsInside[source]].y
					local z = interiors[intsInside[source]].z
					setElementData(hElem,"recentlyTeleported", true)
					setTimer(function()
						setElementInterior(hElem, int or 0)
						setElementDimension(hElem, dim or 0)
						setElementPosition(hElem, x, y, z, true)
						setElementData(hElem,"recentlyTeleported", false)
					end, 1000, 1)
				end	
			end	
end
addEventHandler("onMarkerHit", root, onInteriorMarkerHit)			
