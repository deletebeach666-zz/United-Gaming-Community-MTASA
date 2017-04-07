------------------------------>
-- UGC: United Gaming Community
-- Author: Om Bhende (RipeMangoes69)
-- Date: 24 March 2017
-- Version: 1.0
-- File: UGCemployment/client.lua
-- Type: Client Sided
------------------------------>

-- Custom Events
addEvent("onClientPlayerTakeJob", true)
addEvent("onClientPlayerResign", true)
local jobsuccesstable = {}

employment = {
    label = {},
    button = {},
    window = {},
    combobox = {},
    memo = {}
}
local jobSkins = nil

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        employment.window[1] = guiCreateWindow(406, 217, 516, 357, "Employment Office - Job Name", false)
        guiWindowSetSizable(employment.window[1], false)
        exports.UGCutils:centerWindow(employment.window[1])
        guiSetVisible(employment.window[1], false)

        -- Labels where color will change
        employment.label[1] = guiCreateLabel(11, 34, 60, 15, "Job Name:", false, employment.window[1])
        guiSetFont(employment.label[1], "default-bold-small")
        guiLabelSetColor(employment.label[1], 255, 255, 0)
        employment.label[3] = guiCreateLabel(21, 64, 50, 15, "Division:", false, employment.window[1])
        guiSetFont(employment.label[3], "default-bold-small")
        guiLabelSetColor(employment.label[3], 255, 255, 0)
        employment.label[4] = guiCreateLabel(283, 34, 60, 15, "Applicant:", false, employment.window[1])
        guiSetFont(employment.label[4], "default-bold-small")
        guiLabelSetColor(employment.label[4], 255, 255, 0)
        employment.label[5] = guiCreateLabel(75, 39, 130, 15, "_________________________________", false, employment.window[1])
        employment.label[7] = guiCreateLabel(347, 39, 146, 15, "_________________________________", false, employment.window[1])
        employment.label[8] = guiCreateLabel(306, 64, 37, 17, "Skins:", false, employment.window[1])
        guiSetFont(employment.label[8], "default-bold-small")
        guiLabelSetColor(employment.label[8], 255, 255, 0)
        employment.label[9] = guiCreateLabel(5, 98, 509, 15, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", false, employment.window[1])
        guiSetFont(employment.label[9], "default-small")

        employment.button[1] = guiCreateButton(427, 323, 79, 24, "Apply", false, employment.window[1])
        guiSetFont(employment.button[1], "default-bold-small")
        guiSetProperty(employment.button[1], "NormalTextColour", "FFAAAAAA")
        employment.button[2] = guiCreateButton(348, 323, 79, 24, "Decline", false, employment.window[1])
        guiSetFont(employment.button[2], "default-bold-small")
        guiSetProperty(employment.button[2], "NormalTextColour", "FFAAAAAA")    
        -- Dynamic Labels
        ------------------->
        employment["client_name"] = guiCreateLabel(347, 34, 146, 15, "[UGC]Player|Group", false, employment.window[1])
        employment["job_name"] = guiCreateLabel(75, 34, 130, 15, "Job Name", false, employment.window[1])
        employment["division"] = guiCreateComboBox(75, 64, 130, 91, "", false, employment.window[1]) -- Division
        employment["skins"] = guiCreateComboBox(347, 64, 146, 94, "", false, employment.window[1]) -- Skin
        employment["description"] = guiCreateMemo(9, 116, 495, 203, "", false, employment.window[1]) -- Job Description
        guiMemoSetReadOnly(employment["description"], true)

    end
)

function cancelPedDamage()
    if getElementData(source, "employment") == true then
        cancelEvent()
    end
end
addEventHandler("onClientPedDamage", getRootElement(), cancelPedDamage)

addEvent("UGCemployment.openEMWindow", true)
addEventHandler("UGCemployment.openEMWindow", resourceRoot, function(city, job, skins, division, color, info)
    jobSkins = skins
    guiSetText(employment["client_name"], getPlayerName(localPlayer))
    guiSetText(employment["job_name"], job)
    guiSetVisible(employment.window[1], true)
    guiSetText(employment.window[1], "Employment System - " .. job)
    guiSetText(employment["description"], info)
    guiLabelSetColor(employment.label[1], color[1], color[2], color[3])
    guiLabelSetColor(employment.label[3], color[1], color[2], color[3])
    guiLabelSetColor(employment.label[4], color[1], color[2], color[3])
    guiLabelSetColor(employment.label[8], color[1], color[2], color[3])
    showCursor(true)
    guiComboBoxClear(employment["skins"])
    for _, v in ipairs(skins) do
        guiComboBoxAddItem(employment["skins"], v[1] .. " (ID: " .. v[2] .. ")")
    end
    guiComboBoxClear(employment["division"])
    for _, v in ipairs(division) do
        guiComboBoxAddItem(employment["division"], v)
    end
end)

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    if source == employment.button[2] and btn == "left" then
     guiSetVisible(employment.window[1], false)
     showCursor(false)
    end
end)

