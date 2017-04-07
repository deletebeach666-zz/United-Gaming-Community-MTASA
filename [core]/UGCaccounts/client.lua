-------------------------------->
-- UGC: United Gaming Community
-- Author: Om Bhende (RipeMangoe69)
-- Date: 25 February 2017
-- Script: UGCaccounts/client.lua
-- Type: Client Sided
-------------------------------->

local window = {}
local sx, sy = guiGetScreenSize()

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        window[1] = guiCreateLabel(788 / 1600 * sx, 274 / 900 * sy, 65 / 1600 * sx, 15 / 900 * sy, "Username:", false)
        guiSetFont(window[1], "default-bold-small")
        window[2] = guiCreateLabel(792 / 1600 * sx, 311 / 900 * sy, 65 / 1600 * sx, 15 / 900 * sy, "Password:", false)
        guiSetFont(window[2], "default-bold-small")
        window[3] = guiCreateLabel(788 / 1600 * sx, 235 / 900 * sy, 392 / 1600 * sx, 15 / 900 * sy, "You have to login to play!", false)
        guiSetFont(window[3], "default-bold-small")
        guiLabelSetHorizontalAlign(window[3], "center", false)
        window[4] = guiCreateLabel(798 / 1600 * sx, 384 / 900 * sy, 378 / 1600 * sx, 50 / 900 * sy, "Login", false)
        guiSetFont(window[4], "sa-header")
        guiLabelSetHorizontalAlign(window[4], "center", false)
        window[5] = guiCreateLabel(798 / 1600 * sx, 452 / 900 * sy, 378 / 1600 * sx, 50 / 900 * sy, "Register", false)
        guiSetFont(window[5], "sa-header")
        guiLabelSetHorizontalAlign(window[5], "center", false)
        window[6] = guiCreateLabel(798 / 1600 * sx, 522 / 900 * sy, 378 / 1600 * sx, 50 / 900 * sy, "Forgot", false)
        guiSetFont(window[6], "sa-header")
        guiLabelSetHorizontalAlign(window[6], "center", false)
        window[7] = guiCreateLabel(420 / 1600 * sx, 238 / 900 * sy, 53 / 1600 * sx, 17 / 900 * sy, "Updates:", false)
        guiSetFont(window[7], "default-bold-small")
        window[8] = guiCreateMemo(418 / 1600 * sx, 255 / 900 * sy, 350 / 1600 * sx, 330 / 900 * sy, "Fetching Updates..", false)
        guiMemoSetReadOnly(window[8], true)
        window[9] = guiCreateCheckBox(1065 / 1600 * sx, 342 / 900 * sy, (135/1600)*sx, (15/900)*sy, "Automatic Login", false, false)
        window[10] = guiCreateEdit(861 / 1600 * sx, 268 / 900 * sy, (277/1600)*sx, 27, "", false)
        window[11] = guiCreateEdit(861 / 1600 * sx, 305 / 900 * sy, (277/1600)*sx, 27, "", false)
        guiEditSetMasked(window[11], true) 

        -- Hide all login panel elements
        for _, element in ipairs(window) do
            guiSetVisible(element, false)
        end
end
)


function renderLoginWindow()
	local sx, sy = guiGetScreenSize()
    dxDrawRectangle((412/1600)*sx, (225/900)*sy, (785/1600)*sx, (375/900)*sy, tocolor(93, 84, 80, 156), false)
    dxDrawRectangle((798 / 1600) * sx, 384 / 900 * sy, (378/1600)*sx, (50/900)*sy, tocolor(53, 106, 25, 156), false)
    dxDrawRectangle((798 / 1600) * sx, 452 / 900 * sy, (378/1600)*sx, (50/900)*sy, tocolor(53, 106, 25, 156), false)
    dxDrawRectangle((798 / 1600) * sx, 522 / 900 * sy, (378/1600)*sx, (50/900)*sy, tocolor(53, 106, 25, 156), false)
end

local camera = {
    {1468.8785400391, -919.25317382813, 100.153465271, 1468.388671875, -918.42474365234, 99.881813049316}
}

