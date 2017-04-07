----------------------------------------------------------------------
--  Script Author: Swagy                                            --
--  Copyrights@Unitec Gaming Community 2017                         --
--  Description: Basic Housing System                               --
--  forum.curtcreation.net                                          --
----------------------------------------------------------------------


local db = exports.UGCdb:getConnection()

local housing = {}
local exits = {}

function createHousingTable()

	dbExec (db,"CREATE TABLE IF NOT EXISTS `housing` (id INT, x INT, y INT, z INT, hx INT, hy INT, hz INT, owner LONGTEXT, interior INT, dimension INT, sale INT, price INT, pass TEXT)")
end
addEventHandler("onResourceStart", resourceRoot, createHousingTable)

local houses = {
	[1] = {x = 2495.2138671875, y = -1690.84375, z = 14.765625, hx = 2496.0166015625, hy = -1692.884765625, hz = 1014.7421875, owner = "blid1", interior = 3, dimension = 0, sale = 0, price = 10000, pass = "N/A" }
}

--[[for k,v in ipairs (houses) do 
	dbExec(db, "INSERT INTO housing (id,x,y,z,hx,hy,hz,owner,interior, dimension, sale, price) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)", k, v.x, v.y, v.z, v.hx, v.hy, v.hz, "blid1", v.interior, v.dimension, v.sale, v.price, v.pass)
end]]

function createHouses ()
local query = dbQuery (db, "SELECT * FROM housing")
local result = dbPoll (query, -1)
iprint (result)

	for k,v in ipairs (result) do 
		if (tonumber(v["sale"]) == 0) then
			hPickup = createPickup(v["x"],v["y"],v["z"],3,1273)
		else
			hPickup = createPickup(v["x"],v["y"],v["z"],3,1272)	
		end
		exitPickup = createPickup(v["hx"], v["hy"], v["hz"], 3, 1318)
		setElementInterior(exitPickup, tonumber(v["interior"]))
		setElementDimension(exitPickup, tonumber(v["dimension"]))
		housing[hPickup] = k
		exits[exitPickup] = k
	end	
end
addEventHandler("onResourceStart", resourceRoot, createHouses)	


function onPickupHit (plr)
	if (housing[source]) then
		cancelEvent()
		setElementData(plr, "withinHouse", true)
		setAccountData(getPlayerAccount(plr), "houseHit", source)
		triggerClientEvent(plr,"housing:Popup",plr)
		setTimer (function (p) triggerClientEvent(p, "housing:Popout", p) setElementData(p, "withinHouse", false) end, 1500,1,plr)
	elseif (exits[source]) then
		cancelEvent()	
	end
end
addEventHandler("onPickupHit", root, onPickupHit)		


function showWindow (p)

	if (getElementData(p, "withinHouse")) then
		local pickup = getAccountData(getPlayerAccount(p), "houseHit")
		if (pickup) then
			local qh = dbQuery (db, "SELECT * FROM housing")
			local housingTable = dbPoll (qh, -1)
			setAccountData(getPlayerAccount(p), "houseHitX", housingTable[housing[pickup]].x)
			setAccountData(getPlayerAccount(p), "houseHitY", housingTable[housing[pickup]].y)
			setAccountData(getPlayerAccount(p), "houseHitZ", housingTable[housing[pickup]].z)
			local owner = housingTable[housing[pickup]].owner
			if (owner == getAccountName(getPlayerAccount(p))) then
				triggerClientEvent(p, "housing:openOwnerWindow", p, housingTable[housing[pickup]].owner, housingTable[housing[pickup]].sale, housingTable[housing[pickup]].price, housingTable[housing[pickup]].interior)
			else
				triggerClientEvent(p, "housing:openWindow", p, housingTable[housing[pickup]].owner, housingTable[housing[pickup]].sale, housingTable[housing[pickup]].price, housingTable[housing[pickup]].interior)
			end	
		end
	end
end
addCommandHandler("openhouse", showWindow)	


addEventHandler("onPlayerLogin", root, function ()
	for k,v in ipairs (getElementsByType"player") do
		bindKey(v,"H", "down", function() executeCommandHandler("openhouse", v) end)
	end		
end
)	

addEventHandler("onResourceStart", resourceRoot, function ()
	for k,v in ipairs (getElementsByType"player") do
		bindKey(v,"H", "down", function() executeCommandHandler("openhouse", v) end)
	end		
end
)	


