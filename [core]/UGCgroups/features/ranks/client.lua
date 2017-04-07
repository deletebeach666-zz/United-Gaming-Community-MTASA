--[[ 
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 20 March 2017
-- Script: UGCgroups/tabs/ranks/client.lua
-- Type: Client Sided
]]--


Rank = {
    checkbox = {},
    edit = {},
    button = {},
    window = {},
    label = {},
    gridlist = {},
    staticimage = {}
}

local perm = {}

local restricted = {
    ["Founder"] = true,
    ["Members"] = true,
}


addEventHandler("onClientResourceStart", resourceRoot,
    function()
        Rank.window[1] = guiCreateWindow(591, 229, 197, 296, "Ranks", false)
        guiWindowSetSizable(Rank.window[1], false)

        Rank.gridlist[1] = guiCreateGridList(9, 25, 178, 235, false, Rank.window[1])
        rank_name = guiGridListAddColumn(Rank.gridlist[1], "Names", 0.9)
        Rank.button[1] = guiCreateButton(100, 265, 87, 24, "Create", false, Rank.window[1])
        guiSetFont(Rank.button[1], "default-bold-small")
        guiSetProperty(Rank.button[1], "NormalTextColour", "FFAAAAAA")
        Rank.button[2] = guiCreateButton(9, 265, 91, 24, "Close", false, Rank.window[1])
        guiSetFont(Rank.button[2], "default-bold-small")
        guiSetProperty(Rank.button[2], "NormalTextColour", "FFAAAAAA")


        Rank.window[2] = guiCreateWindow(326, 229, 223, 248, "Rank Permissions", false)
        guiWindowSetSizable(Rank.window[2], false)

        perm[1] = guiCreateCheckBox(9, 51, 191, 15, "Invite other Players", false, false, Rank.window[2])
        perm[2] = guiCreateCheckBox(9, 71, 191, 15, "Kick other members", false, false, Rank.window[2])
        perm[3] = guiCreateCheckBox(9, 91, 191, 15, "Warn group members", false, false, Rank.window[2])
        perm[4] = guiCreateCheckBox(9, 111, 191, 15, "Change group color", false, false, Rank.window[2])
        perm[5] = guiCreateCheckBox(9, 131, 191, 15, "Change/Edit/Add Group Ranks", false, false, Rank.window[2])
        perm[6] = guiCreateCheckBox(9, 151, 191, 15, "Change Group Information", false, false, Rank.window[2])
        perm[7] = guiCreateCheckBox(9, 172, 191, 15, "Change Group Name", false, false, Rank.window[2])
        perm[8] = guiCreateCheckBox(9, 193, 191, 15, "Promote/Demote Players", false, false, Rank.window[2])
        Rank.button[3] = guiCreateButton(9, 215, 104, 23, "Cancel", false, Rank.window[2])
        guiSetFont(Rank.button[3], "default-bold-small")
        guiSetProperty(Rank.button[3], "NormalTextColour", "FFAAAAAA")
        Rank.button[4] = guiCreateButton(113, 215, 116, 23, "Save", false, Rank.window[2])
        guiSetFont(Rank.button[4], "default-bold-small")
        guiSetProperty(Rank.button[4], "NormalTextColour", "FFAAAAAA")
        Rank.label[1] = guiCreateLabel(10, 26, 68, 15, "Rank Name:", false, Rank.window[2])
        guiSetFont(Rank.label[1], "default-bold-small")
        Rank.label[2] = guiCreateLabel(84, 26, 133, 15, "Founder Of Lenny", false, Rank.window[2])
        Rank.staticimage[1] = guiCreateStaticImage(113, 0, 16, 15, ":guieditor/images/cross.png", false, Rank.label[2])    


        Rank.window[3] = guiCreateWindow(808, 229, 244, 115, "Create Rank", false)
        guiWindowSetSizable(Rank.window[3], false)

        Rank.label[3] = guiCreateLabel(10, 26, 101, 15, "Create Rank", false, Rank.window[3])
        guiSetFont(Rank.label[3], "default-bold-small")
        Rank.edit[1] = guiCreateEdit(10, 44, 223, 31, "", false, Rank.window[3])
        Rank.button[5] = guiCreateButton(11, 80, 110, 24, "Cancel", false, Rank.window[3])
        guiSetFont(Rank.button[5], "default-bold-small")
        guiSetProperty(Rank.button[5], "NormalTextColour", "FFAAAAAA")
        Rank.button[6] = guiCreateButton(121, 80, 110, 24, "Create", false, Rank.window[3])
        guiSetFont(Rank.button[6], "default-bold-small")
        guiSetProperty(Rank.button[6], "NormalTextColour", "FFAAAAAA")  

        for _, v in ipairs(Rank.window) do
        	guiSetVisible(v, false)
        	exports.UGCutils:centerWindow(v)
        end  
    end
)

