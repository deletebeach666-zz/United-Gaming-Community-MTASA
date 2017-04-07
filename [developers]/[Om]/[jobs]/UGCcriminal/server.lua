--[[ 
-- UGC: United Gaming Community
-- Author: Om (RipeMangoes69)
-- Date: 28 March 2017
-- Script: UGCcriminals/server.lua
-- Type: Server Sided
]]--

function goCriminal(thePlayer)
	local team = getPlayerTeam(thePlayer)
	if getTeamName(team) ~= "Criminals" then
		setPlayerTeam(thePlayer, getTeamFromName("Criminals"))
		outputChatBox("[Criminal] #FFFFFF You gained star because you're now criminal!", thePlayer, 255, 0, 0, true)
		setElementData(thePlayer, "Occupation", "Criminal")
		setElementModel(thePlayer, exports.UGCskins:getPlayerOwnedSkin(thePlayer))
	end
end
addCommandHandler("criminal", goCriminal)