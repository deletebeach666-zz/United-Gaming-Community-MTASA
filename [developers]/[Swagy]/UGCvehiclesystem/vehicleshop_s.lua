local vehicle = {}
local mark = {}

local db = exports.UGCdb:getConnection()

function createTableOnStart ()

	dbExec(db, "CREATE TABLE IF NOT EXISTS playerVehicles (owner TEXT, id INT, plate TEXT, x INT, y INT, z INT, rot INT, health INT, r INT, g INT, b INT, spawned TEXT)")

end
addEventHandler("onResourceStart", resourceRoot, createTableOnStart)	

function buyVehicle (p, id, x, y, z, r, g, b, price)

	if (id) then
		if (getPlayerMoney(p) >= price) then
			if not (r) and not (g) and not (b) then r, g, b = 255 , 255, 255 end
			if (vehicle[p]) then
				despawnVehicle(p, getVehicleModel(vehicle[p]))
				local plate = exports.UGCutils:generatePlate(p)
				takePlayerMoney(p, price)
				vehicle[p] = createVehicle(id, x,y,z)
				setVehiclePlateText(vehicle[p], plate)
				setElementData(p, "ownedVehicle", vehicle[p])
				setElementData(vehicle[p], "owner", p)
				setVehicleColor(vehicle[p], r,g,b)
				warpPedIntoVehicle(p, vehicle[p])
				dbExec(db,"INSERT INTO playerVehicles (owner, id, plate, x,y,z, rot, health, r,g,b, spawned) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)", getAccountName(getPlayerAccount(p)), id, plate, x,y,z, 0, 1000, r,g,b, "true")
			else
				local plate = exports.UGCutils:generatePlate(p)
				takePlayerMoney(p, price)
				vehicle[p] = createVehicle(id, x,y,z)
				setVehiclePlateText(vehicle[p], plate)
				setElementData(p, "ownedVehicle", vehicle[p])
				setElementData(vehicle[p], "owner", p)
				setVehicleColor(vehicle[p], r,g,b)
				warpPedIntoVehicle(p, vehicle[p])
				dbExec(db,"INSERT INTO playerVehicles (owner, id, plate, x,y,z, rot, health, r,g,b, spawned) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)", getAccountName(getPlayerAccount(p)), id, plate, x,y,z, 0, 1000, r,g,b, "true")
			end	
		else
			exports.UGCnoty:sendNotification("You don't have enough money!",p,255,0,0)	
		end	
	end
end
addEvent("vehicles:buyVehicle", true)
addEventHandler("vehicles:buyVehicle", root, buyVehicle)	

function onPlayerQuit ()

	local veh = getPedOccupiedVehicle(source)
	if not (veh) then return false end
	if not (vehicle[source]) then return false end
	if not (veh == vehicle[source]) then return false end
	despawnVehicle(source, getVehicleModel(vehicle[source]))
end
addEventHandler("onPlayerQuit", root, onPlayerQuit)

function openManagementWindow(p, cmd)

	local query = dbQuery (db, "SELECT * FROM playerVehicles WHERE owner=?", getAccountName(getPlayerAccount(p)))
	local table = dbPoll(query, -1)
	local veh = getElementData(p, "ownedVehicle") 
	triggerClientEvent(p, "management:openManagementWindow", p, table)	
end
addCommandHandler("myvehicles", openManagementWindow)


function spawnVehicle (p, id, x, y, z, r, g, b, rot, health, plate)
	if (vehicle[p]) then return exports.UGCnoty:sendNotification("You have already a spawned vehicle, despawn it first!",p,255,0,0) end
	vehicle[p] = createVehicle (id, x,y,z, 0,0,rot, plate)
	setVehicleColor(vehicle[p],r,g,b)
	setVehiclePlateText(vehicle[p],plate)
	local qh = dbQuery(db, "SELECT * FROM playerVehicles WHERE owner=? AND plate=?", getAccountName(getPlayerAccount(p)), plate)
	local result = dbPoll(qh, -1)
	local hp = result[1]["health"]
	setElementHealth(vehicle[p], hp)
	setElementData(p, "ownedVehicle", vehicle[p])
	setElementData(vehicle[p], "owner", p)
	local state = "true"
	dbExec(db, "UPDATE playerVehicles SET spawned=? WHERE owner=? AND plate=?", state, getAccountName(getPlayerAccount(p)), plate)
	if (health == "30%") then
		toggleControl (p, "accelerate", false)
		toggleControl (p, "brake", false)
	end
end
addEvent("vehicles:spawnVehicle", true)
addEventHandler("vehicles:spawnVehicle", root, spawnVehicle)