addEvent("UGCgroups.openRanksWindow", true)
addEventHandler("UGCgroups.openRanksWindow", resourceRoot, function(ranks)
     guiGridListClear(Rank.gridlist[1])
     for _, v in ipairs(ranks) do
        local row = guiGridListAddRow(Rank.gridlist[1])
        guiGridListSetItemText(Rank.gridlist[1], row, rank_name, v[1], false, false)
     end
     guiSetVisible(Rank.window[1], true)
     guiBringToFront(Rank.window[1])
end)

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if btn == "left" and source == Rank.button[2] then
        guiSetVisible(Rank.window[1], false)
    end
end)
addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if btn == "left" and source == Rank.button[2] then
        guiSetVisible(Rank.window[1], false)
    end
end)

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if btn == "left" and source == GUIEditor.button[1] then
        guiSetVisible(GUIEditor.window[1], false)
        guiSetVisible(Rank.window[2], true)
    end
end)


addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if btn == "left" and source == GUIEditor.button[2] then
        local rank = guiGetText(Rank.label[2]) -- Rank Name
        triggerServerEvent("UGCgroups.deleteRank", resourceRoot, rank)
        guiSetVisible(GUIEditor.window[1], false)
    end
end)

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if btn == "left" and source == Rank.staticimage[1] then
        guiSetVisible(Rank.window[2], false)
        guiSetVisible(GUIEditor.window[1], true)
        guiBringToFront(GUIEditor.window[1])
    end
end)


addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if btn == "left" and source == Rank.button[1] then
        guiSetVisible(Rank.window[1], false)
        guiSetVisible(Rank.window[3], true)
        guiBringToFront(Rank.window[3])
    end
end)

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if btn == "left" and source == Rank.button[6] then  
        local name = guiGetText(Rank.edit[1])
        if name == "" then return false end
        if restricted[name] then return exports.UGCnoty:sendNotification("You cannot use this group rank!", 255, 0, 0) end
        triggerServerEvent("UGCgroups.createRank", resourceRoot, name)
        guiSetVisible(Rank.window[3], false)
    end
end)


addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if btn == "left" and source == Rank.button[5] then  
        guiSetVisible(Rank.window[3], false)
    end
end)

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if btn == "left" and source == Rank.button[3] then  
        guiSetVisible(Rank.window[2], false)
    end
end)


addEventHandler("onClientGUIDoubleClick", resourceRoot, function(btn)
    if btn == "left" and source == Rank.gridlist[1] then
        local rank = guiGridListGetItemText(Rank.gridlist[1], guiGridListGetSelectedItem(Rank.gridlist[1]), 1)
        if rank == "" or rank == nil then return false end
        if restricted[rank] then return exports.UGCnoty:sendNotification("You cannot take action on this group!", 255, 0, 0) end
        guiSetVisible(Rank.window[1], false)
        triggerServerEvent("UGCgroups.openRankEditWindow", resourceRoot, rank)
    end
end)

addEvent("UGCgroups.openRankEditWindow", true)
addEventHandler("UGCgroups.openRankEditWindow", resourceRoot, function(perma, rankName)
    guiSetVisible(Rank.window[2], true)
    guiBringToFront(Rank.window[2])
    guiSetText(Rank.label[2], rankName)
    for k, v in pairs(perma) do
        guiCheckBoxSetSelected(perm[k], v)
    end
end)

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if btn == "left" and source == Rank.button[4] then
    local perm = {
        [1] = guiCheckBoxGetSelected(perm[1]), -- Ability to invite player to group
        [2] = guiCheckBoxGetSelected(perm[2]), -- Ability to kick player from group
        [3] = guiCheckBoxGetSelected(perm[3]), -- Ability to warn player
        [4] = guiCheckBoxGetSelected(perm[4]), -- Ability to change group color
        [5] = guiCheckBoxGetSelected(perm[5]), -- Ability to add/delete/edit ranks
        [6] = guiCheckBoxGetSelected(perm[6]), -- Ability to change group information
        [7] = guiCheckBoxGetSelected(perm[7]), -- Ability to change group name
        [8] = guiCheckBoxGetSelected(perm[8]), -- Ability to promote/demote players
    }
    local rank = guiGetText(Rank.label[2]) -- Rank Name
    triggerServerEvent("UGCgroups.updateRankPerm", resourceRoot, rank, perm)
    guiSetVisible(Rank.window[2], false)
    end
end)

-- Confirmation Window
----------------------->
GUIEditor = {
    button = {},
    window = {},
    staticimage = {},
    label = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        GUIEditor.window[1] = guiCreateWindow(512, 281, 330, 106, "Confirmation", false)
        guiWindowSetSizable(GUIEditor.window[1], false)
        guiSetVisible(GUIEditor.window[1], false)
        exports.UGCutils:centerWindow(GUIEditor.window[1])

        GUIEditor.staticimage[1] = guiCreateStaticImage(14, 27, 43, 46, ":admin/client/images/warning.png", false, GUIEditor.window[1])
        GUIEditor.label[1] = guiCreateLabel(57, 37, 265, 20, "Are you sure you want to delete this rank?", false, GUIEditor.window[1])
        GUIEditor.button[1] = guiCreateButton(127, 63, 90, 25, "Cancel", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFAAAAAA")
        GUIEditor.button[2] = guiCreateButton(232, 63, 89, 25, "Delete", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.button[2], "default-bold-small")
        guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFAAAAAA")    
    end
)
