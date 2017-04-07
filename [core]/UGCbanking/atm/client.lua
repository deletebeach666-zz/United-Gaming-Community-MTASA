-------------------------------->
-- UGC: United Gaming Community
-- Author: Om Bhende (RipeMangoe69)
-- Date: 27 February 2017
-- Script: UGCbanking/atm/client.lua
-- Type: Client Sided
-------------------------------->

GUIEditor = {
    tab = {},
    tabpanel = {},
    edit = {},
    button = {},
    window = {},
    label = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        GUIEditor.window[1] = guiCreateWindow(543, 217, 290, 215, "UGC:RPG - Banking", false)
        guiWindowSetSizable(GUIEditor.window[1], false)
		exports.UGCutils:centerWindow(GUIEditor.window[1])
		guiSetVisible(GUIEditor.window[1], false)

        GUIEditor.label[1] = guiCreateLabel(8, 31, 274, 15, "Account Balance: $0", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.label[1], "default-bold-small")
        guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
        GUIEditor.tabpanel[1] = guiCreateTabPanel(10, 51, 271, 141, false, GUIEditor.window[1])
        GUIEditor.tab[1] = guiCreateTab("Deposit", GUIEditor.tabpanel[1])
        GUIEditor.label[2] = guiCreateLabel(12, 10, 51, 15, "Amount:", false, GUIEditor.tab[1])
        guiSetFont(GUIEditor.label[2], "default-bold-small")
        GUIEditor.edit[1] = guiCreateEdit(10, 30, 250, 29, "", false, GUIEditor.tab[1])
        GUIEditor.button[1] = guiCreateButton(10, 68, 250, 33, "Deposit", false, GUIEditor.tab[1])
        guiSetFont(GUIEditor.button[1], "default-bold-small")
        guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFAAAAAA")

        GUIEditor.tab[2] = guiCreateTab("Withdraw", GUIEditor.tabpanel[1])
        GUIEditor.label[3] = guiCreateLabel(12, 10, 51, 15, "Amount:", false, GUIEditor.tab[2])
        guiSetFont(GUIEditor.label[3], "default-bold-small")
        GUIEditor.edit[2] = guiCreateEdit(10, 30, 250, 29, "", false, GUIEditor.tab[2])
        GUIEditor.button[2] = guiCreateButton(10, 68, 250, 33, "Withdraw", false, GUIEditor.tab[2])
        guiSetFont(GUIEditor.button[2], "default-bold-small")
        guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFAAAAAA")

        GUIEditor.label[4] = guiCreateLabel(248, 192, 32, 15, "Close", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.label[4], "default-bold-small")    
		
		-- Make Objects Unbreakable
		for _, v in ipairs(getElementsByType("object")) do
			if getElementData(v, "type") == "ATM"  then
				setObjectBreakable(v, false)
			end
		end
		
    end
)

addEvent("UGCbanking.ATM.openATMWindow", true)
addEventHandler("UGCbanking.ATM.openATMWindow", resourceRoot, function(balance)
	guiSetText(GUIEditor.label[1], "Account Balance: $" .. exports.UGCutils:formatNumber(balance))
	guiSetVisible(GUIEditor.window[1], true)
	showCursor(true)
end)

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
	if btn ~= "left" then return end
	if source == GUIEditor.label[4] then
		guiSetVisible(GUIEditor.window[1], false)
		showCursor(false)
	end
end)


addEventHandler("onClientGUIClick", resourceRoot, function(btn)
	if btn ~= "left" then return end
	if source == GUIEditor.button[1] then
		local text = guiGetText(GUIEditor.edit[1])
		if text == "" or text == nil then return exports.UGCnoty:sendNotification("Please enter valid amount of cash to deposit", 255, 0, 0) end
		triggerServerEvent("UGCbanking.atm.depositMoney", resourceRoot, tonumber(text))
	end
end)

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
	if btn ~= "left" then return end
	if source == GUIEditor.button[2] then
		local text = guiGetText(GUIEditor.edit[2])
		if text == "" or text == nil then return exports.UGCnoty:sendNotification("Please enter valid amount of cash to withdraw", 255, 0, 0) end
		triggerServerEvent("UGCbanking.atm.withdrawMoney", resourceRoot, tonumber(text))
	end
end)

addEventHandler("onClientMouseEnter", resourceRoot, function()
	if source == GUIEditor.label[4] then
		guiLabelSetColor(GUIEditor.label[4], 255, 0, 0)
	end
end)

addEventHandler("onClientMouseLeave", resourceRoot, function()
	if source == GUIEditor.label[4] then
		guiLabelSetColor(GUIEditor.label[4], 255, 255, 255)
	end
end)

addEventHandler("onClientGUIChanged", resourceRoot, function() 
	if source == GUIEditor.edit[1] or source == GUIEditor.edit[2] then
	    local text = guiGetText(source) or "" 
	    if not tonumber(text) then --if the text isn't a number (statement needed to prevent infinite loop) 
	        guiSetText(source, string.gsub(text, "%a", "")) --Remove all letters 
	    end 
	end
end) 

addEvent("UGCbanking.atm.updateBalance", true)
addEventHandler("UGCbanking.atm.updateBalance", resourceRoot, function(amount)
	guiSetText(GUIEditor.label[1], "Account Balance: $" .. amount)
	guiSetText(GUIEditor.edit[1], "")
	guiSetText(GUIEditor.edit[2], "")
end)

