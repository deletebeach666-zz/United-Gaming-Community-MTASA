----------------------->
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Project: United Gaming Community
-- Date: 21 February 2017
-- Script: UGCdev/client.lua
-- Type: Client Sided
------------------------>
local resourceTable = {}

ResourcePanel = {
    edit = {},
    button = {},
    window = {},
    label = {},
    gridlist = {}
}

guiSetInputMode("no_binds_when_editing") -- Disables Input

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        guiSetInputMode("no_binds_when_editing")
        ResourcePanel.window[1] = guiCreateWindow(503, 139, 668, 514, "United Gaming Community - Developer's Resource List", false)
        guiWindowSetSizable(ResourcePanel.window[1], false)
        local screenW, screenH = guiGetScreenSize()
        local windowW, windowH = guiGetSize(ResourcePanel.window[1], false)
        local x, y = (screenW - windowW) /2,(screenH - windowH) /2
        guiSetPosition(ResourcePanel.window[1], x, y, false)
        guiSetVisible(ResourcePanel.window[1], false)
        ResourcePanel.label[1] = guiCreateLabel(10, 26, 635, 32, "This is an alternative for commands such as /start, /stop and /restart. This is a complete GUI Based system so that you can search for resources whenever you can", false, ResourcePanel.window[1])
        guiLabelSetHorizontalAlign(ResourcePanel.label[1], "left", true)
        ResourcePanel.label[2] = guiCreateLabel(10, 68, 48, 15, "Search:", false, ResourcePanel.window[1])
        guiSetFont(ResourcePanel.label[2], "default-bold-small")
        ResourcePanel.edit[1] = guiCreateEdit(58, 62, 587, 27, "", false, ResourcePanel.window[1])
        ResourcePanel.label[3] = guiCreateLabel(10, 94, 63, 15, "Resources:", false, ResourcePanel.window[1])
        guiSetFont(ResourcePanel.label[3], "default-bold-small")
        ResourcePanel.gridlist[1] = guiCreateGridList(10, 109, 644, 334, false, ResourcePanel.window[1])
        --guiGridListSetSortingEnabled(ResourcePanel.gridlist[1], false)
        resourceCol = guiGridListAddColumn(ResourcePanel.gridlist[1], "Resource Name", 0.3)
        nameCol = guiGridListAddColumn(ResourcePanel.gridlist[1], "Name", 0.3)
        authorCol = guiGridListAddColumn(ResourcePanel.gridlist[1], "Author", 0.2)
        stateCol = guiGridListAddColumn(ResourcePanel.gridlist[1], "State", 0.2)
        ResourcePanel.button[1] = guiCreateButton(10, 448, 127, 37, "Start", false, ResourcePanel.window[1])
        guiSetFont(ResourcePanel.button[1], "default-bold-small")
        guiSetProperty(ResourcePanel.button[1], "NormalTextColour", "FFAAAAAA")
        ResourcePanel.button[2] = guiCreateButton(171, 448, 127, 37, "Stop", false, ResourcePanel.window[1])
        guiSetFont(ResourcePanel.button[2], "default-bold-small")
        guiSetProperty(ResourcePanel.button[2], "NormalTextColour", "FFAAAAAA")
        ResourcePanel.button[3] = guiCreateButton(345, 449, 127, 36, "Restart", false, ResourcePanel.window[1])
        guiSetFont(ResourcePanel.button[3], "default-bold-small")
        guiSetProperty(ResourcePanel.button[3], "NormalTextColour", "FFAAAAAA")
        ResourcePanel.button[4] = guiCreateButton(512, 449, 132, 36, "Refresh List", false, ResourcePanel.window[1])
        guiSetFont(ResourcePanel.button[4], "default-bold-small")
        guiSetProperty(ResourcePanel.button[4], "NormalTextColour", "FFAAAAAA")
        ResourcePanel.label[4] = guiCreateLabel(565, 488, 84, 16, "Close Window", false, ResourcePanel.window[1])
        guiSetFont(ResourcePanel.label[4], "default-bold-small")    
    end
)

function closeWindow(btn)
    if source == ResourcePanel.label[4] then
        if btn == "left" then
            showCursor(false)
            guiSetVisible(ResourcePanel.window[1], false)
        end
    end
end
addEventHandler("onClientGUIClick", resourceRoot, closeWindow)

function highLight1()
    if source == ResourcePanel.label[4] then
        guiLabelSetColor(ResourcePanel.label[4], 255, 0, 0)
    end
end
addEventHandler("onClientMouseEnter", resourceRoot, highLight1)

function highLight2()
    if source == ResourcePanel.label[4] then
        guiLabelSetColor(ResourcePanel.label[4], 255, 255, 255)
    end
end
addEventHandler("onClientMouseLeave", resourceRoot, highLight2)

