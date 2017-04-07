local skills = {69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79}

--[[69: WEAPONTYPE_PISTOL_SKILL
70: WEAPONTYPE_PISTOL_SILENCED_SKILL
71: WEAPONTYPE_DESERT_EAGLE_SKILL
72: WEAPONTYPE_SHOTGUN_SKILL
73: WEAPONTYPE_SAWNOFF_SHOTGUN_SKILL
74: WEAPONTYPE_SPAS12_SHOTGUN_SKILL
75: WEAPONTYPE_MICRO_UZI_SKILL
76: WEAPONTYPE_MP5_SKILL
77: WEAPONTYPE_AK47_SKILL
78: WEAPONTYPE_M4_SKILL
79: WEAPONTYPE_SNIPERRIFLE_SKILL
]]

function respawnDeadPlayer ( hx, hy, hz, rotation, mx, my, mz, lx, ly, lz, hospitalName )
	fadeCamera(source, false, 1.0, 0, 0, 0)
	setTimer(setCameraMatrix, 1000, 1, source, mx, my, mz, lx, ly, lz)
	setTimer(fadeCamera, 2000, 1, source, true, 1.0, 0, 0, 0)
	setTimer(respawnPlayer, 5000, 1, source, hx, hy, hz, rotation)
	exports.UGCnoty:sendNotification("You respawned at: "..hospitalName, source, 225, 225, 225)
	for k, v in ipairs(skills) do
		setPedStat(source, v, 1000)
	end
end
addEvent("respawnDeadPlayer", true)
addEventHandler ("respawnDeadPlayer", root, respawnDeadPlayer)

function respawnPlayer(thePlayer, hx, hy, hz, rotation)
	if (isElement(thePlayer)) then
		fadeCamera(thePlayer, true)
		setCameraTarget(thePlayer, thePlayer)
		spawnPlayer(thePlayer, hx + math.random(0.1, 2), hy + math.random(0.1, 2), hz, rotation, getElementModel(thePlayer), 0, 0)
	end
end
