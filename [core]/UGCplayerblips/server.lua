----------------------------------------------------------------------
--  Script Author: Swagy                                            --
--  Copyrights@Unitec Gaming Community 2017                         --
--  Description: Basic Housing System                               --
--  forum.curtcreation.net                                          --
----------------------------------------------------------------------

local blips = {}


function createPlayerBlip (p)

	if not (blips[p]) then
		blips[p] = createBlipAttachedTo(p, 0)
		local r,g,b = getPlayerNametagColor(p)
		setBlipColor(blips[p], r,g,b, 255)

	else
		destroyElement(blips[p])
		blips[p] = nil
	end
end

addEventHandler("onPlayerLogin", root, 
function ()
	createPlayerBlip(source)
end
)

addEventHandler("onPlayerQuit", root, function ()

	if (blips[source]) then
		destroyElement(blips[source])
		blips[source] = nil
	end
end
)

function updatePlayerBlips ()

	for k,v in ipairs (getElementsByType"player") do 
		if (blips[v]) then
			local r,g,b = getPlayerNametagColor(v)
			setBlipColor(blips[v], r,g,b, 255)
		else
			createPlayerBlip(v)
		end
	end
end
setTimer(updatePlayerBlips, 1750, 0)			