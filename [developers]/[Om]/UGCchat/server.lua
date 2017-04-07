-------------------------------->
-- UGC: United Gaming Community
-- Author: Om Bhende (RipeMangoe69)
-- Date: 27 February 2017
-- Script: UGCchat/server.lua
-- Type: Server Sided
-------------------------------->

-- Events
addEvent("onPlayerMainChat", true)
addEvent("onPlayerTeamChat", true)


-- Useful Functions
function convertRGBToHex(rgbTable)
    local hexDec = ""
    for k, v in ipairs(rgbTable) do
        local hex = ''
        while (v > 0) do
        local index = math.fmod(v, 16) + 1
        v = math.floor(v / 16)
        hex = string.sub('0123456789ABCDEF', index, index) .. hex
    end
    if (string.len(hex) == 0) then
        hex = '00'
    elseif (string.len(hex) == 1) then
        hex = '0' .. hex
    end
    hexDec = hexDec .. hex
    end
    return hexDec
end

-- Actual Chat System
local tab =  { 
        ['Los Santos'] = 'LS', 
        ['Red County'] = 'LS',
        ['Flint County'] = 'LS',
        ['Las Venturas'] = 'LV',
        ['Bone County'] = 'LV',
        ['San Fierro'] = 'SF',
        ['Tierra Robada'] = 'SF',
        ['Whetstone'] = 'SF',
    } 

local zones = {
    ["LS"] = true,
    ["SF"] = true,
    ["LV"] = true,
    ["SA"] = true
}
      
function chatbox(text, msgtype) 
    if (msgtype == 0) then 
        local name = getPlayerName(source)
        local account = getPlayerAccount(source)
        if isGuestAccount(account) then return false end -- Disable Talking for Guest Users.
        local playerX, playerY, playerZ = getElementPosition(source)
        local playerZoneName = getZoneName(playerX, playerY, playerZ, true) 
        local playerZoneName = ( tab [ playerZoneName ] or "SA" ) 
        local team = getPlayerTeam ( source ) 
        local r, g, b = unpack( team and {getTeamColor(team)} or {getPlayerNametagColor(source)}) 
        local playerX, playerY, playerZ = getElementPosition(source) 
        local zoneName = getZoneName(playerX, playerY, playerZ, true) 
        local zoneName = (tab[ zoneName ] or "SA") 
            if (zoneName == playerZoneName) then 
                triggerEvent("onPlayerMainChat", source, exports.UGCutils:striphex(text), playerZoneName)
                outputChatBox ( "(".. playerZoneName ..") ".. name ..": #FFFFFF".. exports.UGCutils:striphex(text), getRootElement(), r, g, b, true) 
                exports.UGCirc:outputIRC("(".. playerZoneName ..") ".. name ..": ".. exports.UGCutils:striphex(text))
            end 
        cancelEvent() 
    end 
end 
addEventHandler ( "onPlayerChat", root, chatbox) 

function onPlayerChat(message, type)
cancelEvent()
local account = getPlayerAccount(source)
if not isGuestAccount(account) then
	if type == 2 then
			local r, g, b = getPlayerNametagColor(source)
			local team = getPlayerTeam(source)
			local tname = getTeamName(team)
			local tr, tg, tb = getTeamColor(team)
			local hex = convertRGBToHex({tr, tg, tb})
			for k, player in ipairs(getElementsByType("player")) do
			local isPlayersInTeam = getTeamName(getPlayerTeam(player))
				if (isPlayersInTeam == tname) then
					triggerEvent("onPlayerTeamChat", source, team, exports.UGCutils:striphex(message))
					outputChatBox("* #".. hex .. "(Team) " .. getPlayerName(source)..": #FFFFFF"..exports.UGCutils:striphex(message), player, 255, 255, 255, true)
				end
			end
		end
	end
end
addEventHandler("onPlayerChat", getRootElement(), onPlayerChat)


function outputMainChat(name, message, zone)
if name == nil then return false end -- Break function if name is nil.
if message == nil then return false end -- Break function if message if nil.
outputChatBox ( "("..zone or "N" .. ") ".. name ..": #FFFFFF".. message, getRootElement(), 128, 128, 128, true) 
end
addEvent("UGCchat.outputMainChat", true)
addEventHandler("UGCchat.outputMainChat", resourceRoot, outputMainChat)

function getPlayerZone(player)
    if player == nil then return false, "No Player Defined" end
    if getElementType(player) ~= "player" then return false, "Element is not player." end
    local x, y, z = getElementPosition(player)
    local zone = getZoneName(x, y, z, true)
    local zone = tab[zone]
    return zone
end
addEvent("UGCchat.getPlayerZone", true)
addEventHandler("UGCchat.getPlayerZone", resourceRoot, getPlayerZone)

function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

addEventHandler("onIRCMessage", root, function(chan, msg)
    local t = split(msg, "(%d)")
    if zones[t[1]] or string.match(msg, "**") or string.match(msg, "Total Players:") or string.match(msg, "_") or string.match(msg, "(Update)") then return end -- Disabled !players in-chat
    msg = string.gsub(msg, "08", "")
    msg = string.gsub(msg, "09", "")
    msg = string.gsub(msg, "<", "")
    outputChatBox("(Discord) " .. trim(msg), root, 255, 150, 0)
end)

addEventHandler("onIRCMessage", root, function(channel, msg)
    if string.match(msg, "!players") then
        if getPlayerCount() == 0 then
                exports.UGCirc:ircSay(channel,"There are no players ingame")
            else 
            local players = getElementsByType("player")
            for i,player in ipairs (players) do
            players[i] = getPlayerName(player)
            end
            exports.UGCirc:ircSay(channel,"**Total Players:** ".. getPlayerCount())
            exports.UGCirc:ircSay(channel, "_"..table.concat(players,", ").."_")
        end
    end
end)