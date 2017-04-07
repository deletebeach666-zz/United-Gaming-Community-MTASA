--[[ 
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 20 March 2017
-- Script: UGCgroups/window.lua
-- Type: Client Sided
]]--

local month = {
    [1] = "January",
    [2] = "February",
    [3] = "March",
    [4] = "April",
    [5] = "May",
    [6] = "June",
    [7] = "July",
    [8] = "Auguest",
    [9] = "September",
    [10] = "Novenber",
    [11] = "December",
}

Group = {
    tab = {},
    tabpanel = {},
    label = {},
    gridlist = {},
    window = {},
    button = {},
    memo = {}
}

local permissions = {} -- Buttons that require permissions

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        Group.window[1] = guiCreateWindow(413, 78, 579, 370, "United Gaming Community - Group System", false)
        guiWindowSetSizable(Group.window[1], false)
        exports.UGCutils:centerWindow(Group.window[1])
        guiSetVisible(Group.window[1], false)

        Group.tabpanel[1] = guiCreateTabPanel(9, 20, 562, 343, false, Group.window[1])

        Group.tab[1] = guiCreateTab("Info", Group.tabpanel[1])

        Group.label[1] = guiCreateLabel(8, 9, 76, 17, "Group Name:", false, Group.tab[1])
        guiSetFont(Group.label[1], "default-bold-small")
        Group.label[2] = guiCreateLabel(8, 31, 82, 15, "Creation Date:", false, Group.tab[1])
        guiSetFont(Group.label[2], "default-bold-small")
        Group.label[3] = guiCreateLabel(8, 52, 108, 15, "Group Information", false, Group.tab[1])
        guiSetFont(Group.label[3], "default-bold-small")
        Group.memo[1] = guiCreateMemo(6, 68, 550, 240, "", false, Group.tab[1])
        guiMemoSetReadOnly(Group.memo[1], true)
        Group.label[4] = guiCreateLabel(84, 10, 468, 16, "( ͡° ͜ʖ ͡°)", false, Group.tab[1])
        Group.label[5] = guiCreateLabel(94, 31, 169, 15, "10 May 2017", false, Group.tab[1])

        Group.tab[2] = guiCreateTab("Members", Group.tabpanel[1])

        Group.gridlist[1] = guiCreateGridList(4, 20, 552, 271, false, Group.tab[2])
        guiGridListSetSortingEnabled(Group.gridlist[1], false)
        col_name = guiGridListAddColumn(Group.gridlist[1], "Player", 0.350)
        col_accname = guiGridListAddColumn(Group.gridlist[1], "Account Name", 0.2)
        --col_rank = guiGridListAddColumn(Group.gridlist[1], "Rank", 0.15)
        col_warn = guiGridListAddColumn(Group.gridlist[1], "Warn", 0.1)
        col_joined = guiGridListAddColumn(Group.gridlist[1], "Joined", 0.4)
        Group.label[6] = guiCreateLabel(10, 2.5, 60, 15, "Members", false, Group.tab[2])
        guiSetFont(Group.label[6], "default-bold-small")
        permissions[3] = guiCreateButton(4, 291, 138, 19, "Warn Player", false, Group.tab[2])
        guiSetFont(permissions[3], "default-small")
        guiSetProperty(permissions[3], "NormalTextColour", "FFAAAAAA")
        permissions[8] = guiCreateButton(142, 291, 140, 19, "Change Rank", false, Group.tab[2])
        guiSetFont(permissions[8], "default-small")
        guiSetProperty(permissions[8], "NormalTextColour", "FFAAAAAA")
        permissions[2] = guiCreateButton(282, 291, 140, 19, "Kick Player", false, Group.tab[2])
        guiSetFont(permissions[2], "default-small")
        guiSetProperty(permissions[2], "NormalTextColour", "FFAAAAAA")
        permissions[1] = guiCreateButton(422, 291, 134, 19, "Invite Player", false, Group.tab[2])
        guiSetFont(permissions[1], "default-small")
        guiSetProperty(permissions[1], "NormalTextColour", "FFAAAAAA")
        Group.button[9] = guiCreateButton(448, 4, 108, 27, "Leave Group", false, Group.tab[1])
        guiSetFont(Group.button[9], "default-bold-small")
        guiSetProperty(Group.button[9], "NormalTextColour", "FFAAAAAA")

        Group.tab[3] = guiCreateTab("Administration", Group.tabpanel[1])

        permissions[4] = guiCreateButton(7, 5, 118, 30, "Group Color", false, Group.tab[3])
        guiSetFont(permissions[4], "default-bold-small")
        guiSetProperty(permissions[4], "NormalTextColour", "FFAAAAAA")
        Group.label[7] = guiCreateLabel(135, 3, 432, 32, "Change your group color anywhere, anytime! Click on \"Group Color\" and set group color RGB", false, Group.tab[3])
        guiSetFont(Group.label[7], "clear-normal")
        guiLabelSetHorizontalAlign(Group.label[7], "left", true)
        permissions[5] = guiCreateButton(6, 47, 118, 30, "Group Ranks", false, Group.tab[3])
        guiSetFont(permissions[5], "default-bold-small")
        guiSetProperty(permissions[5], "NormalTextColour", "FFAAAAAA")
        Group.label[8] = guiCreateLabel(135, 45, 432, 32, "Setup your group ranks by yourself! You can create custom rank with custom permissions aswell!", false, Group.tab[3])
        guiSetFont(Group.label[8], "clear-normal")
        guiLabelSetHorizontalAlign(Group.label[8], "left", true)
        permissions[6] = guiCreateButton(6, 92, 118, 30, "Group Info", false, Group.tab[3])
        guiSetFont(permissions[6], "default-bold-small")
        guiSetProperty(permissions[6], "NormalTextColour", "FFAAAAAA")
        Group.label[9] = guiCreateLabel(135, 90, 432, 32, "Edit your group information and add important things such as rules, etc", false, Group.tab[3])
        guiSetFont(Group.label[9], "clear-normal")
        guiLabelSetHorizontalAlign(Group.label[9], "left", true)
        permissions[7] = guiCreateButton(6, 136, 118, 30, "Group Name", false, Group.tab[3])
        guiSetFont(permissions[7], "default-bold-small")
        guiSetProperty(permissions[7], "NormalTextColour", "FFAAAAAA")
        Group.label[10] = guiCreateLabel(134, 134, 432, 32, "Have to change group name? Click on Group Name Button to change your group name!", false, Group.tab[3])
        guiSetFont(Group.label[10], "clear-normal")
        guiLabelSetHorizontalAlign(Group.label[10], "left", true)    
        Group.label[11] = guiCreateLabel(134, 176, 432, 32, "Group History Logs has all information about groups from the day group was created.", false, Group.tab[3])
        guiSetFont(Group.label[11], "clear-normal")
        guiLabelSetHorizontalAlign(Group.label[11], "left", true)
        Group.button[10] = guiCreateButton(6, 178, 118, 30, "Group History", false, Group.tab[3])
        guiSetFont(Group.button[10], "default-bold-small")
        guiSetProperty(Group.button[10], "NormalTextColour", "FFAAAAAA")   
        Group.label[12] = guiCreateLabel(134, 176+42, 432, 32, "Only Group Founders have this option to delete their groups. No one else can.", false, Group.tab[3])
        guiSetFont(Group.label[12], "clear-normal")
        guiLabelSetHorizontalAlign(Group.label[12], "left", true)
        Group.button[11] = guiCreateButton(6, 178+42, 118, 30, "Delete Group", false, Group.tab[3])
        guiSetFont(Group.button[11], "default-bold-small")
        guiSetProperty(Group.button[11], "NormalTextColour", "FFAAAAAA")

        Group.tab[4] = guiCreateTab("Group List", Group.tabpanel[1])

        Group.gridlist[2] = guiCreateGridList(4, 5, 553, 307, false, Group.tab[4])
        gl_groupname = guiGridListAddColumn(Group.gridlist[2], "Group Name", 0.3)
        gl_groupfounder = guiGridListAddColumn(Group.gridlist[2], "Founder", 0.3)
        gl_groupmembers = guiGridListAddColumn(Group.gridlist[2], "Members", 0.3)
    end
)

