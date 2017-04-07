-------------------------------->
-- UGC: United Gaming Community
-- Author: Om Bhende (RipeMangoe69)
-- Date: 15 March 2017
-- Script: UGCbanking/client.lua
-- Type: Client Sided
-------------------------------->

Bank = {
    tab = {},
    staticimage = {},
    tabpanel = {},
    edit = {},
    button = {},
    window = {},
    label = {}
}

local type =  {
	["added"] = "Deposited",
	["removed"] = "Withdrawed",
	["transfer"] = "Bank Transfer",
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        Bank.window[1] = guiCreateWindow(347, 201, 640, 297, "UGC:RPG - Maze Bank", false)
        guiWindowSetSizable(Bank.window[1], false)

        Bank.staticimage[1] = guiCreateStaticImage(9, 27, 617, 98, "img/bank.png", false, Bank.window[1])
        Bank.tabpanel[1] = guiCreateTabPanel(9, 159, 292, 131, false, Bank.window[1])
		exports.UGCutils:centerWindow(Bank.window[1])
		guiSetVisible(Bank.window[1], false)
		

        Bank.tab[1] = guiCreateTab("Deposit", Bank.tabpanel[1])

        Bank.label[1] = guiCreateLabel(8, 13, 54, 15, "Amount:", false, Bank.tab[1])
        guiSetFont(Bank.label[1], "default-bold-small")
        Bank.edit[1] = guiCreateEdit(8, 31, 274, 32, "", false, Bank.tab[1])
        Bank.button[1] = guiCreateButton(6, 72, 276, 26, "Deposit", false, Bank.tab[1])
        guiSetFont(Bank.button[1], "default-bold-small")
        guiSetProperty(Bank.button[1], "NormalTextColour", "FFAAAAAA")

        Bank.tab[2] = guiCreateTab("Withdraw", Bank.tabpanel[1])
		
		Bank.label[7] = guiCreateLabel(8, 13, 54, 15, "Amount:", false, Bank.tab[2])
        guiSetFont(Bank.label[7], "default-bold-small")
        Bank.edit[4] = guiCreateEdit(8, 31, 274, 32, "", false, Bank.tab[2])
        Bank.button[4] = guiCreateButton(6, 72, 276, 26, "Withdraw", false, Bank.tab[2])
        guiSetFont(Bank.button[4], "default-bold-small")
        guiSetProperty(Bank.button[4], "NormalTextColour", "FFAAAAAA")

        Bank.label[2] = guiCreateLabel(8, 131, 618, 18, "Account Balance: $0", false, Bank.window[1])
        guiSetFont(Bank.label[2], "default-bold-small")
        guiLabelSetHorizontalAlign(Bank.label[2], "center", false)
        Bank.label[3] = guiCreateLabel(322, 217, 98, 15, "Transfer Money:", false, Bank.window[1])
        guiSetFont(Bank.label[3], "default-bold-small")
        guiLabelSetVerticalAlign(Bank.label[3], "bottom")
        Bank.edit[2] = guiCreateEdit(420, 217, 77, 20, "", false, Bank.window[1])
        Bank.button[2] = guiCreateButton(572, 217, 51, 20, ">", false, Bank.window[1])
        guiSetFont(Bank.button[2], "default-bold-small")
        guiSetProperty(Bank.button[2], "NormalTextColour", "FFAAAAAA")
        Bank.edit[3] = guiCreateEdit(497, 217, 75, 20, "", false, Bank.window[1])
        Bank.label[4] = guiCreateLabel(420, 202, 152, 15, "Amount           Username", false, Bank.window[1])
        guiSetFont(Bank.label[4], "default-bold-small")
        Bank.label[5] = guiCreateLabel(317, 249, 98, 21, "Transaction Logs:", false, Bank.window[1])
        guiSetFont(Bank.label[5], "default-bold-small")
        guiLabelSetVerticalAlign(Bank.label[5], "center")
        Bank.button[3] = guiCreateButton(420, 249, 206, 21, "Open", false, Bank.window[1])
        guiSetFont(Bank.button[3], "default-bold-small")
        guiSetProperty(Bank.button[3], "NormalTextColour", "FFAAAAAA")
        Bank.label[6] = guiCreateLabel(322, 168, 308, 44, "Welcome to Maze Bank! Hope you enjoy your stay :)", false, Bank.window[1])
        guiSetFont(Bank.label[6], "default-bold-small")
        guiLabelSetHorizontalAlign(Bank.label[6], "left", true)    
		Bank.label[8] = guiCreateLabel(600, 272, 30, 15, "Close", false, Bank.window[1])
        guiSetFont(Bank.label[8], "default-bold-small")    
    end
)

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
	if btn == "left" and source == Bank.label[8] then
		guiSetVisible(Bank.window[1], false)
		showCursor(false)
	end
end)

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
	if btn == "left" and source == Bank.button[2] then
		local amount = guiGetText(Bank.edit[2])
		local accName = guiGetText(Bank.edit[3])
		if amount == "" or accName == "" then return exports.UGCnoty:sendNotification("Please enter valid amount and account name", 255, 0, 0) end
		triggerServerEvent("UGCbanking.transferMoney", resourceRoot, amount, accName)
	end
end)

addEvent("UGCbanking.openBankWindow", true)
addEventHandler("UGCbanking.openBankWindow", resourceRoot, function(name, balance)
	guiSetText(Bank.label[2], "Account Balance: $" .. exports.UGCutils:formatNumber(balance))
	local info = string.gsub(guiGetText(Bank.label[6]), "{playerName}", getPlayerName(localPlayer))
	info = string.gsub(info, "{bankBalance}", exports.UGCutils:formatNumber(balance))
	guiSetText(Bank.label[6], info)
	guiSetVisible(Bank.window[1], true)
	showCursor(true)
end)