function onPlayerJoin()
setCameraMatrix(camera[math.random(1, #camera)][1], camera[math.random(1, #camera)][2], camera[math.random(1, #camera)][3], camera[math.random(1, #camera)][4], camera[math.random(1, #camera)][5], camera[math.random(1, #camera)][6])
fadeCamera(true, 5)
addEventHandler("onClientRender", root, renderLoginWindow)
guiSetInputEnabled(false)
showChat(false)
showCursor(true)
triggerServerEvent("UGCaccounts.getUpdates", resourceRoot)
for _, element in ipairs(window) do
    guiSetVisible(element, true)
end
local fname = "credentials.txt"
local fz = fileExists(fname)
if fz then
    guiCheckBoxSetSelected(window[9], true)
    local file = fileOpen(fname, true)
    local buffer = fileRead(file, 500) 
    local rm = fromJSON(buffer)
    for k, v in ipairs(rm) do 
       if v[3] == getPlayerSerial(localPlayer) then
            guiSetText(window[10], v[1])
            guiSetText(window[11], v[2])
            triggerServerEvent("UGCaccounts.loginPlayer", resourceRoot, localPlayer, v[1], v[2], rememberMe)
       end
    end
    fileClose(file)
end
end
addEventHandler("onClientResourceStart", resourceRoot, onPlayerJoin)

function OnClientGUIClick(btn)
    -- Login
    if source == window[4] then
        if btn == "left" then
            local username = guiGetText(window[10])
            local password = guiGetText(window[11])
            local rememberMe = guiCheckBoxGetSelected(window[9])
            if string.len(username) < 2 then
                setWarning("Username must be atleast 2 characters!", 255, 0, 0)
            elseif string.len(password) < 6 then
                setWarning("Password must be atleast 6 characters!", 255, 0, 0)
            else
                setWarning("Authenticating..")
                triggerServerEvent("UGCaccounts.loginPlayer", resourceRoot, localPlayer, username, password, rememberMe)
            end
        end
    end

    -- Register
    if source == window[5] then
        if btn == "left" then
            local username = guiGetText(window[10])
            local password = guiGetText(window[11])
            if string.len(username) < 2 then
                setWarning("Username must be atleast 2 characters!", 255, 0, 0)
            elseif string.len(password) < 6 then
                setWarning("Password must be atleast 6 characters!", 255, 0, 0)
            else
                setWarning("Creating an account..")
                triggerServerEvent("UGCaccounts.createAccount", resourceRoot, localPlayer, username, password)
            end
        end
    end
end
addEventHandler("onClientGUIClick", resourceRoot, OnClientGUIClick)


-- Set Warning Text
--------------------->
function setWarning(text, r, g, b)
guiSetText(window[3], text)
guiLabelSetColor(window[3], r or 255, g or 255, b or 255)
end
addEvent("UGCaccounts.setWindowWarning", true)
addEventHandler("UGCaccounts.setWindowWarning", resourceRoot, setWarning)

-- Successful Login
--------------------->
function afterLogin(rememberMe, user, pass)
    local tbl = {}
    removeEventHandler("onClientRender", root, renderLoginWindow)
    for _, element in ipairs(window) do
        guiSetVisible(element, false)
    end
    guiSetInputEnabled(true)
    showChat(true)
    showCursor(false)
    setCameraTarget(localPlayer, localPlayer)
    if rememberMe == true then
        local file = fileExists("credentials.txt")
        if file then
            local fz = fileOpen("credentials.txt")
            table.insert(tbl, {user, pass, getPlayerSerial(localPlayer)})
            fileWrite(fz, toJSON(tbl))
            tbl = {}
            fileClose(fz)
        else
            local fz = fileCreate("credentials.txt")
            table.insert(tbl, {user, pass, getPlayerSerial(localPlayer)})
            fileWrite(fz, toJSON(tbl))
            tbl = {}
            fileClose(fz)
        end
    end
end
addEvent("UGCaccounts.successAuthed", true)
addEventHandler("UGCaccounts.successAuthed", resourceRoot, afterLogin)

-- Highlight Buttons
--------------------->
function OnClientMouseEnter()
    if source == window[4] then
        guiSetText(window[4], "> " .. guiGetText(window[4]))
        playSoundFrontEnd(3)
    end

    if source == window[5] then
        guiSetText(window[5], "> " .. guiGetText(window[5]))
        playSoundFrontEnd(3)
    end

    if source == window[6] then
        guiSetText(window[6], "> " .. guiGetText(window[6]))
        playSoundFrontEnd(3)
    end
end
addEventHandler("onClientMouseEnter", root, OnClientMouseEnter)


function OnClientMouseLeave()
    if source == window[4] then
        guiSetText(window[4], string.gsub(guiGetText(window[4]), "> ", ""))
    end

    if source == window[5] then
        guiSetText(window[5], string.gsub(guiGetText(window[5]), "> ", ""))
    end

    if source == window[6] then
        guiSetText(window[6], string.gsub(guiGetText(window[6]), "> ", ""))
    end
end
addEventHandler("onClientMouseLeave", root, OnClientMouseLeave)

function setUpdateLabel(update)
    if update == nil then return end
guiSetText(window[8], update)
end
addEvent("UGCaccounts.getUpdates", true)
addEventHandler("UGCaccounts.getUpdates", resourceRoot, setUpdateLabel)

-- Disable Auto Login
---------------------->

addCommandHandler("autologin", function(cmd, arg) 
if arg == "" or arg == nil then return outputChatBox("Syntax: #FFFFFF/autologin <on/off>", 255, 0, 0, true) end
if arg == "on" then return outputChatBox("[Auto Login] #FFFFFFThis command has been disabled, you can now turn on autologin from login panel!", 255, 0, 0, true) end
if arg == "off" then
local fz = fileExists("credentials.txt")
if fz == nil or fz == false then return outputChatBox("[Auto Login]#FFFFFF Auto Login is already disabled for your account!!", 255, 0, 0, true) end
outputChatBox("[Auto Login]#FFFFFF Auto Login has been disabled for your account!", 0, 255, 0, true)
fileDelete("credentials.txt")
else
outputChatBox("Syntax: #FFFFFF/autologin <on/off>", 255, 0, 0, true)
end
end)