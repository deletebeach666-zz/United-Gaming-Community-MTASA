local sm = {}
sm.moov = 0
sm.object1,sm.object2 = nil,nil
 
local function removeCamHandler()
	if(sm.moov == 1)then
		sm.moov = 0
	end
end
 
local function camRender()
	if (sm.moov == 1) then
		local x1,y1,z1 = getElementPosition(sm.object1)
		local x2,y2,z2 = getElementPosition(sm.object2)
		setCameraMatrix(x1,y1,z1,x2,y2,z2)
	end
end
addEventHandler("onClientPreRender",root,camRender)
 
function smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,time)
	if(sm.moov == 1)then return false end
	sm.object1 = createObject(1337,x1,y1,z1)
	sm.object2 = createObject(1337,x1t,y1t,z1t)
	setElementAlpha(sm.object1,0)
	setElementAlpha(sm.object2,0)
	setObjectScale(sm.object1,0.01)
	setObjectScale(sm.object2,0.01)
	moveObject(sm.object1,time,x2,y2,z2,0,0,0,"InOutQuad")
	moveObject(sm.object2,time,x2t,y2t,z2t,0,0,0,"InOutQuad")
	sm.moov = 1
	setTimer(removeCamHandler,time,1)
	setTimer(destroyElement,time,1,sm.object1)
	setTimer(destroyElement,time,1,sm.object2)
	return true
end



destinations = {
	{"LS - Train Station", 1746.989, -1943.890, 12.568},
	{"LS - Airport", 1685.824, -2238.526, 12.547},
	{"LS - Docks", 2440.779, -2437.625, 12.621},
	{"LS - Ganton", 2273.818, -1669.269, 14.342},
	{"LS - Pig Pen", 2435.896, -1247.588, 22.893},
	{"LS - Jefferson", 2335.129, -1144.176, 25.993},
	{"LS - East Prison Release", 2749.955, -1423.4, 30.649},
	{"LS - West Prison Release", 408.801, -1566.401, 26.576},
	{"LS - Skate Park", 1948.622, -1451.891, 12.547},
	{"LS - Bank and Vehicle Recovery", 1515.874, -1024.371, 22.82},
	{"LS - All Saints Hospital", 1183.712, -1348.314, 13.185},
	{"LS - Graveyard", 953.74, -1119.075, 22.829},
	{"LS - Santa Maria Beach", 524.966, -1738.658, 11.025},
	{"LS - Court House", 1508.187, -1746.456, 12.547},
	
	{"RC - Dillimore", 691.693, -649.351, 15.332},
	{"RC - Blueberry", 171.198, -132.268, 0.578},
	{"RC - Montgomery", 1297.23, 312.536, 18.555},
	{"RC - Palamino Creek", 2235.049, 32.134, 25.484},
	
	{"FC - Farm", -1071.262, -1340.191, 128.695},
	{"WS - Angel Pine", -2173.921, -2285.746, 29.625},
	
	{"SF - Train Station", -1973.238, 117.546,  26.687},
	{"SF - Airport", -1421.593, -287.498, 13.148},
	{"SF - Hospital", -2690.539, 574.532, 13.758},
	{"SF - Battery Point", -2600.743, 1348.53, 6.188},
	{"SF - Garcia", -2269.558, -140.308, 34.32},
	
	{"TR - El Quebrados", -1504.573, 2582.22, 54.836},
	{"TR - Sherman Dam", -893.534, 1992.152, 59.695},
	{"TR - Bayside Marina", -2280.573, 2345.299, 3.976},
	
	{"BC - Verdant Meadows Air Strip", 422.820, 2539.364, 15.524},
	{"BC - Hunter Quarry", 810.255, 856.354, 10.062},
	{"BC - Fort Carson", -255.575, 1108.153, 18.742},
	
	{"LV - Hospital", 1631.35, 1850.89, 9.82},
	{"LV - Airport", 1311.952, 1262.574, 9.82},

}

local info = {}
function getInformation( )
	local info = {}
	for _, dest in ipairs( destinations ) do 
		local px, py, pz = getElementPosition( localPlayer )
		local dist = getDistanceBetweenPoints3D( px, py, pz, dest[2], dest[3], dest[4] )
		if ( dist ) then 
			cost = math.floor( dist / 0.6 )
		end 
		table.insert(info, {dest[1], cost} )
	end 
	return info
end

function getMarkerName()
	for _, n in ipairs( destinations ) do 
		local x, y, z = getElementPosition( localPlayer )
		if ( getDistanceBetweenPoints3D( x, y, z, n[2], n[3], n[4] ) < 4 ) then 
			mName = n[1]
		end 
	end
	return mName
end

function getCost( destinationName ) 
	for _, dest in ipairs( destinations ) do 
		if ( dest[1] == destinationName ) then 
			local px, py, pz = getElementPosition( localPlayer )
			local dist = getDistanceBetweenPoints3D( px, py, pz, dest[2], dest[3], dest[4] )
			if ( dist ) then 
				cost = math.floor( dist / 0.6 )
			end 	
		end 
	end 
	return cost 
end 		

function getTable()
	return destinations
end
addEvent("UGCTT.getTable", true)
addEventHandler("UGCTT.getTable", root, getTable )