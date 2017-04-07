------------------------------>
-- UGC: United Gaming Community
-- Author: Om Bhende (RipeMangoes69)
-- Date: 25 March 2017
-- Version: 1.0
-- File: UGCemployment/tables.lua
-- Type: Shared
------------------------------>
local ranks = {}
local info = {}

function pairsByKeys(t, f)
      local a = {}
      for n in pairs(t) do table.insert(a, n) end
      table.sort(a, f)
      local i = 0      -- iterator variable
      local iter = function ()   -- iterator function
        i = i + 1
        if a[i] == nil then return nil
        else return a[i], t[a[i]]
        end
      end
  return iter
end

-- Ranks Table
----------------->
ranks["Doctor"] = {
	[1] = {175000, "L1", "Medical Student"},
	[2] = {350000, "L2", "Nurse"},
	[3] = {525000, "L3", "Grunt"},
	[4] = {612500, "L4", "Junior Doctor"},
	[5] = {787500, "L5", "Doctor"},
	[6] = {962500, "L6", "Senior Doctor"},
	[7] = {1225000, "L7", "Section Head"},
	[8] = {1575000, "L8", "Medical Department Chief"},
	[9] = {2100000, "L9", "Chief of Medical Staff"},
	[10] = {2625000, "L10", "GodLike Doctor"}
}

ranks["Pilot"] = {
	[1] = {175000, "L1", "Probationer"},
	[2] = {350000, "L2", "Cabinet Pilot"},
	[3] = {525000, "L3", "First Officer"},
	[4] = {612500, "L4", "Captain"},
	[5] = {787500, "L5", "Senior Captain"},
	[6] = {962500, "L6", "Staff Pilot"},
	[7] = {1225000, "L7", "Pilot Executive"},
	[8] = {1575000, "L8", "Chief Pilot Executive"},
	[9] = {2100000, "L9", "Chief Pilot"},
	[10] = {2625000, "L10", "Specialist"}
}

ranks["Police Officer"] = {
	[1] = {20, "L1", "Cadet"},
	[2] = {60, "L2", "Police Constable"},
	[3] = {100, "L3", "Corporal"},
	[4] = {200, "L4", "Sergeant"},
	[5] = {350, "L5", "Staff Sergeant"},
	[6] = {475, "L6", "Staff Sergeant Major"},
	[7] = {600, "L7", "Sergeant Major"},
	[8] = {750, "L8", "Corps Sergeant Major"},
	[9] = {875, "L9", "Inspector"},
	[10] = {1000, "L10", "Superintendent"}
}

ranks["Bus Driver"] = {
	[1] = {45, "L1", "Trainee"},
	[2] = {80, "L2", "Trainee Conductor"},
	[3] = {140, "L3", "Conductor"},
	[4] = {200, "L4", "Trainee Driver"},
	[5] = {275, "L5", "Driver"},
	[6] = {340, "L6", "Chief of drivers"},
	[7] = {540, "L7", "Bus Employment Officer"},
	[8] = {875, "L8", "Major Driver"},
	[9] = {1024, "L9", "Bus Driver"},
	[10] = {2015, "L10", "Bus Owner"}
}

ranks["Pizza Boy"] = {
	[1] = {45, "L1", "Pizza Boy"},
	[2] = {80, "L2", "Pizza Boy"},
	[3] = {140, "L3", "Pizza Boy"},
	[4] = {200, "L4", "Pizza Boy"},
	[5] = {275, "L5", "Pizza Boy"},
	[6] = {340, "L6", "Pizza Boy"},
	[7] = {540, "L7", "Pizza Boy"},
	[8] = {875, "L8", "Pizza Boy"},
	[9] = {1024, "L9", "Pizza Boy"},
	[10] = {2015, "L10", "Pizza Boy"}
}

ranks["Mechanic"] = {
	[1] = {45, "L1", "Mechanic"},
	[2] = {80, "L2", "Mechanic"},
	[3] = {140, "L3", "Mechanic"},
	[4] = {200, "L4", "Mechanic"},
	[5] = {275, "L5", "Mechanic"},
	[6] = {340, "L6", "Mechanic"},
	[7] = {540, "L7", "Mechanic"},
	[8] = {875, "L8", "Mechanic"},
	[9] = {1024, "L9", "Mechanic"},
	[10] = {2015, "L10", "Mechanic"}
}

