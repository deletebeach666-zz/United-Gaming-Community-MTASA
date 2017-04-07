local blip = exports.customblips:createCustomBlip (2193.39453125, 1677.2939453125, 20, 20, "blip.png")
local font = guiCreateFont ("font.ttf",20)

label = guiCreateLabel(0.33, 0.83, 0.44, 0.09, "Reward", true)

guiSetFont(label, font)

guiLabelSetColor(label, 255, 10, 10)

guiSetVisible(label, false)


function changeText (text)

	guiSetVisible(label, true)
	guiSetText(label, "Reward: $"..text.."")
end
addEvent("CR:update", true)
addEventHandler("CR:update", root, changeText)	

function out ()

	guiSetVisible(label, false)
end
addEvent("CR:out", true)
addEventHandler("CR:out", root, out)	