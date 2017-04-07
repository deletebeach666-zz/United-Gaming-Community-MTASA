--[[ 
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 19 March 2017
-- Script: UGCupdates/client.lua
-- Type: Client Sided
]]--

GUIEditor = {
    button = {},
    window = {},
    staticimage = {},
    memo = {}
}

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        GUIEditor.window[1] = guiCreateWindow(397, 139, 566, 453, "United Gaming Community - Updates", false)
        guiWindowSetSizable(GUIEditor.window[1], false)
        exports.UGCutils:centerWindow(GUIEditor.window[1])
        guiSetVisible(GUIEditor.window[1], false)

        GUIEditor.staticimage[1] = guiCreateStaticImage(102, 24, 373, 160, ":UGCupdates/img/logo.png", false, GUIEditor.window[1])
        GUIEditor.memo[1] = guiCreateMemo(9, 184, 549, 239, "", false, GUIEditor.window[1])
        guiMemoSetReadOnly(GUIEditor.memo[1], true)
        GUIEditor.button[1] = guiCreateButton(495, 426, 62, 17, "Close", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.button[1], "default-small")
        guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFAAAAAA")    
    end
)

addEvent("UGCupdates.toggleWindow", true)
addEventHandler("UGCupdates.toggleWindow", resourceRoot, function(updates)
    local vis = guiGetVisible(GUIEditor.window[1])
    if vis then
        guiSetVisible(GUIEditor.window[1], false)
        showCursor(false)
    else
        guiSetVisible(GUIEditor.window[1], true)
        showCursor(true)
        guiSetText(GUIEditor.memo[1], updates)
    end
end)

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if btn == "left" and source == GUIEditor.button[1] then
        guiSetVisible(GUIEditor.window[1], false)
        showCursor(false)
    end
end)