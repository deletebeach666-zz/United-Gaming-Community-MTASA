---------------------->
-- Project: UGCRPG
-- Author: Om (RipeMangoes69)
-- Data: 13 March 2017
-- Description: Utility Resources. (Misc)
------------------------->

addEvent("UGCutils.typing", true)
addEventHandler("UGCutils.typing", resourceRoot, function(bool)
	if bool == true then
		setPlayerNametagText(client, getPlayerName(client) .. " (Typing)")
	else
		setPlayerNametagText(client, getPlayerName(client))
	end
end)

function generatePlate(player)
	local city = exports.UGCchat:getPlayerZone(player)
	return city .. 0 .. math.random(0, 9) .. math.random(1000, 9999)
end

