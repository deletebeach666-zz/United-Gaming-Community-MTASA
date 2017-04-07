local isAvailable = false
local isBeingRobbed = false
local cops = {}
local crims = {}
local reward = 0
local objects = {}
local worth = math.random(20000,50000)

local crimsEntry = createMarker(2196.6708984375, 1676.3125, 13.3671875, "arrow", 2,255,0,0,255)
local copsEntry = createMarker(2196.6708984375, 1677.7890625, 13.3671875, "arrow", 2,0,0,255,255)
local exit = createMarker(2233.85546875, 1713.9599609375, 1013.2985229492, "arrow", 2, 255,255,0,255)
	setElementInterior(exit, 1)
local robberyMarker = createMarker(2234.3798828125, 1676.5263671875, 1007.359375, "cylinder", 6,255,0,0,150)
	setElementInterior(robberyMarker, 1)

	function isInCopTable(p)
	for k, v in ipairs(cops) do
		if (v == p) then
			return true
		else
			return false
		end
	end
end

function isInCrimTable(p)
	for k, v in ipairs(crims) do
		if (v == p) then
			return true
		else
			return false
		end
	end
end
	
setTimer ( function ()
		isAvailable = true
		outputChatBox("Caligula's Casino is now able to be robbed !",root,255,255,0)
	end, 1000*5,1
)
	
function isCrim (p)
	for k,v in ipairs (crims) do
		if (v == p) then
			return true
		else
			return false
		end
	end
end

function isCop (p)
	for k,v in ipairs (cops) do
		if (v == p) then
			return true
		else
			return false
		end
	end
end	


function crimEntry (hE, dim)

	if (dim) and (getElementType(hE) == "player") and (source == crimsEntry) then
		if (isAvailable) then
			if (getTeamName(getPlayerTeam(hE)) == "Criminals") then
				setElementInterior(hE,1)		
				setElementPosition(hE, 2234.0634765625, 1711.6787109375, 1011.5923461914)
			else
				outputChatBox("Only Criminals can pass through this door !",hE,255,0,0)
			end	
		else
			outputChatBox("There is no Casino Robbery right now or there is one already occuring !",hE,255,0,0)
		end
	end
end	
addEventHandler("onMarkerHit", root, crimEntry)


function copEntry (hE, dim)

	if (dim) and (getElementType(hE) == "player") and (source == copsEntry) then
			if (getTeamName(getPlayerTeam(hE)) == "Emergency") and (getElementData(hE, "Occupation") == "Police Officer") then
				setElementInterior(hE,1)		
				setElementPosition(hE, 2205.9697265625, 1584.9169921875, 999.9765625)
				table.insert (cops, hE)
			else
				outputChatBox("Only Cops can pass through this door !", hE,255,0,0)
			end	
	end
end	
addEventHandler("onMarkerHit", root, copEntry)