CGroup = {
    staticimage = {},
    edit = {},
    button = {},
    window = {},
    label = {},
    gridlist = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        CGroup.window[1] = guiCreateWindow(408, 228, 459, 177, "United Gaming Community - Groups", false)
        guiWindowSetSizable(CGroup.window[1], false)
        exports.UGCutils:centerWindow(CGroup.window[1])
        guiSetVisible(CGroup.window[1], false)

        CGroup.gridlist[1] = guiCreateGridList(14, 44, 193, 100, false, CGroup.window[1])
        gi_name = guiGridListAddColumn(CGroup.gridlist[1], "Group Name", 0.9)
        CGroup.label[1] = guiCreateLabel(14, 23, 98, 15, "Group Invitations", false, CGroup.window[1])
        guiSetFont(CGroup.label[1], "default-bold-small")
        CGroup.staticimage[1] = guiCreateStaticImage(213, 23, 4, 153, ":guieditor/images/dot_white.png", false, CGroup.window[1])
        guiSetProperty(CGroup.staticimage[1], "ImageColours", "tl:74070606 tr:74070606 bl:74070606 br:74070606")
        CGroup.label[2] = guiCreateLabel(223, 23, 98, 15, "Create Group", false, CGroup.window[1])
        guiSetFont(CGroup.label[2], "default-bold-small")
        CGroup.edit[1] = guiCreateEdit(222, 119, 230, 25, "", false, CGroup.window[1])
        CGroup.label[3] = guiCreateLabel(223, 46, 235, 48, "You can create your own group by submitting this form. Group Creation is absolutely free!", false, CGroup.window[1])
        guiSetFont(CGroup.label[3], "clear-normal")
        guiLabelSetHorizontalAlign(CGroup.label[3], "left", true)
        CGroup.label[4] = guiCreateLabel(223, 104, 98, 15, "Group Name", false, CGroup.window[1])
        guiSetFont(CGroup.label[4], "default-bold-small")
        CGroup.button[1] = guiCreateButton(222, 148, 229, 24, "Create Group", false, CGroup.window[1])
        guiSetFont(CGroup.button[1], "default-bold-small")
        guiSetProperty(CGroup.button[1], "NormalTextColour", "FFAAAAAA")
        CGroup.button[2] = guiCreateButton(14, 147, 98, 19, "Reject", false, CGroup.window[1])
        guiSetFont(CGroup.button[2], "default-bold-small")
        guiSetProperty(CGroup.button[2], "NormalTextColour", "FFAAAAAA")
        CGroup.button[3] = guiCreateButton(112, 147, 95, 19, "Accept", false, CGroup.window[1])
        guiSetFont(CGroup.button[3], "default-bold-small")
        guiSetProperty(CGroup.button[3], "NormalTextColour", "FFAAAAAA")    

        for _, v in ipairs(permissions) do
        	guiSetEnabled(v, false)
        end
        -- Founder only buttons
        	guiSetEnabled(Group.button[11], false)
    end
)

