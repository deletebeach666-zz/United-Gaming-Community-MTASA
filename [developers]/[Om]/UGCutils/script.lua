---------------------->
-- Project: UGCRPG
-- Author: Om (RipeMangoes69)
-- Data: 10 March 2017
-- Description: Utility Resources.
------------------------->

function toclock(seconds)
  local seconds = tonumber(seconds)

  if seconds <= 0 then
    return "00:00:00";
  else
    hours = string.format("%02.f", math.floor(seconds/3600));
    mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
    secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
    return hours..":"..mins..":"..secs
  end
end

function striphex(text)
    if not type(text) == "string" then return false end
    repeat text = text:gsub("#%x%x%x%x%x%x", "") until not text:find("#%x%x%x%x%x%x")
    return text
end

function tohex(red, green, blue, alpha)
	if((red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255) or (alpha and (alpha < 0 or alpha > 255))) then
		return nil
	end
	if(alpha) then
		return string.format("#%.2X%.2X%.2X%.2X", red,green,blue,alpha)
	else
		return string.format("#%.2X%.2X%.2X", red,green,blue)
	end
end

function torgb(hex)
    hex = hex:gsub("#","")
    return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end

function formatNumber( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end

-- Disable HEX Code in-Game
function disableHexFromName(oldNick,newNick) 
    local name = getPlayerName(source) 
    if newNick then 
        name = newNick 
    end 
    if (string.find(name,"#%x%x%x%x%x%x")) then 
        local name = string.gsub(name,"#%x%x%x%x%x%x","") 
		cancelEvent()
        setPlayerName(source,name) 
        if (newNick) then 
        cancelEvent() 
        end 
    end  
end 
addEventHandler("onPlayerJoin", getRootElement(), disableHexFromName) 
addEventHandler("onPlayerChangeNick", getRootElement(), disableHexFromName) 

function formatMoney( n )
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

function getPlayerFromPartialName(name)
    local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
    if name then
        for _, player in ipairs(getElementsByType("player")) do
            local name_ = getPlayerName(player):gsub("#%x%x%x%x%x%x", ""):lower()
            if name_:find(name, 1, true) then
                return player
            end
        end
    end
end

function tocomma( n )
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