function startWindow(res)
       guiSetVisible(ResourcePanel.window[1], true)
       showCursor(true)
       resourceTable = res
       guiGridListClear(ResourcePanel.gridlist[1])
       for k, v in pairs(res) do
           local row = guiGridListAddRow(ResourcePanel.gridlist[1])
           if v[3] == false or v[3] == nil then
                        v[3] = "Unspecified"
                        end
           guiGridListSetItemText(ResourcePanel.gridlist[1], row, resourceCol, k, false, false)
           guiGridListSetItemText(ResourcePanel.gridlist[1], row, nameCol, v[3], false, false)
           guiGridListSetItemText(ResourcePanel.gridlist[1], row, authorCol, v[2], false, false)
           guiGridListSetItemText(ResourcePanel.gridlist[1], row, stateCol, v[1], false, false)
           if v[1] == "running" then 
           guiGridListSetItemColor(ResourcePanel.gridlist[1], row, resourceCol, 0, 255, 0) 
           else
           guiGridListSetItemColor(ResourcePanel.gridlist[1], row, resourceCol, 255, 0, 0)
           end
    end
end
addEvent("UGCdev.openDevelopersPanel", true)
addEventHandler("UGCdev.openDevelopersPanel", resourceRoot, startWindow)

-- Grid List Updater.
function update(tbl)
       for k, v in pairs(tbl) do
           local row = guiGridListAddRow(ResourcePanel.gridlist[1])
           if v[3] == false or v[3] == nil then
                        v[3] = "Unspecified"
                        end
           guiGridListSetItemText(ResourcePanel.gridlist[1], row, resourceCol, k, false, false)
           guiGridListSetItemText(ResourcePanel.gridlist[1], row, nameCol, v[3], false, false)
           guiGridListSetItemText(ResourcePanel.gridlist[1], row, authorCol, v[2], false, false)
           guiGridListSetItemText(ResourcePanel.gridlist[1], row, stateCol, v[1], false, false)
           if v[1] == "running" then 
           guiGridListSetItemColor(ResourcePanel.gridlist[1], row, resourceCol, 0, 255, 0) 
           else
           guiGridListSetItemColor(ResourcePanel.gridlist[1], row, resourceCol, 255, 0, 0)
           end
    end
end
addEvent("UGCdev.UGCdev.refreshGridList", true)
addEventHandler("UGCdev.UGCdev.refreshGridList", resourceRoot, update)

-- Search Box
addEventHandler("onClientGUIChanged", resourceRoot, 
    function() 
        if source == ResourcePanel.edit[1] then 
            guiGridListClear(ResourcePanel.gridlist[1]) 
            for k, v in pairs(resourceTable) do 
                if string.find(string.gsub(k, "#%x%x%x%x%x%x", ""), guiGetText(source)) or string.find(string.gsub(v[1], "#%x%x%x%x%x%x", ""), guiGetText(source)) or string.find(string.gsub(v[2], "#%x%x%x%x%x%x", ""), guiGetText(source)) then
                    local row = guiGridListAddRow(ResourcePanel.gridlist[1])
                    if v[3] == false or v[3] == nil then
                        v[3] = "Unspecified"
                        end
                    guiGridListSetItemText(ResourcePanel.gridlist[1], row, resourceCol, k, false, false)
                    guiGridListSetItemText(ResourcePanel.gridlist[1], row, nameCol, v[3], false, false)
                    guiGridListSetItemText(ResourcePanel.gridlist[1], row, authorCol, v[2], false, false)
                    guiGridListSetItemText(ResourcePanel.gridlist[1], row, stateCol, v[1], false, false)
                    if v[1] == "running" then 
                    guiGridListSetItemColor(ResourcePanel.gridlist[1], row, resourceCol, 0, 255, 0) 
                    else
                    guiGridListSetItemColor(ResourcePanel.gridlist[1], row, resourceCol, 255, 0, 0)
                    end
                end 
            end 
        end 
    end 
) 



-- Start Button
function onStartButtonPressed(btn)
    if btn == "left" then
        if source == ResourcePanel.button[1] then
            local resource = guiGridListGetItemText(ResourcePanel.gridlist[1], guiGridListGetSelectedItem (ResourcePanel.gridlist[1]), 1)
            triggerServerEvent("UGCdev.startResource", resourceRoot, localPlayer, resource)
        end
    end
end
addEventHandler("onClientGUIClick", resourceRoot, onStartButtonPressed)

-- Stop Button
function onStopButtonPressed(btn)
    if btn == "left" then
        if source == ResourcePanel.button[2] then
            local resource = guiGridListGetItemText(ResourcePanel.gridlist[1], guiGridListGetSelectedItem (ResourcePanel.gridlist[1]), 1)
            triggerServerEvent("UGCdev.stopResource", resourceRoot, localPlayer, resource)
        end
    end
end
addEventHandler("onClientGUIClick", resourceRoot, onStopButtonPressed)

-- Restart Button
function onRestartButtonPress(btn)
    if btn == "left" then
        if source == ResourcePanel.button[3] then
            local resource = guiGridListGetItemText(ResourcePanel.gridlist[1], guiGridListGetSelectedItem (ResourcePanel.gridlist[1]), 1)
            triggerServerEvent("UGCdev.restartResource", resourceRoot, localPlayer, resource)
        end
    end
end
addEventHandler("onClientGUIClick", resourceRoot, onRestartButtonPress)

-- Refresh Button
function onRestartButtonPress(btn)
    if btn == "left" then
        if source == ResourcePanel.button[4] then
            triggerServerEvent("UGCdev.refreshResources", resourceRoot, localPlayer)
        end
    end
end
addEventHandler("onClientGUIClick", resourceRoot, onRestartButtonPress)