addEvent("UGCgroups.toggleVisibleNGP", true)
addEventHandler("UGCgroups.toggleVisibleNGP", resourceRoot, function(invites)
    local isShown = guiGetVisible(CGroup.window[1])
    if isShown then
        guiSetVisible(CGroup.window[1], false)
        showCursor(false)
    else
        guiSetVisible(CGroup.window[1], true)
        showCursor(true)
        guiGridListClear(CGroup.gridlist[1])
        for _, v in ipairs(invites) do
            local row = guiGridListAddRow(CGroup.gridlist[1])
            guiGridListSetItemText(CGroup.gridlist[1], row, gi_name, v, false, false)
        end
    end
end)


addEvent("UGCgroups.toggleVisible", true)
addEventHandler("UGCgroups.toggleVisible", resourceRoot, function(json, members, u2n, perms, isOwner, groupList)
    local isShown = guiGetVisible(Group.window[1])
    if isShown then
        guiSetVisible(Group.window[1], false)
        showCursor(false)
    else
        local tbl = fromJSON(json)
        local perm = fromJSON(perms)
        for k, v in pairs(perm) do
        	guiSetEnabled(permissions[k], v)
        end
        guiSetEnabled(Group.button[11], false)
        if localPlayer == isOwner then
        	guiSetEnabled(Group.button[11], true)
        	guiSetEnabled(Group.button[9], false)
        end
        guiSetVisible(Group.window[1], true)
        showCursor(true)
        guiSetText(Group.window[1], "Group: " .. tbl["name"])
        guiSetText(Group.label[4], tbl["name"])
        guiSetText(Group.label[5], getRealTime(tbl["creation"]).monthday .. " " .. month[getRealTime(tbl["creation"]).month] .. " 20" .. string.sub(getRealTime(tbl["creation"]).year, -2))
        guiSetText(Group.memo[1], tbl["info"])
        guiGridListClear(Group.gridlist[1])
        for k, v in pairs(members) do
                local row = guiGridListAddRow(Group.gridlist[1])
                guiGridListSetItemText(Group.gridlist[1], row, col_name, v[1][4], true, false)
            for _, v in ipairs(v) do
                local row = guiGridListAddRow(Group.gridlist[1])
                if u2n[v[1]] == nil then 
                    guiGridListSetItemText(Group.gridlist[1], row, col_name, v[1], false, false)
                    guiGridListSetItemColor(Group.gridlist[1], row, col_name, 255, 0, 0)
                else
                    guiGridListSetItemText(Group.gridlist[1], row, col_name, u2n[v[1]], false, false)
                    guiGridListSetItemColor(Group.gridlist[1], row, col_name, 0, 255, 0)
                end
                guiGridListSetItemText(Group.gridlist[1], row, col_accname, v[1], false, false)
                --guiGridListSetItemText(Group.gridlist[1], row, col_rank, v[4], false, false)
                guiGridListSetItemText(Group.gridlist[1], row, col_joined, getRealTime(v[2]).monthday .. " " .. month[getRealTime(v[2]).month] .. " 20" .. string.sub(getRealTime(v[2]).year, -2), false, false)
                guiGridListSetItemText(Group.gridlist[1], row, col_warn, v[3] .. "%", false, false)
            end
        end
        -- Group List
        guiGridListClear(Group.gridlist[2])
        for _, v in ipairs(groupList) do
        	local row = guiGridListAddRow(Group.gridlist[2])
        	guiGridListSetItemText(Group.gridlist[2], row, gl_groupname, v[1], false, false)
        	guiGridListSetItemText(Group.gridlist[2], row, gl_groupfounder, v[2], false, false)
        	guiGridListSetItemText(Group.gridlist[2], row, gl_groupmembers, v[3], false, false)
        end
    end
end)