function despawnVehicle (p, id)

	if not (isElement(vehicle[p])) then return exports.UGCnoty:sendNotification("You don't have a spawned vehicle!",p,255,0,0) end
	if not (getVehicleModel(vehicle[p]) == tonumber(id)) then return exports.UGCnoty:sendNotification("This vehicle isn't spawned!",p,255,0,0) end
	local x,y,z = getElementPosition(vehicle[p])
	local rx,ry,rz = getElementRotation(p)
	local hp = getElementHealth(vehicle[p])
	local r,g,b = getVehicleColor(vehicle[p])
	local state = "false"
	dbExec(db, "UPDATE playerVehicles SET x=? WHERE plate=? AND owner=?", x, getVehiclePlateText(vehicle[p]), getAccountName(getPlayerAccount(p)))
	dbExec(db, "UPDATE playerVehicles SET y=? WHERE plate=? AND owner=?", y, getVehiclePlateText(vehicle[p]), getAccountName(getPlayerAccount(p)))
	dbExec(db, "UPDATE playerVehicles SET z=? WHERE plate=? AND owner=?", z, getVehiclePlateText(vehicle[p]), getAccountName(getPlayerAccount(p)))
	dbExec(db, "UPDATE playerVehicles SET rot=? WHERE plate=? AND owner=?", rx, getVehiclePlateText(vehicle[p]), getAccountName(getPlayerAccount(p)))
	dbExec(db, "UPDATE playerVehicles SET health=? WHERE plate=? AND owner=?", hp, getVehiclePlateText(vehicle[p]), getAccountName(getPlayerAccount(p)))
	dbExec(db, "UPDATE playerVehicles SET r=? WHERE plate=? AND owner=?", r, getVehiclePlateText(vehicle[p]), getAccountName(getPlayerAccount(p)))
	dbExec(db, "UPDATE playerVehicles SET g=? WHERE plate=? AND owner=?", g, getVehiclePlateText(vehicle[p]), getAccountName(getPlayerAccount(p)))
	dbExec(db, "UPDATE playerVehicles SET b=? WHERE plate=? AND owner=?", b, getVehiclePlateText(vehicle[p]), getAccountName(getPlayerAccount(p)))
	dbExec(db, "UPDATE playerVehicles SET spawned=? WHERE plate=? AND owner=?", state, getVehiclePlateText(vehicle[p]), getAccountName(getPlayerAccount(p)))
	if (mark[vehicle[p]]) then
		destroyElement(mark[vehicle[p]])
		mark[vehicle[p]] = nim
	end
	destroyElement(vehicle[p])
	vehicle[p] = nil
end
addEvent("vehicles:despawnVehicle", true)
addEventHandler("vehicles:despawnVehicle", root, despawnVehicle)


function recoverVehicle(p)

	if not (vehicle[p]) then return exports.UGCnoty:sendNotification("You don't have a spawned vehicle, spawn the vehicle first!",p,255,0,0) end
	local x,y,z = getElementPosition(p)
	if (exports.UGCchat:getPlayerZone(p) == "LS") then
		cx,cy,cz = 1702.4783935547, -1053.0415039063, 23.50625
		city = "Los Santos"
	elseif (exports.UGCchat:getPlayerZone(p) == "LV") then
		cx,cy,cz = 1749.8366699219, 1930.7976074219, 10.4203125
		city = "Las Venturas"
	elseif (exports.UGCchat:getPlayerZone(p) == "SF") then
		cx,cy,cz = -1985.2967529297, 246.29721069336, 34.771875
		city = "San Fierro"
	end
	setElementPosition(vehicle[p], cx, cy, cz)
	exports.UGCnoty:sendNotification("Your vehicle has been recovered to "..city.." recovery's point!",p,255,0,255)
end
addEvent("vehicles:recoverVehicle", true)
addEventHandler("vehicles:recoverVehicle", root, recoverVehicle)	

function markVehicle (p)

	if not (vehicle[p]) then return exports.UGCnoty:sendNotification("This vehicle isn't spawned, spawn it first!",p,255,0,0) end
	if (mark[vehicle[p]]) then return exports.UGCnoty:sendNotification("Your vehicle is already marked!",p,255,0,0) end
	mark[vehicle[p]] = createBlipAttachedTo(vehicle[p], 53)
end
addEvent("vehicles:markVehicle", true)
addEventHandler("vehicles:markVehicle", root, markVehicle)

function unmarkVehicle (p)

	if not (vehicle[p]) then return exports.UGCnoty:sendNotification("This vehicle isn't spawned, spawn it first!",p,255,0,0) end
	if not (mark[vehicle[p]]) then return exports.UGCnoty:sendNotification("This vehicle is already unmarked!",p,255,0,0) end
	destroyElement(mark[vehicle[p]])
	mark[vehicle[p]] = nil
end
addEvent("vehicles:unmarkVehicle", true)
addEventHandler("vehicles:unmarkVehicle", root, unmarkVehicle)

function spectateVehicle (p)
	if not (vehicle[p]) then return exports.UGCnoty:sendNotification("This vehicle isn't spawned, spawn it first!",p,255,0,0) end
		if (getElementData(p, "isSpectating") == false) then
			local x,y,z = getElementPosition(vehicle[p])
			setCameraMatrix(p, x,y,z+50, x,y,z)
			setElementData(p, "isSpectating", true)
		else
			setCameraTarget(p, p)
			setElementData(p, "isSpectating", false)
		end		
end
addEvent("vehicles:spectateVehicle", true)
addEventHandler("vehicles:spectateVehicle", root, spectateVehicle)

function isVehicleOwned (p, v)

	if (getElementType(v) ~= "vehicle") then return error("Expected vehicle at argument 2 got "..getElementType(v).."") end
	if (getElementData(p, "ownedVehicle") == v) then
		return true
	else
		return false
	end
end

function getVehicleOwner(v)

	if (getElementType(v) ~= "vehicle") then return error("Expected vehicle at argument 2 got "..getElementType(v).."") end
	if not (getElementData(v, "owner")) then 
		return false
	else
		return getElementData(v, "owner")
	end
end

function bindKeys ()

	bindKey(source, "F2", "down", openManagementWindow)

end	
addEventHandler("onPlayerLogin", root, bindKeys)

function bindKeysWhenStart ()

	for k,v in ipairs (getElementsByType"player") do
		bindKey(v, "F2", "down", openManagementWindow)
	end
end
addEventHandler("onResourceStart", resourceRoot, bindKeysWhenStart)		

	