--[[ 
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 21 March 2017
-- Script: UGCgroups/features/history/client.lua
-- Type: Client Sided
]]--

History = {
    edit = {},
    button = {},
    window = {},
    label = {},
    gridlist = {}
}

local grouplogs = {}

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        History.window[1] = guiCreateWindow(380, 189, 560, 458, "Military Forces - Group Logs", false)
        guiWindowSetSizable(History.window[1], false)
        guiSetVisible(History.window[1], false)
        exports.UGCutils:centerWindow(History.window[1])

        History.label[1] = guiCreateLabel(11, 29, 39, 15, "Search", false, History.window[1])
        guiSetFont(History.label[1], "default-bold-small")
        History.edit[1] = guiCreateEdit(55, 24, 486, 26, "", false, History.window[1])
        History.gridlist[1] = guiCreateGridList(9, 57, 542, 357, false, History.window[1])
        historyLog = guiGridListAddColumn(History.gridlist[1], "Log", 1.5)
        History.button[1] = guiCreateButton(440, 420, 105, 28, "Close", false, History.window[1])
        guiSetFont(History.button[1], "default-bold-small")
        guiSetProperty(History.button[1], "NormalTextColour", "FFAAAAAA")    
    end
)

addEvent("UGCgroups.openHistoryWindow", true)
addEventHandler("UGCgroups.openHistoryWindow", resourceRoot, function(logs)
    grouplogs = logs
    local toggle = guiGetVisible(History.window[1])
    if toggle then
        guiSetVisible(History.window[1], false)
    else
        guiSetVisible(History.window[1], true)
        guiBringToFront(History.window[1])
        guiGridListClear(History.gridlist[1])
        for _, v in ipairs(logs) do
            local row = guiGridListAddRow(History.gridlist[1])
            guiGridListSetItemText(History.gridlist[1], row, historyLog, v, false, false)
        end
    end
end)

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if btn == "left" and source == History.button[1] then
        guiSetVisible(History.window[1], false)
    end
end)

addEventHandler("onClientGUIDoubleClick", resourceRoot, function(btn)
    if btn == "left" and source == History.gridlist[1] then
        local log = guiGridListGetItemText(History.gridlist[1], guiGridListGetSelectedItem(History.gridlist[1]), 1)
        if log == "" or log == nil then return false end
        exports.UGCnoty:sendNotification("Log has been copied to clipboard!", 0, 255, 0)
        setClipboard(log)
    end
end)
-- Search Box
---------------->
local quotepattern = '(['..("%^$().[]*+-?"):gsub("(.)", "%%%1")..'])'
string.quote = function(str)
    return str:gsub(quotepattern, "%%%1")
end

addEventHandler("onClientGUIChanged", resourceRoot, function()
    if source == History.edit[1] then
        local text = guiGetText(History.edit[1])
        guiGridListClear(History.gridlist[1])
        for _, v in ipairs(grouplogs) do
            if string.match(string.lower(v), string.lower(string.quote(text))) then
                local row = guiGridListAddRow(History.gridlist[1])
                guiGridListSetItemText(History.gridlist[1], row, historyLog, v, false, false)
            end
        end
    end
end)