addEvent("UGCgroups.closeCreationWindow", true)
addEventHandler("UGCgroups.closeCreationWindow", resourceRoot, function()
    guiSetVisible(CGroup.window[1], false)
    showCursor(false)
end)

function getGroupCreatorName()
    return guiGetText(CGroup.edit[1])
end

-- Disable Buttons
function setEnabled(id, bool)
    guiSetEnabled(Group.button[id], bool)
end

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if btn == "left" and source == CGroup.button[1] then
        local name = getGroupCreatorName()
        triggerServerEvent("UGCgroups.createGroup", resourceRoot, name)
    end
end)

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if btn == "left" and source == permissions[5] then
        triggerServerEvent("UGCgroups.openRanksWindow", resourceRoot)
    end
end)    

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if btn == "left" and source == permissions[4] then
        exports.cpicker:openPicker(localPlayer, "#FFAAAAAA", "Select Color")   
        setElementData(localPlayer, "UGCgroups.editingRGB", true) 
    end
end)    

-- Refresh Members
------------------>
function refreshGroupMembers()
    triggerServerEvent("UGCgroups.refreshMembers", resourceRoot)
end

addEvent("UGCgroups.refreshMembers", true)
addEventHandler("UGCgroups.refreshMembers", resourceRoot, function(members, u2n)
    guiGridListClear(Group.gridlist[1])
    for k, v in pairs(members) do
                local row = guiGridListAddRow(Group.gridlist[1])
                guiGridListSetItemText(Group.gridlist[1], row, col_name, v[1][4], true, false)
            for _, v in ipairs(v) do
                local row = guiGridListAddRow(Group.gridlist[1])
                if u2n[v[1]] == nil then 
                    guiGridListSetItemText(Group.gridlist[1], row, col_name, v[1], false, false)
                    guiGridListSetItemColor(Group.gridlist[1], row, col_name, 255, 0, 0)
                else
                    guiGridListSetItemText(Group.gridlist[1], row, col_name, u2n[v[1]], false, false)
                    guiGridListSetItemColor(Group.gridlist[1], row, col_name, 0, 255, 0)
                end
                guiGridListSetItemText(Group.gridlist[1], row, col_accname, v[1], false, false)
                --guiGridListSetItemText(Group.gridlist[1], row, col_rank, v[4], false, false)
                guiGridListSetItemText(Group.gridlist[1], row, col_joined, getRealTime(v[2]).monthday .. " " .. month[getRealTime(v[2]).month] .. " 20" .. string.sub(getRealTime(v[2]).year, -2), false, false)
                guiGridListSetItemText(Group.gridlist[1], row, col_warn, v[3] .. "%", false, false)
            end
        end
end)