addEventHandler("onClientGUIClick", resourceRoot, function(btn)
    local item = guiComboBoxGetSelected(employment["skins"])
    local skin = guiComboBoxGetItemText(employment["skins"], item)
    local divs = guiComboBoxGetSelected(employment["division"])
    local division = guiComboBoxGetItemText(employment["division"], divs)
    if skin == "" or skin == nil or division == "" or division == nil then return end
    if source == employment.button[1] and btn == "left" then
     local job = guiGetText(employment["job_name"])
     takeJob(job)
     guiSetVisible(employment.window[1], false)
     showCursor(false)
    end
end)

function takeJob(job)
    local item = guiComboBoxGetSelected(employment["skins"])
    local skin = guiComboBoxGetItemText(employment["skins"], item)
    local divs = guiComboBoxGetSelected(employment["division"])
    local division = guiComboBoxGetItemText(employment["division"], divs)
    if getElementData(localPlayer, "Occupation") == job then return exports.UGCnoty:sendNotification("You already have this job!", 255, 0, 0) end
    for _, v in ipairs(jobSkins) do
        local str = v[1] .. " (ID: " .. v[2] .. ")"
        if skin == str then
            if triggerEvent("onClientPlayerTakeJob", localPlayer, job, division, v[2]) then
                triggerServerEvent("UGCemployment.onPlayerTakeJob", resourceRoot, job, division, v[2])
            end
            break
        end
    end
end

addEventHandler("onClientPlayerTakeJob", root, function(job, div, skin)
    if source == localPlayer then
        triggerServerEvent("UGCemployment.resignPlayer", resourceRoot)
        exports.UGCnoty:sendNotification("You are now employed as " .. job .. "!", 0, 255, 0)
    end
end)

addEventHandler("onClientRender", root, function()
	for _, v in ipairs(getElementsByType("ped")) do
		local data = getElementData(v, "UGCemployment:jobcolor")
		local job = getElementData(v, "UGCemployment:job")
		if data ~= false or data ~= nil then
			if type(data) == "table" then
				exports.UGCdx:createTextOnElement(v, job, 1.5, 50, data[1], data[2], data[3], 255, 1.5, "bankgothic")
			end
		end
	end
end)

function renderSuccess(job, total)
	local sx, sy = guiGetScreenSize()
	if #jobsuccesstable == 0 then return end
    for _, v in ipairs(jobsuccesstable) do
	    dxDrawText("Task Completed", 0 - 1, sy*(219 - 1/768), sx*(1366/1366) - 1, sy*(289/768) - 1, tocolor(0, 0, 0, 255), 5.00, "pricedown", "center", "top", false, false, false, false, false)
	    dxDrawText("Task Completed", 0 + 1, sy*(219 + 1/768), sx*(1366/1366) + 1, sy*(289/768) + 1, tocolor(0, 0, 0, 255), 5.00, "pricedown", "center", "top", false, false, false, false, false)
	    dxDrawText("Task Completed", 0 + 1, sy*(219 - 1/768), sx*(1366/1366) - 1, sy*(289/768) - 1, tocolor(0, 0, 0, 255), 5.00, "pricedown", "center", "top", false, false, false, false, false)
	    dxDrawText("Task Completed", 0 - 1, sy*(219 + 1/768), sx*(1366/1366) + 1, sy*(289/768) + 1, tocolor(0, 0, 0, 255), 5.00, "pricedown", "center", "top", false, false, false, false, false)
	    dxDrawText("Task Completed", 0, sy*(219/768), sx*(1366/1366), sy*(289/768), tocolor(255, 255, 0, 255), 5.00, "pricedown", "center", "top", false, false, false, false, false)
	    dxDrawText(v.total, sx*(507-1/1366), sy*(352-1/768), sx*(838-1/1366), sy*(423-1/768), tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "top", false, false, false, false, false)
	    dxDrawText(v.total, sx*(507+1/1366), sy*(352-1/768), sx*(838+1/1366), sy*(423-1/768), tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "top", false, false, false, false, false)
	    dxDrawText(v.total, sx*(507-1/1366), sy*(352+1/768), sx*(838-1/1366), sy*(423+1/768), tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "top", false, false, false, false, false)
	    dxDrawText(v.total, sx*(507+1/1366), sy*(352+1/768), sx*(838+1/1366), sy*(423+1/768), tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "top", false, false, false, false, false)
	    dxDrawText(v.total, sx*(507/1366), sy*(352/768), sx*(838/1366), sy*(423/768), tocolor(255, 255, 0, 255), 1.00, "pricedown", "center", "top", false, false, false, false, false)
    end
end
addEventHandler("onClientRender", root, renderSuccess)

function givePlaeyrJobMoney(job, money, ...)
	local ab = table.concat({...}, "\n")
	table.insert(jobsuccesstable, {jobname = job, total = ab})
    playSoundFrontEnd(13)
	setTimer(function()
		jobsuccesstable = {}
	end, 5000, 1)
end

addEvent("UGCemployment.givePlayerJobMoney", true)
addEventHandler("UGCemployment.givePlayerJobMoney", resourceRoot, function(job, ab)
    table.insert(jobsuccesstable, {jobname = job, total = ab})
    playSoundFrontEnd(13)
    setTimer(function()
        jobsuccesstable = {}
    end, 5000, 1)
end)

addEvent("UGCemployment.resign", true)
addEventHandler("UGCemployment.resign", getRootElement(), function(job)
    triggerEvent("onClientPlayerResign", localPlayer, job)
end)