function checkServerAccess (p)

	local qh = dbQuery (db, "SELECT * FROM housing")
	local housingTable = dbPoll (qh, -1)
	local pickup = getAccountData(getPlayerAccount(p), "houseHit")
	local password = housingTable[housing[pickup]].pass
	local hx = housingTable[housing[pickup]].hx
	local hy = housingTable[housing[pickup]].hy
	local hz = housingTable[housing[pickup]].hz
	local interior = housingTable[housing[pickup]].interior
	triggerClientEvent(p,"housing:checkAccess", p, password, hx, hy, hz, interior )

end
addEvent("checkServerAccess", true)
addEventHandler("checkServerAccess", root, checkServerAccess)


function enterHouse (p, x, y, z, interior)

	setElementPosition(p, x,y,z)
	setAccountData(getPlayerAccount(p), "insideHouse", true)
	setElementInterior(p, tonumber(interior))

end		
addEvent("housing:enterHouse", true)
addEventHandler("housing:enterHouse", root, enterHouse)


function exitHouseOnHit (p)

	if (source == exitPickup) then
		local x = tonumber(getAccountData(getPlayerAccount(p), "houseHitX"))
		local y = tonumber(getAccountData(getPlayerAccount(p), "houseHitY"))
		local z = tonumber(getAccountData(getPlayerAccount(p), "houseHitZ"))
		setElementInterior(p, 0)
		setElementDimension(p,0)
		setElementPosition(p, x,y,z)
	end
end
addEventHandler("onPickupHit", root, exitHouseOnHit)


function setNewPassword (p, newPass)

	if (tonumber(newPass)) then
		local qh = dbQuery (db, "SELECT * FROM housing")
		local housingTable = dbPoll (qh, -1)
		local pickup = getAccountData(getPlayerAccount(p), "houseHit")
		local houseID = housingTable[housing[pickup]].id
		dbExec(db, "UPDATE housing SET pass=? WHERE id=?", newPass, houseID)
		outputChatBox("You have changed your house password !",p,255,255,0)	
	else
		outputChatBox("Your password should be a number !",p,255,0,0)
	end
end
addEvent("housing:changePassword", true)
addEventHandler("housing:changePassword", root, setNewPassword)	



function putOnSale (p, newPrice)

local qh = dbQuery (db, "SELECT * FROM housing")
local housingTable = dbPoll (qh, -1)
local pickup = getElementData(p, "houseHit")
local houseID = housingTable[housing[pickup]].id
local sale = housingTable[housing[pickup]].sale

	if (tonumber(sale) == 1) then
		if (tonumber(newPrice)) then
			dbExec(db, "UPDATE housing SET price=? WHERE id=?", newPrice, houseID)
			dbExec(db, "UPDATE housing SET sale=? WHERE id=?", 0, houseID)
			outputChatBox("You have put your house for sale for $"..newPrice.." !",p,255,255,0)	
			for k,v in ipairs (getElementsByType"pickup") do
				if (housing[v]) then
					destroyElement(v)
					housing[v] = nil
				end
			end
			createHouses()		
		else
			outputChatBox("Price must be an integer (Number). !",p,255,0,0)
		end
	else
		dbExec(db, "UPDATE housing SET sale=? WHERE id=?", 1, houseID)
		outputChatBox("You have removed your house from being sold !",p,255,255,0)
			for k,v in ipairs (getElementsByType"pickup") do
				if (housing[v]) then
					destroyElement(v)
					housing[v] = nil
				end
			end
			createHouses()			
	end	
			
end
addEvent("housing:putOnSale", true)
addEventHandler("housing:putOnSale", root, putOnSale)


function setNewOwner (p, newOwner)

	if (getAccount(newOwner)) then
		local qh = dbQuery (db, "SELECT * FROM housing")
		local housingTable = dbPoll (qh, -1)
		local pickup = getAccountData(getPlayerAccount(p), "houseHit")
		local houseID = housingTable[housing[pickup]].id
		dbExec(db, "UPDATE housing SET owner=? WHERE id=?", tostring(newOwner), houseID)
		outputChatBox("You have gifted '"..newOwner.."' your house !", p,255,255,0)
			for k,v in ipairs (getElementsByType"pickup") do
				if (housing[v]) then
					destroyElement(v)
					housing[v] = nil
				end
			end
			createHouses()
	else
		outputChatBox("There isn't such account '"..newOwner.."'!", p, 255,0,0)
	end
end
addEvent("housing:changeOwner", true)
addEventHandler("housing:changeOwner", root, setNewOwner)	