-- Group Info
-------------->
addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if btn == "left" and source == permissions[6] then
        triggerServerEvent("UGCgroups.openInfoWindow", resourceRoot)
    end
end)

addEvent("UGCgroups.refreshGroupInfo", true)
addEventHandler("UGCgroups.refreshGroupInfo", resourceRoot, function(info)
    guiSetText(Group.memo[1], info)
end)

-- Group History
---------------->
addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if btn == "left" and source == Group.button[10] then
        triggerServerEvent("UGCgroups.openHistoryWindow", resourceRoot)
    end
end)

-- Warn Member
-------------->
addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if btn == "left" and source == permissions[3] then
        local playerName = guiGridListGetItemText(Group.gridlist[1], guiGridListGetSelectedItem(Group.gridlist[1]), 2)
        if playerName == "" or playerName == nil then return exports.UGCnoty:sendNotification("You need to select a player to take any action!", 255, 0, 0) end
        triggerServerEvent("UGCgroups.openWarnWindow", resourceRoot, playerName)
    end
end)


-- Accept Group Invite
---------------------->
addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if btn == "left" and source == CGroup.button[3] then
        local groupName = guiGridListGetItemText(CGroup.gridlist[1], guiGridListGetSelectedItem(CGroup.gridlist[1]), 1)
        if groupName == "" or groupName == nil then return exports.UGCnoty:sendNotification("You need to select an invitation to accept", 255, 0, 0) end
        triggerServerEvent("UGCgroups.acceptInvite", resourceRoot, groupName)
    end
end)

function getPlayerBlip(player) 
    local attached = getAttachedElements ( player ) 
    if ( attached ) then 
        for k,element in ipairs(attached) do 
            if getElementType ( element ) == "blip" then 
                return element
            end 
            break
        end 
    end 
end 

function getOnlinePlayersFromGroup(group)
    local members = {}
    for _, v in ipairs(getElementsByType("player")) do
        if getElementData(v, "Group") == group then
            local blip = getPlayerBlip(v)
            setElementData(blip, "UGCgroups:showPlayerBlips", true)
        end
    end
    return members
end

getOnlinePlayersFromGroup("Military Forces")