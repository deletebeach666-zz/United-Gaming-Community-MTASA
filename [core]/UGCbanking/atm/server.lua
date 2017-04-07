-------------------------------->
-- UGC: United Gaming Community
-- Author: Om Bhende (RipeMangoe69)
-- Date: 27 February 2017
-- Script: UGCbanking/atm/server.lua
-- Type: Server Sided
-------------------------------->

local atm = { 
	-- Los Santos
	{597.59942626953, -1572.4454345703, 16.1796875-0.4, 0.54605102539},	
	{960.51574707031, -1562.6971435547, 13.182020759583, 358.07608032227},
	{1287.8150634766, -1637.8179931641, 13.146875, 90.920021057129},
	{1748.8226318359, -1863.5760498047, 13.174905395508, 181.71437072754},
	{2325.6135253906, -1374.7003173828, 23.614812469482, 357.88284301758},
	{2404.3676757813, -1229.6284179688, 23.43069229126, 89.798606872559},
	{1949.2349853516, -2176.1755371094, 13.154208755493, 180.30256652832},
	{209.6707611084, -1433.6075439453, 12.801782226562, 52.161079406738},
	{1182.4306640625, -1346.9519042969, 13.761429405212, 88.606430053711},
	
	-- San Fierro
	{-1828.7767333984, 34.237453460693, 14.722790336609, 91.735107421875},
	{-1689.3670654297, 418.95263671875, 6.7796875, 45.242923736572},
	{-1694.5343017578, 413.78353881836, 6.7796875, 45.242923736572},
	{-1771.3370361328, 963.38275146484, 24.4828125, 359.14447021484},
	{-1909.9625244141, 280.32907104492, 40.646875, 272.9091796875},
	{-1909.9600830078, 282.59069824219, 40.646875, 272.9091796875},
	{-2032.9759521484, 164.6771697998, 28.4359375, 87.436019897461},
	{-2295.1418457031, -180.22160339355, 34.9203125, 2.5297904014587},
	{-2746.5141601563, 167.34280395508, 6.7356258392334, 353.64776611328},
	{-2676.4602050781, 634.66912841797, 14.053125, 8.5211982727051},
	
	-- SF/LV Side
	{-1228.6297607422, 1827.0059814453, 41.31875, 309.98950195313},
	{-1463.3375244141, 1873.6109619141, 32.2328125, 4.5306186676025},
	{-1503.0847167969, 2518.7990722656, 55.528466796875, 176.55213928223},
	{-2454.5617675781, 2258.6577148438, 4.5823474884033, 272.40795898438},
	
	-- Las Venturas
	{-308.84802246094, 1053.8278808594, 19.3421875, 181.82669067383},
	{1628.4307861328, 1812.0213623047, 10.4203125, 89.940444946289},
	{1587.5516357422, 2217.9975585938, 10.669194793701, 356.4186706543},
	{1887.8012695313, 2445.5544433594, 10.778249359131, 90.328826904297},
	{1889.6607666016, 2448.5583496094, 10.778249359131, 1.7893908023834},
	{2539.5329589844, 2066.4965820313, 10.7015625, 273.64624023438},
	{2834.0974121094, 2403.2687988281, 10.668956375122, 45.861820220947},
	{2841.6577148438, 1306.0202636719, 10.990625, 277.56533813477},
	{2841.6540527344, 1322.5432128906, 10.990625, 272.00262451172},

	-- In Bank
	{1438.8947753906, -1013.6145629883, -57.2671875, 179.91848754883},
	{1436.3525390625, -1013.6166992188, -57.2671875, 183.39517211914},
	{1437.1417236328, -983.255859375, -57.2671875, 0.86947381496429},
	{1439.255859375, -983.2578125, -57.2671875, 3.3031451702118},
}

addEventHandler("onResourceStart", resourceRoot, function()
	for _, v in ipairs(atm) do
		obj = createObject(2942, v[1], v[2], v[3], 0, 0, v[4])
		setElementData(obj, "type", "ATM")
		col = createColTube(v[1], v[2], v[3]-1, 0.8, 2)
		--createBlipAttachedTo(col, 52, 1, 255, 0, 0, 0, 0, 300)
		createMarker(v[1], v[2], v[3]-1, "cylinder", 1, 0, 255, 0)
		addEventHandler("onColShapeHit", col, openWindow)
	end
end)

function openWindow(hitEle, matchingDim)
if getElementType(hitEle) ~= "player" then return false end -- Break if element is not a player
if matchingDim ~= true then return false end -- Break if player is in another dimension
triggerClientEvent(hitEle, "UGCbanking.ATM.openATMWindow", resourceRoot, getPlayerBankBalance(hitEle))
end

addEvent("UGCbanking.atm.depositMoney", true)
addEventHandler("UGCbanking.atm.depositMoney", resourceRoot, function(amount)
	if type(amount) == "number" then
		if amount > getPlayerMoney(client) then return exports.UGCnoty:sendNotification("You do not have sufficient cash!", client, 255, 0, 0) end
		addMoneyToBank(client, amount, "Bank Deposits")
		exports.UGCnoty:sendNotification("You've successfully deposited $" .. amount .. " in your bank!", client, 0, 255, 0)
		takePlayerMoney(client, amount)
		triggerClientEvent(client, "UGCbanking.atm.updateBalance", resourceRoot, exports.UGCutils:formatNumber(getPlayerBankBalance(client)))
		triggerClientEvent(client, "UGCbanking.updateBalance", resourceRoot, exports.UGCutils:formatNumber(getPlayerBankBalance(client)))
	end
end)

addEvent("UGCbanking.atm.withdrawMoney", true)
addEventHandler("UGCbanking.atm.withdrawMoney", resourceRoot, function(amount)
	if type(amount) == "number" then
		if amount > getPlayerBankBalance(client) then return exports.UGCnoty:sendNotification("You do not have sufficient cash!", client, 255, 0, 0) end
		removeMoneyFromBank(client, amount, "Bank Withdrawal")
		exports.UGCnoty:sendNotification("You've successfully withdrawed $" .. amount .. " from your bank!", client, 0, 255, 0)
		givePlayerMoney(client, amount)
		triggerClientEvent(client, "UGCbanking.atm.updateBalance", resourceRoot, getPlayerBankBalance(client))
		triggerClientEvent(client, "UGCbanking.updateBalance", resourceRoot, exports.UGCutils:formatNumber(getPlayerBankBalance(client)))
	end
end)