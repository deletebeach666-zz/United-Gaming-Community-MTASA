--[[ 
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 21 March 2017
-- Script: UGCgroups/features/info/client.lua
-- Type: Client Sided
]]--



info = {
    button = {},
    window = {},
    label = {},
    memo = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        info_window = guiCreateWindow(424, 133, 519, 450, "USMS - Group Information", false)
        guiWindowSetSizable(info_window, false)
        exports.UGCutils:centerWindow(info_window)
        guiSetVisible(info_window, false)

        info.label[1] = guiCreateLabel(10, 24, 66, 15, "Group Info:", false, info_window)
        guiSetFont(info.label[1], "default-bold-small")
        info_edit = guiCreateMemo(9, 43, 501, 371, "", false, info_window)
        info.button[1] = guiCreateButton(407, 418, 103, 23, "Save", false, info_window)
        guiSetFont(info.button[1], "default-bold-small")
        guiSetProperty(info.button[1], "NormalTextColour", "FFAAAAAA")
        info.button[2] = guiCreateButton(299, 418, 103, 23, "Cancel", false, info_window)
        guiSetFont(info.button[2], "default-bold-small")
        guiSetProperty(info.button[2], "NormalTextColour", "FFAAAAAA")    
    end
)

addEvent("UGCgroups.openInfoWindow", true)
addEventHandler("UGCgroups.openInfoWindow", resourceRoot, function(name, info)
    local gui = guiGetVisible(info_window)
    guiSetVisible(info_window, true)
    guiSetText(info_edit, info)
    guiSetText(info_window, name .. " - Group Information")
    guiBringToFront(info_window)
end)

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if btn == "left" and source == info.button[2] then
        guiSetVisible(info_window, false)
    end
end)

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if btn == "left" and source == info.button[1] then
        local info = guiGetText(info_edit)
        triggerServerEvent("UGCgroups.updateGroupInfo", resourceRoot, info)
        guiSetVisible(info_window, false)
    end
end)