-- Info Table
-------------->

-- Doctor
local doctor = ""
for k, v in pairsByKeys(ranks["Doctor"]) do
	doctor = doctor .. "\n" .. v[2] .. " - " .. v[3] .. " (Required XP: " .. v[1] .. ")"
end
info["Doctor"] = "Doctor Job is one of the `CORE` & Crucial Job of UGC:RPG! Doctor's job is to heal other players. Doctors themself they can decide whome to heal. Doctors have ability to heal any kinds of players such as Civilian/Criminal or a Cop\n\nRank Description:\n" .. doctor

-- Pilot
local pilot = ""
for k, v in pairsByKeys(ranks["Pilot"]) do
	pilot = pilot .. "\n" .. v[2] .. " - " .. v[3] .. " (Required XP: " .. v[1] .. ")"
end
info["Pilot"] = "Pilot Job \n\nA Job which is very famous in whole GTA:SA & MTA:SA World. Player after taking pilot job has been spawn a vehicle from Pilot Spawners. \n\nSecondly, Pilots will be paid by the distance they travel and rank. Max level you can get in pilot is L10 - Specialist which requires more than 750 Flights Finished & 26,25,000 KM Distance. Good luck! \n\nTotal Levels: \n" .. pilot

-- Police Officer
local police = ""
for k, v in pairsByKeys(ranks["Police Officer"]) do
	police = police .. "\n" .. v[2] .. " - " .. v[3] .. " (Required Arrests: " .. v[1] .. ")"
end
info["Police Officer"] = "Police Officer Job is most important job of RP. It's Police's Job to keep San Andreas clean from Outlaws. Apart from catching criminals, you can enter in CnR and many types of events. \n\nTotal Levels: \n" .. police

-- Bus Driver
local busdriver = ""
for k, v in pairsByKeys(ranks["Bus Driver"]) do
	busdriver = busdriver .. "\n" .. v[2] .. " - " .. v[3] .. " (Required Trips: " .. v[1] .. ")"
end
info["Bus Driver"] = "Bus Driver is one of the major jobs of san andreas. After taking the job you will have to go to bus stops and pick-up passangers. According to your skills and level you will be paid at each trip. \n\nTotal Levels: \n" .. busdriver

-- Pizza Boy
local pizzaboy = ""
for k, v in pairsByKeys(ranks["Pizza Boy"]) do
	pizzaboy = pizzaboy .. "\n" .. v[2] .. " - (Required Deliveries: " .. v[1] .. ")"
end
info["Pizza Boy"] = "No Job Description Available. \n\nTotal Levels: \n" .. pizzaboy

-- Mechanic
local mechanic = ""
for k, v in pairsByKeys(ranks["Mechanic"]) do
	mechanic = mechanic .. "\n" .. v[2] .. " - (Required Repairs: " .. v[1] .. ")"
end
info["Mechanic"] = "No Job Description Available. \n\nTotal Levels: \n" .. mechanic



-- Exports/Functions
------------------->

function getJobInfo(job)
	return info[job] or false
end

function getPlayerJobRank(player, job)
	for k, v in pairsByKeys(ranks[job]) do
		local account = getPlayerAccount(player)
		local progress = math.ceil(exports.UGCaccounts:getData(account,  job .. "-Progress") or 0)
		if v[1] >= progress then
			return k
		end
	end
	return 10
end

function givePlayerProgress(player, job, value)
	if doesJobExist(job) ~= true then return error("givePlayerProgress: Job " .. job .. " does not exist!") end
	local account = getPlayerAccount(player)
	local current = exports.UGCaccounts:getData(account, job .. "-Progress") or 0
	exports.UGCaccounts:setData(account,  job .. "-Progress", current+value)
end

function getPlayerProgress(player, job)
	local account = getPlayerAccount(player)
	return exports.UGCaccounts:getData(account, job .. "-Progress") or 0
end