function crimMarker (p, dim)

	if (dim) and (getElementType(p) == "player") and (source == robberyMarker) then
		if (isAvailable) then
			if (getTeamName(getPlayerTeam(p)) == "Criminals") then
				table.insert(crims, p)
				local num = #crims
				outputChatBox(""..num.." are in marker ("..2-num.." more criminals are needed.)",root,255,0,0)
					if (#crims >= 2) then
						setElementFrozen (p, true)
						outputChatBox("Robbery starting in 10 seconds !",p,255,255,0)
						setTimer(startCasinoRoberry, 10*1000,1)
						setTimer(function (p) setElementFrozen(p, false) end,10*1000,1,p)
						createMarkers ()
					end	
			end
		end
	end
end
addEventHandler	("onMarkerHit", root, crimMarker)


function crimMakrerLeave (p, dim)

	if (p) and (dim) then
		if (source == robberyMarker) and (getTeamName(getPlayerTeam(p)) == "Criminals") then
			for k,v in ipairs (crims) do
				if (v == p) then
					table.remove(crims, k)
					break
				end
			end
		end
	end
end
addEventHandler("onMarkerLeave", root,crimMakrerLeave)	

function createMarkers()
	if not (marker) and not (marker1) and not (marker2) and not (marker3) and not (marker4) and not (marker5) and not (marker6) and not (marker7) and not (marker8) and not (marker9) then
		marker = createMarker(2241.322265625, 1616.1064453125, 1005.1805419922, "cylinder",1.5,0,150,0,255)
		marker1 = createMarker(2241.447265625, 1604.3330078125, 1005.1796875, "cylinder",1.5,0,150,0,255)
		marker2 = createMarker(2255.0009765625, 1608.21484375, 1005.1860351562, "cylinder",1.5,0,150,0,255)
		marker3 = createMarker(2230.48046875, 1613.4462890625, 1005.1860351562, "cylinder",1.5,0,150,0,255)
		marker4 = createMarker(2230.265625, 1604.27734375, 1005.1860351562, "cylinder",1.5,0,150,0,255)
		marker5 = createMarker(2218.2646484375, 1603.9375, 1005.1796875, "cylinder",1.5,0,150,0,255)
		marker6 = createMarker(2242.0263671875, 1593.666015625, 1005.1839599609, "cylinder",1.5,0,150,0,255)
		marker7 = createMarker(2252.4267578125, 1596.58203125, 1005.1796875, "cylinder",1.5,0,150,0,255)
		marker8 = createMarker(2267.91015625, 1596.6474609375, 1005.1796875, "cylinder",1.5,0,150,0,255) 
		marker9 = createMarker(2255.2783203125, 1618.7880859375, 1005.1796875, "cylinder",1.5,0,150,0,255)
		setElementInterior(marker, 1)
		setElementInterior(marker1, 1)
		setElementInterior(marker2, 1)
		setElementInterior(marker3, 1)
		setElementInterior(marker4, 1)
		setElementInterior(marker5, 1)
		setElementInterior(marker6, 1)
		setElementInterior(marker7, 1)
		setElementInterior(marker8, 1)
		setElementInterior(marker9, 1)
		blip = createBlipAttachedTo(marker, 0)
		blip1 = createBlipAttachedTo(marker1, 0)
		blip2 = createBlipAttachedTo(marker2, 0)
		blip3 = createBlipAttachedTo(marker3, 0)
		blip4 = createBlipAttachedTo(marker4, 0)
		blip5 = createBlipAttachedTo(marker5, 0)
		blip6 = createBlipAttachedTo(marker6, 0)
		blip7 = createBlipAttachedTo(marker7, 0)
		blip8 = createBlipAttachedTo(marker8, 0)
		blip9 = createBlipAttachedTo(marker9, 0)
	end	
end	

function startCasinoRoberry()
		destroyElement(robberyMarker)
	for k,v in ipairs (crims) do
		setPlayerWantedLevel (v, 6)
		isAvailable = false
		isBeingRobbed = true
		outputChatBox("Robbery started !",v,255,255,0)
		triggerClientEvent(v,"CR:update",v, reward)
	end
end	


function robMarker (c, dim)

	if (getTeamName(getPlayerTeam(c)) == "Criminals") and (dim) then
		if (source == marker) then
			reward = reward+worth
			setElementFrozen(c,true)
			setPedAnimation(c, "ROB_BANK", "cat_safe_rob", 1000*3)
			setTimer(setElementFrozen, 1000*3,1,c, false)
			setTimer(setPedAnimation, 1000*3,1,c, false)
			destroyElement(blip)
			destroyElement(marker)
			if not (objects[c]) then
				local x,y,z = getElementPosition(c)
				objects[c] = createObject(1550, x,y,z)
				setElementInterior(objects[c], 1)
				exports.bone_attach:attachElementToBone(objects[c],c,3,0,-0.3,0,0,0,0)
			end	
			for k,v in ipairs (crims) do
				triggerClientEvent(v,"CR:update",v, reward)
				if not (isElement(marker)) and not (isElement(marker1)) and not (isElement(marker2)) and not (isElement(marker3)) and not (isElement(marker4)) and not (isElement(marker5)) and not (isElement(marker6)) and not (isElement(marker7)) and not (isElement(marker8)) and not (isElement(marker9)) then
					outputChatBox("Safety is cracked exit the building before cops chase you !",v,255,255,0) 
					crackSafety()
				end	
			end
		end
	end
end
addEventHandler("onMarkerHit", root, robMarker)	


function robMarker1 (c, dim)

	if (getTeamName(getPlayerTeam(c)) == "Criminals") and (dim) then
		if (source == marker1) then
			reward = reward+worth
			setElementFrozen(c,true)
			setPedAnimation(c, "ROB_BANK", "cat_safe_rob", 1000*3)
			setTimer(setElementFrozen, 1000*3,1,c, false)
			setTimer(setPedAnimation, 1000*3,1,c, false)
			if not (objects[c]) then
				local x,y,z = getElementPosition(c)
				objects[c] = createObject(1550, x,y,z)
				setElementInterior(objects[c], 1)
				exports.bone_attach:attachElementToBone(objects[c],c,3,0,-0.3,0,0,0,0)
			end	
			for k,v in ipairs (crims) do
				triggerClientEvent(v,"CR:update",v, reward)
				destroyElement(blip1)
				destroyElement(marker1)
				if not (isElement(marker)) and not (isElement(marker1)) and not (isElement(marker2)) and not (isElement(marker3)) and not (isElement(marker4)) and not (isElement(marker5)) and not (isElement(marker6)) and not (isElement(marker7)) and not (isElement(marker8)) and not (isElement(marker9)) then
					outputChatBox("Safety is cracked exit the building before cops chase you !",v,255,255,0) 
					crackSafety()
				end	
			end
		end
	end
end
addEventHandler("onMarkerHit", root, robMarker1)	

function robMarker2 (c, dim)

	if (getTeamName(getPlayerTeam(c)) == "Criminals") and (dim) then
		if (source == marker2) then
			reward = reward+worth
			setElementFrozen(c,true)
			setPedAnimation(c, "ROB_BANK", "cat_safe_rob", 1000*3)
			setTimer(setElementFrozen, 1000*3,1,c, false)
			setTimer(setPedAnimation, 1000*3,1,c, false)
			if not (objects[c]) then
				local x,y,z = getElementPosition(c)
				objects[c] = createObject(1550, x,y,z)
				setElementInterior(objects[c], 1)
				exports.bone_attach:attachElementToBone(objects[c],c,3,0,-0.3,0,0,0,0)
			end	
			for k,v in ipairs (crims) do
				triggerClientEvent(v,"CR:update",v, reward)
				destroyElement(blip2)
				destroyElement(marker2)
				if not (isElement(marker)) and not (isElement(marker1)) and not (isElement(marker2)) and not (isElement(marker3)) and not (isElement(marker4)) and not (isElement(marker5)) and not (isElement(marker6)) and not (isElement(marker7)) and not (isElement(marker8)) and not (isElement(marker9)) then
					outputChatBox("Safety is cracked exit the building before cops chase you !",v,255,255,0) 
					crackSafety()
				end	
			end
		end
	end
end
addEventHandler("onMarkerHit", root, robMarker2)	

function robMarker3 (c, dim)

	if (getTeamName(getPlayerTeam(c)) == "Criminals") and (dim) then
		if (source == marker3) then
			reward = reward+worth
			setElementFrozen(c,true)
			setPedAnimation(c, "ROB_BANK", "cat_safe_rob", 1000*3)
			setTimer(setElementFrozen, 1000*3,1,c, false)
			setTimer(setPedAnimation, 1000*3,1,c, false)
			if not (objects[c]) then
				local x,y,z = getElementPosition(c)
				objects[c] = createObject(1550, x,y,z)
				setElementInterior(objects[c], 1)
				exports.bone_attach:attachElementToBone(objects[c],c,3,0,-0.3,0,0,0,0)
			end	
			for k,v in ipairs (crims) do
				triggerClientEvent(v,"CR:update",v, reward)
				destroyElement(blip3)
				destroyElement(marker3)
				if not (isElement(marker)) and not (isElement(marker1)) and not (isElement(marker2)) and not (isElement(marker3)) and not (isElement(marker4)) and not (isElement(marker5)) and not (isElement(marker6)) and not (isElement(marker7)) and not (isElement(marker8)) and not (isElement(marker9)) then
					outputChatBox("Safety is cracked exit the building before cops chase you !",v,255,255,0) 
					crackSafety()
				end	
			end
		end
	end
end
addEventHandler("onMarkerHit", root, robMarker3)	

function robMarker4 (c, dim)

	if (getTeamName(getPlayerTeam(c)) == "Criminals") and (dim) then
		if (source == marker4) then
			reward = reward+worth
			setElementFrozen(c,true)
			setPedAnimation(c, "ROB_BANK", "cat_safe_rob", 1000*3)
			setTimer(setElementFrozen, 1000*3,1,c, false)
			setTimer(setPedAnimation, 1000*3,1,c, false)
			if not (objects[c]) then
				local x,y,z = getElementPosition(c)
				objects[c] = createObject(1550, x,y,z)
				setElementInterior(objects[c], 1)
				exports.bone_attach:attachElementToBone(objects[c],c,3,0,-0.3,0,0,0,0)
			end	
			for k,v in ipairs (crims) do
				triggerClientEvent(v,"CR:update",v, reward)
				destroyElement(blip4)
				destroyElement(marker4)
				if not (isElement(marker)) and not (isElement(marker1)) and not (isElement(marker2)) and not (isElement(marker3)) and not (isElement(marker4)) and not (isElement(marker5)) and not (isElement(marker6)) and not (isElement(marker7)) and not (isElement(marker8)) and not (isElement(marker9)) then
					outputChatBox("Safety is cracked exit the building before cops chase you !",v,255,255,0) 
					crackSafety()
				end	
			end
		end
	end
end
addEventHandler("onMarkerHit", root, robMarker4)	

function robMarker5 (c, dim)

	if (getTeamName(getPlayerTeam(c)) == "Criminals") and (dim) then
		if (source == marker5) then
			reward = reward+worth
			setElementFrozen(c,true)
			setPedAnimation(c, "ROB_BANK", "cat_safe_rob", 1000*3)
			setTimer(setElementFrozen, 1000*3,1,c, false)
			setTimer(setPedAnimation, 1000*3,1,c, false)
			if not (objects[c]) then
				local x,y,z = getElementPosition(c)
				objects[c] = createObject(1550, x,y,z)
				setElementInterior(objects[c], 1)
				exports.bone_attach:attachElementToBone(objects[c],c,3,0,-0.3,0,0,0,0)
			end	
			for k,v in ipairs (crims) do
				triggerClientEvent(v,"CR:update",v, reward)
				destroyElement(blip5)
				destroyElement(marker5)
				if not (isElement(marker)) and not (isElement(marker1)) and not (isElement(marker2)) and not (isElement(marker3)) and not (isElement(marker4)) and not (isElement(marker5)) and not (isElement(marker6)) and not (isElement(marker7)) and not (isElement(marker8)) and not (isElement(marker9)) then
					outputChatBox("Safety is cracked exit the building before cops chase you !",v,255,255,0) 
					crackSafety()
				end		
			end
		end
	end
end
addEventHandler("onMarkerHit", root, robMarker5)	

function robMarker6 (c, dim)

	if (getTeamName(getPlayerTeam(c)) == "Criminals") and (dim) then
		if (source == marker6) then
			reward = reward+worth
			setElementFrozen(c,true)
			setPedAnimation(c, "ROB_BANK", "cat_safe_rob", 1000*3)
			setTimer(setElementFrozen, 1000*3,1,c, false)
			setTimer(setPedAnimation, 1000*3,1,c, false)
			if not (objects[c]) then
				local x,y,z = getElementPosition(c)
				objects[c] = createObject(1550, x,y,z)
				setElementInterior(objects[c], 1)
				exports.bone_attach:attachElementToBone(objects[c],c,3,0,-0.3,0,0,0,0)
			end	
			for k,v in ipairs (crims) do
				triggerClientEvent(v,"CR:update",v, reward)
				destroyElement(blip6)
				destroyElement(marker6)
				if not (isElement(marker)) and not (isElement(marker1)) and not (isElement(marker2)) and not (isElement(marker3)) and not (isElement(marker4)) and not (isElement(marker5)) and not (isElement(marker6)) and not (isElement(marker7)) and not (isElement(marker8)) and not (isElement(marker9)) then
					outputChatBox("Safety is cracked exit the building before cops chase you !",v,255,255,0) 
					crackSafety()
				end	
			end
		end
	end
end
addEventHandler("onMarkerHit", root, robMarker6)	

function robMarker7 (c, dim)

	if (getTeamName(getPlayerTeam(c)) == "Criminals") and (dim) then
		if (source == marker7) then
			reward = reward+worth
			setElementFrozen(c,true)
			setPedAnimation(c, "ROB_BANK", "cat_safe_rob", 1000*3)
			setTimer(setElementFrozen, 1000*3,1,c, false)
			setTimer(setPedAnimation, 1000*3,1,c, false)
			if not (objects[c]) then
				local x,y,z = getElementPosition(c)
				objects[c] = createObject(1550, x,y,z)
				setElementInterior(objects[c], 1)
				exports.bone_attach:attachElementToBone(objects[c],c,3,0,-0.3,0,0,0,0)
			end	
			for k,v in ipairs (crims) do
				triggerClientEvent(v,"CR:update",v, reward)
				destroyElement(blip7)
				destroyElement(marker7)
				if not (isElement(marker)) and not (isElement(marker1)) and not (isElement(marker2)) and not (isElement(marker3)) and not (isElement(marker4)) and not (isElement(marker5)) and not (isElement(marker6)) and not (isElement(marker7)) and not (isElement(marker8)) and not (isElement(marker9)) then
					outputChatBox("Safety is cracked exit the building before cops chase you !",v,255,255,0) 
					crackSafety()
				end	
			end	
		end
	end
end
addEventHandler("onMarkerHit", root, robMarker7)	

function robMarker8 (c, dim)

	if (getTeamName(getPlayerTeam(c)) == "Criminals") and (dim) then
		if (source == marker8) then
			reward = reward+worth
			setElementFrozen(c,true)
			setPedAnimation(c, "ROB_BANK", "cat_safe_rob", 1000*3)
			setTimer(setElementFrozen, 1000*3,1,c, false)
			setTimer(setPedAnimation, 1000*3,1,c, false)
			if not (objects[c]) then
				local x,y,z = getElementPosition(c)
				objects[c] = createObject(1550, x,y,z)
				setElementInterior(objects[c], 1)
				exports.bone_attach:attachElementToBone(objects[c],c,3,0,-0.3,0,0,0,0)
			end	
			for k,v in ipairs (crims) do
				triggerClientEvent(v,"CR:update",v, reward)
				destroyElement(blip8)
				destroyElement(marker8)
				if not (isElement(marker)) and not (isElement(marker1)) and not (isElement(marker2)) and not (isElement(marker3)) and not (isElement(marker4)) and not (isElement(marker5)) and not (isElement(marker6)) and not (isElement(marker7)) and not (isElement(marker8)) and not (isElement(marker9)) then
					outputChatBox("Safety is cracked exit the building before cops chase you !",v,255,255,0) 
					crackSafety()
				end	
			end	
		end
	end
end
addEventHandler("onMarkerHit", root, robMarker8)	

function robMarker9 (c, dim)

	if (getTeamName(getPlayerTeam(c)) == "Criminals") and (dim) then
		if (source == marker9) then
			reward = reward+worth
			setElementFrozen(c,true)
			setPedAnimation(c, "ROB_BANK", "cat_safe_rob", 1000*3)
			setTimer(setElementFrozen, 1000*3,1,c, false)
			setTimer(setPedAnimation, 1000*3,1,c, false)
			if not (objects[c]) then
				local x,y,z = getElementPosition(c)
				objects[c] = createObject(1550, x,y,z)
				setElementInterior(objects[c], 1)
				exports.bone_attach:attachElementToBone(objects[c],c,3,0,-0.3,0,0,0,0)
			end	
			for k,v in ipairs (crims) do
				triggerClientEvent(v,"CR:update",v, reward)
				destroyElement(blip9)
				destroyElement(marker9)
				if not (isElement(marker)) and not (isElement(marker1)) and not (isElement(marker2)) and not (isElement(marker3)) and not (isElement(marker4)) and not (isElement(marker5)) and not (isElement(marker6)) and not (isElement(marker7)) and not (isElement(marker8)) and not (isElement(marker9)) then
					outputChatBox("Safety is cracked exit the building before cops chase you !",v,255,255,0) crackSafety()
				end	
			end
		end
	end
end
addEventHandler("onMarkerHit", root, robMarker9)	


function onCrimWasted(ammo, attacker, weapon, bodypart)
	if (isInCrimTable(source)) and (isInCopTable(attacker)) then
		outputChatBox("You have killed "..getPlayerName(source).." and got $5000.", attacker, 0, 255, 0)
		outputChatBox("You have been killed by "..getPlayerName(attacker)..".", source, 255, 0, 0)
		givePlayerMoney(attacker, 5000)
		
		for k, v in ipairs(crims) do
			if (objects[v]) then
				destroyElement(objects[v])
			end	
			if (v == source) then
				table.remove(crims, k)
			end
		end
		if (#crims == 0) then
			outputChatBox("The law forces have successfully defended the casino from its robbers.", root, 0 , 255, 0)
			endCR ()
		 end
	end
	if (isInCrimTable(attacker)) and (isInCopTable(source)) then
		outputChatBox("You have killed "..getPlayerName(source).." and got $5000.", attacker, 0, 255, 0)
		outputChatBox("You have been killed by "..getPlayerName(attacker)..".", source, 255, 0, 0)
		givePlayerMoney(attacker, 5000)
		for k, v in ipairs(cops) do
			if (v == source) then
				table.remove(cops, k)
			end
		end
	end
end
addEventHandler("onPlayerWasted", root, onCrimWasted)


function crackSafety (h, dim)
	if (getTeamName(getPlayerTeam(h)) == "Criminals") and (source == exit) then
		if (isBeingRobbed) then
			setElementInterior (h, 0)
			setElementPosition (h, 2194.6708984375, 1674.3125, 13.3671875)
			local num = #crims
			if (num > 0) then
				local gift = math.ceil(reward/num)
				outputChatBox("You have stolen $"..gift.."",h,255,255,0)
				triggerClientEvent(h,"CR:out",h)
				for k, v in ipairs(crims) do
					if (objects[v]) then
						destroyElement(objects[v])
					end	
					if (v == h) then
					table.remove(crims, k)
					end
				end
				givePlayerMoney(h, gift)
			else
				local gift = 50000
				outputChatBox("You have stolen $"..gift.."",h,255,255,0)
				triggerClientEvent(h,"CR:out",h)
				for k, v in ipairs(crims) do
					if (objects[v]) then
						destroyElement(objects[v])
					end	
					if (v == h) then
					table.remove(crims, k)
					end
				end
				givePlayerMoney(h, gift)
			end	
		else
			setElementInterior (h, 0)
			setElementPosition (h, 2194.6708984375, 1674.3125, 13.3671875)
		end
		resettime = setTimer (function () isAvailable = true end,30*60*1000,1)
	end
end	
addEventHandler("onMarkerHit", root, crackSafety)

function endCR ()

		for k,v in ipairs (cops) do
			setElementInterior (v, 0)
			setElementPosition (v, 2194.6708984375, 1674.3125, 13.3671875)
			outputChatBox("You have been rewarded $50,000 for defending the Casino !",v,255,255,0)
			givePlayerMoney(v, 50000)
			triggerClientEvent(h,"CR:out",h)
			for k, v in ipairs(crims) do
				if (objects[v]) then
					destroyElement(objects[v])
				end	
				if (v == v) then
					table.remove(crims, k)
				end
			end
		end
		destroyElement(blip)
		destroyElement(marker)
		destroyElement(blip1)
		destroyElement(marker1)
		destroyElement(blip2)
		destroyElement(marker2)
		destroyElement(blip3)
		destroyElement(marker3)
		destroyElement(blip4)
		destroyElement(marker4)
		destroyElement(blip5)
		destroyElement(marker5)
		destroyElement(blip5)
		destroyElement(marker5)
		destroyElement(blip6)
		destroyElement(marker6)
		destroyElement(blip7)
		destroyElement(marker7)
		destroyElement(blip8)
		destroyElement(marker8)
		destroyElement(blip9)
		destroyElement(marker9)
		resettime = setTimer (function () isAvailable = true end,30*60*1000,1)
	end	
	
	
function timerCheck (p, cmd)

		if (isTimer(resettime)) then
			local t,t1,t2 = getTimerDetails(resettime)
			local left = t/60
			outputChatBox(""..left.." Minutes left for the Casino Robbery ("..math.ceil(left*60).." seconds) !",p,255,255,0)
		else
			outputChatBox("Casino is ready to be robbed or is being robbed.",p,255,0,0)
		end
end	
addCommandHandler("cr", timerCheck)
addCommandHandler("casino", timerCheck)
			
		
		
		
			