function buyHouse (p)				

	local qh = dbQuery (db, "SELECT * FROM housing")
	local housingTable = dbPoll (qh, -1)
	local pickup = getAccountData(getPlayerAccount(p), "houseHit")
	local houseID = housingTable[housing[pickup]].id
	local realOwner = housingTable[housing[pickup]].owner
	local price = housingTable[housing[pickup]].price
	local ownerAccount = getAccount(realOwner)

		if (ownerAccount ~= realOwner) then
			if (getAccountPlayer(ownerAccount)) then
				local oldOwner = getAccountPlayer(ownerAccount)
				if (getPlayerMoney(p) >= tonumber(price)) then
					givePlayerMoney (oldOwner, tonumber(price))
					takePlayerMoney(p, tonumber(price))
					dbExec(db, "UPDATE housing SET owner=? WHERE id=?", getAccountName(getPlayerAccount(p)), houseID)
					dbExec(db, "UPDATE housing SET sale=? WHERE id=?", 1, houseID)
					dbExec(db, "UPDATE housing SET pass=? WHERE id=?", "N/A", houseID)
					outputChatBox("You have successfuly bought this property !",p, 255,255,0)
					outputChatBox(""..getPlayerName(p).." has bought your house for $"..price.."!", oldOwner, 255,255,0)
					for k,v in ipairs (getElementsByType"pickup") do
						if (housing[v]) then
							destroyElement(v)
							housing[v] = nil
						end
					end
					createHouses()
				else
					outputChatBox("You don't have enough money to buy this house !",p,255,0,0)
				end		
			else
				if (getPlayerMoney(p) >= tonumber(price)) then
					takePlayerMoney(p, tonumber(price))
					exports.UGCbanking:giveMoneyByAccount(realOwner, tonumber(price))
					dbExec(db, "UPDATE housing SET owner=? WHERE id=?", getAccountName(getPlayerAccount(p)), houseID)
					dbExec(db, "UPDATE housing SET sale=? WHERE id=?", 1, houseID)
					dbExec(db, "UPDATE housing SET pass=? WHERE id=?", "N/A", houseID)
					outputChatBox("You have successfuly bought this property !",p, 255,255,0)
					for k,v in ipairs (getElementsByType"pickup") do
						if (housing[v]) then
							destroyElement(v)
							housing[v] = nil
						end
					end
					createHouses()
				else
					outputChatBox("You can't afford buying this property !",p,255,0,0)
				end
			end
		else
			outputChatBox("Error while buying the property: You can't buy your own property !", p,255,0,0)
		end	
end
addEvent("housing:buyHouse", true)
addEventHandler("housing:buyHouse", root, buyHouse)	


function openHouseCreation (p, _)		

local accName = getAccountName(getPlayerAccount(p))
	if (isObjectInACLGroup ("user."..accName, aclGetGroup ( "L5" ) )) then	
		triggerClientEvent(p,"housing:openBuildingWindow", p)	
	end
end
addCommandHandler("build", openHouseCreation)		


function createHouse (p, x,y,z,hx,hy,hz,dim,int,owner,price)
	
	if tonumber(x) then
		if (tonumber(y)) then
			if (tonumber(z)) then
				if (tonumber(hx)) then
					if (tonumber(hy)) then
						if (tonumber(hz)) then
							if (tonumber(dim)) then
								if (tonumber(int)) then
									if (getAccount(owner)) then
										if (tonumber(price)) then
											local qh = dbQuery (db, "SELECT * FROM housing")
											local result = dbPoll (qh, -1)
											local num = #result
											outputDebugString("New house has been created successfully!",3,255,255,0)
											dbExec(db, "INSERT INTO housing (id,x,y,z,hx,hy,hz,owner,interior, dimension, sale, price) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)", num+1, tonumber(x),tonumber(y),tonumber(z)-1,tonumber(hx),tonumber(hy),tonumber(hz),owner,tonumber(int),tonumber(dim),0,tonumber(price))
											for k,v in ipairs (getElementsByType"pickup") do
												if (housing[v]) then
													destroyElement(v)
													housing[v] = nil
												end
											end
											createHouses()
										else
											outputChatBox("Price must be a number!",p,255,0,0)	
										end
									else
										outputChatBox("This account doesn't exist!",p,255,0,0)	
									end
								else
									outputChatBox("Interior must be a number!",p,255,0,0)
								end				
							else
								outputChatBox("Dimension must be a number!",p,255,0,0)
							end	
						else
							outputChatBox("House Z must be a number!",p,255,0,0)
						end		
					else
						outputChatBox("House Y must be a number!",p,255,0,0)
					end	
				else
					outputChatBox("House X must be a number!",p,255,0,0)
				end		
			else
				outputChatBox("Z must be a number!",p,255,0,0)	
			end
		else
			outputChatBox("Y must be a number!",p,255,0,0)	
		end
	else
		outputChatBox("X must be a number!",p,255,0,0)
	end	
end
addEvent("housing:createHouse", true)
addEventHandler("housing:createHouse", root, createHouse)				
