--[[ 
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 24 March 2017
-- Script: UGCgroups/features/warn/client.lua
-- Type: Client Sided
]]--


Warn = {
    edit = {},
    button = {},
    window = {},
    scrollbar = {},
    label = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        Warn.window[1] = guiCreateWindow(529, 307, 306, 151, "Warn Player", false)
        guiWindowSetSizable(Warn.window[1], false)
        guiSetVisible(Warn.window[1], false)
        exports.UGCutils:centerWindow(Warn.window[1])

        Warn.label[1] = guiCreateLabel(10, 24, 87, 15, "Member Name:", false, Warn.window[1])
        guiSetFont(Warn.label[1], "default-bold-small")
        Warn.label[2] = guiCreateLabel(101, 24, 194, 15, "[UGC]Om|MF", false, Warn.window[1])
        guiSetFont(Warn.label[2], "clear-normal")
        Warn.label[3] = guiCreateLabel(10, 44, 87, 15, "Issue Warning:", false, Warn.window[1])
        guiSetFont(Warn.label[3], "default-bold-small")
        Warn.scrollbar[1] = guiCreateScrollBar(102, 45, 188, 14, true, false, Warn.window[1])
        guiScrollBarSetScrollPosition(Warn.scrollbar[1], 100.0)
        Warn.label[4] = guiCreateLabel(10, 83, 45, 15, "Reason:", false, Warn.window[1])
        guiSetFont(Warn.label[4], "default-bold-small")
        Warn.edit[1] = guiCreateEdit(65, 78, 225, 25, "", false, Warn.window[1])
        warningLevel = guiCreateLabel(10, 63, 280, 15, "Warning Level: 0%", false, Warn.window[1])
        guiSetFont(warningLevel, "default-small")
        guiLabelSetHorizontalAlign(warningLevel, "right", false)
        Warn.button[1] = guiCreateButton(10, 109, 141, 32, "Cancel", false, Warn.window[1])
        guiSetFont(Warn.button[1], "default-bold-small")
        guiSetProperty(Warn.button[1], "NormalTextColour", "FFAAAAAA")
        Warn.button[2] = guiCreateButton(151, 109, 139, 31, "Warn", false, Warn.window[1])
        guiSetFont(Warn.button[2], "default-bold-small")
        guiSetProperty(Warn.button[2], "NormalTextColour", "FFAAAAAA")    
    end
)


function OnScroll()
    if source == Warn.scrollbar[1] then
        if warningLevel == nil or getElementType(warningLevel) ~= "gui-label" then return false end
        guiSetText(warningLevel, "Warning Level: " .. guiScrollBarGetScrollPosition(source) .. "%")
    end
end
addEventHandler("onClientGUIScroll", resourceRoot, OnScroll)


addEvent("UGCgroups.openWarnWindow", true)
addEventHandler("UGCgroups.openWarnWindow", resourceRoot, function(playerName, warn)
    guiSetVisible(Warn.window[1], true)
    guiSetText(Warn.label[2], playerName)
    guiBringToFront(Warn.window[1])
    guiScrollBarSetScrollPosition(Warn.scrollbar[1], warn or 0)
    guiSetText(warningLevel, "Warning Level: " .. warn or 0 .. "%")
end)

-- Close Window
---------------->
addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if btn == "left" and source == Warn.button[1] then
        guiSetVisible(Warn.window[1], false)
    end
end)

-- Warn Button
---------------->
addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if btn == "left" and source == Warn.button[2] then
        if guiGetText(Warn.edit[1]) == "" or guiGetText(Warn.edit[1]) == nil then return exports.UGCnoty:sendNotification("Please enter a valid reason for warning!", 255, 0, 0) end
        guiSetVisible(Warn.window[1], false)
        triggerServerEvent("UGCgroups.issueWarning", resourceRoot, guiGetText(Warn.label[2]), guiScrollBarGetScrollPosition(Warn.scrollbar[1]), guiGetText(Warn.edit[1]))
    end
end)

addEvent("UGCgroups.warnedPlayer", true)
addEventHandler("UGCgroups.warnedPlayer", resourceRoot, function()
    refreshGroupMembers()
end)