addEvent("UGCbanking.closeBankWindow", true)
addEventHandler("UGCbanking.closeBankWindow", resourceRoot, function()
	guiSetVisible(Bank.window[1], false)
	showCursor(false)
end)

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
	if btn == "left" and source == Bank.button[3] then
		triggerServerEvent("UGCbanking.requestLogs", resourceRoot)
	end
end)

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
	if btn == "left" and source == Logs.label[1] then
		guiSetVisible(Bank.window[2], false)
	end
end)


addEventHandler("onClientGUIClick", resourceRoot, function(btn)
	if btn ~= "left" then return end
	if source == Bank.button[1] then
		local text = guiGetText(Bank.edit[1])
		if text == "" or text == nil then return exports.UGCnoty:sendNotification("Please enter valid amount of cash to deposit", 255, 0, 0) end
		triggerServerEvent("UGCbanking.atm.depositMoney", resourceRoot, tonumber(text))
	end
end)

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
	if btn ~= "left" then return end
	if source == Bank.button[4] then
		local text = guiGetText(Bank.edit[4])
		if text == "" or text == nil then return exports.UGCnoty:sendNotification("Please enter valid amount of cash to withdraw", 255, 0, 0) end
		triggerServerEvent("UGCbanking.atm.withdrawMoney", resourceRoot, tonumber(text))
	end
end)

addEvent("UGCbanking.updateBalance", true)
addEventHandler("UGCbanking.updateBalance", resourceRoot, function(amount)
	guiSetText(Bank.label[2], "Account Balance: $" .. amount)
	guiSetText(Bank.edit[1], "")
	guiSetText(Bank.edit[4], "")
end)


addEventHandler("onClientGUIChanged", resourceRoot, function()
	if source == GUIEditor.edit[1] or source == GUIEditor.edit[2] then
		local text = guiGetText(source)
		if string.match(text, "-") or type(tonumber(text)) ~= "number" then
			guiSetText(source, "")
		end
	end
end)

-- Bank Transaction Logs
------------------------->

Logs = {
    gridlist = {},
    staticimage = {},
    label = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        Bank.window[2] = guiCreateWindow(362, 194, 677, 396, "Maze Bank - Transaction Log", false)
        guiWindowSetSizable(Bank.window[2], false)
        guiSetVisible(Bank.window[2], false)

        Logs.staticimage[1] = guiCreateStaticImage(9, 21, 657, 123, "img/bank.png", false, Bank.window[2])
        Logs.label[1] = guiCreateLabel(635, 375, 31, 15, "Close", false, Bank.window[2])
        guiSetFont(Logs.label[1], "default-bold-small")
        Logs.gridlist[1] = guiCreateGridList(9, 150, 657, 225, false, Bank.window[2])
        l_date = guiGridListAddColumn(Logs.gridlist[1], "Date", 0.225)
        l_type = guiGridListAddColumn(Logs.gridlist[1], "Type", 0.125)
        l_amount = guiGridListAddColumn(Logs.gridlist[1], "Amount", 0.1)
        l_log = guiGridListAddColumn(Logs.gridlist[1], "Log", 0.575)    
    end
)

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
	if btn == "left" and source == Logs.label[1] then
		guiSetVisible(Bank.window[2], false)
	end
end)

addEvent("UGCbanking.showTransactionInterface", true)
addEventHandler("UGCbanking.showTransactionInterface", resourceRoot, function(tbl)
	guiSetVisible(Bank.window[2], true)
	guiBringToFront(Bank.window[2])
	guiGridListClear(Logs.gridlist[1])
	for _, v in ipairs(tbl) do
		local realTime = getRealTime(v.time)
		local realClock = string.format("%02d:%02d:%02d", realTime.hour, realTime.minute, realTime.second)
    	local realDate = string.format("%02d/%02d/%02d", realTime.monthday, realTime.month, string.sub(realTime.year, -2))
    	local row = guiGridListAddRow(Logs.gridlist[1])
    	guiGridListSetItemText(Logs.gridlist[1], row, l_date, "[" .. realClock .. "] [" .. realDate .. "]", false, false)
    	guiGridListSetItemText(Logs.gridlist[1], row, l_type, type[v.trans_type], false, false)
    	guiGridListSetItemText(Logs.gridlist[1], row, l_amount, v.amount, false, false)
    	guiGridListSetItemText(Logs.gridlist[1], row, l_log, v.log, false, false)
	end
end)

-- Highlight Btns
------------------->

addEventHandler("onClientMouseEnter", resourceRoot, function()
	if source == Bank.label[8] or source == Logs.label[1] then
		guiLabelSetColor(source, 255, 0, 0)
	end
end)

addEventHandler("onClientMouseLeave", resourceRoot, function()
	if source == Bank.label[8] or source == Logs.label[1]then
		guiLabelSetColor(source, 255, 255, 255)
	end
end)

addEventHandler("onClientGUIChanged", resourceRoot, function() 
	if source == Bank.edit[1] or source == Bank.edit[2] or source == Bank.edit[4] then
	    local text = guiGetText(source) or "" 
	    if not tonumber(text) then --if the text isn't a number (statement needed to prevent infinite loop) 
	        guiSetText(source, string.gsub(text, "%a", "")) --Remove all letters 
	    end 
	end
end) 

