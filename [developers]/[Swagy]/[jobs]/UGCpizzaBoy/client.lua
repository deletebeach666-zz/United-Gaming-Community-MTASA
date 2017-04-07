local pizzas = 0
local temp = 0
local peds = {}
local object = {}

local font = guiCreateFont("files/font.ttf", 15)

local PizzaslocLS = {
    {2017.884, -1703.210, 13.234},
    {2066.313, -1703.482, 13.148},
    {2435.226, -1289.308, 24.348},
    {2472.886, -1238.500, 31.569},
    {2229.693, -1241.135, 24.656},
    {2091.919, -1166.550, 25.586},
    {2022.906, -1120.776, 25.421},
    {1102.617, -1093.715, 27.469},
    {1051.067, -1058.106, 33.797},
    {760.052, -1507.672, 12.547},
    {692.937, -1602.388, 14.047},
    {653.538, -1714.064, 13.765},
    {768.630, -1745.792, 12.077},
    {986.286, -1704.217, 13.930},
    {1913.478, -1912.729, 14.257},
    {1873.601, -2070.053, 14.497},
    {1894.248, -2133.565, 14.466},
    {280.855, -1767.981, 3.535},
    {228.356, -1404.611, 50.609},
    {298.170, -1337.451, 52.442},
}
local PizzaslocSF = {
{-2563.3, 1148.7, 54.7},
{-2506.3999, 1141.7, 54.7},
{-2396.7, 1132.6, 54.7},
{-2451.3, 1141.5, 54.7},
{-2351.8999, 1318, 15.1},
{-2477.2, 1281.5, 22.7},
{-2433.6001, 1338.2, 7.5},
{-2789.2, -181.10001, 8.9},
{-2791.8, -134.3, 9},
{-2791.8, -24.4, 9},
{-2791.2, 126.9, 6.1},
{-2791.8, 218.60001, 6.8},
{-2883.8999, 743.5, 28.1},
{-2864.6001, 681.59998, 22.2},
{-2880.8999, 790.20001, 34.1},
{-2845.1001, 928.40002, 42.9},
{-2900.3999, 1081, 31.1},
{-2285, 849.59998, 64.1},
{-2174.3, 903.70001, 79},
{-2223.8, 744, 48.4},
{-2686.8999, -187.89999, 6.2},
{-2689.3999, -141.10001, 6.2},
{-2688.8, -89.4, 3.2},
{-2662.1001, 877, 78.7},
{-2721.8, 923.90002, 66.6},
{-2710.7, 968.09998, 53.4},
{-2641.1001, 935.70001, 70.9},
{-2321.7, 797.09998, 44.1},
{-2280.8999, 1023, 82.8},
{-2168.3, 1107.5, 79},
{-2112.5, 796.70001, 68.6},
{-2058.8999, 890.79999, 60.8},
{-2621.8999, 782.59998, 43.9},
{-2686.2, 722.79999, 31.1},
{-2687.7, 803.70001, 48.9},
}
local PizzasMarkersLS = {
{2126.151, -1806.752, 12.554},
{2126.241, -1812.731, 12.554},
{2126.352, -1808.232, 12.554},
}
local PizzasMarkersSF = {
{374.174, -114.018, 1000.492},
{376.185, -114.142, 1000.492},
{378.079, -114.234, 1000.492},
}


function createDeliveryMarker (table)

    local x,y,z = unpack(table[math.random(#table)])
    deliveryMarker = createMarker(x,y,z, "cylinder", 1, 255,255,0,255)
    deliveryBlip = createBlipAttachedTo(deliveryMarker, 29)
    peds[deliveryMarker] = createPed(math.random(20,216), x,y,z)
    setElementRotation(peds[deliveryMarker], 0,0,180)
    exports.UGCnoty:sendNotification("Pizza delivery location is marked in your radar, deliver the pizzas before they get cold!",255,255,0)

end

function cancelJob ()
    if (deliveryMarker) then
        destroyElement(deliveryBlip)
        deliveryBlip = nil
        destroyElement(deliveryMarker)
        deliveryMarker = nil
    elseif (loadingMarker) then
        destroyElement(loadingBlip)
        loadingBlip = nil
        destroyElement(loadingMarker)
        loadingMarker = nil
    end
    if (pizzas > 0) then
        pizzas = 0
    end 
    if (progress) then
        exports.UGCdx:destroyProgressBar(progress)
    end
    if (isTimer(decreaseTimer)) then
        killTimer(decreaseTimer)
    end
end

function decreaseTemp ()

    if (temp > 0) then
        temp = temp-1
    else
        temp = 0
        exports.UGCnoty:sendNotification("Your pizzas are now cold, you have to bake some pizzas!",255,0,0)
        cancelJob ()
        if (exports.UGCchat:getPlayerZone(getLocalPlayer()) == "LS") then
                local x,y,z = unpack(PizzasMarkersLS[math.random(#PizzasMarkersLS)])
                loadingMarker = createMarker (x,y,z, "cylinder", 1.5,255,255,0)
                loadingBlip = createBlipAttachedTo(loadingMarker, 50)
                exports.UGCnoty:sendNotification("Go to the restaurant blip to load your pizza boy.",255,255,0)
        elseif (exports.UGCchat:getPlayerZone(getLocalPlayer()) == "SF") then
                local x,y,z = unpack(PizzasMarkersSF[math.random(#PizzasMarkersSF)])
                loadingMarker = createMarker (x,y,z, "cylinder", 1.5,255,255,0)
                loadingBlip = createBlipAttachedTo(loadingMarker, 29)
                exports.UGCnoty:sendNotification("Go to the restaurant blip to load your pizza boy.",255,255,0)
        end
    end
end


addEventHandler("onClientPlayerTakeJob", getRootElement(), function(job, division, skin)
    if job == "Pizza Boy" then
        if (pizzas == 0) then
            if (exports.UGCchat:getPlayerZone(getLocalPlayer()) == "LS") then
                local x,y,z = unpack(PizzasMarkersLS[math.random(#PizzasMarkersLS)])
                loadingMarker = createMarker (x,y,z, "cylinder", 1.5,255,255,0)
                loadingBlip = createBlipAttachedTo(loadingMarker, 50)
                exports.UGCnoty:sendNotification("Go to the restaurant blip to load your pizza boy.",255,255,0)
            elseif (exports.UGCchat:getPlayerZone(getLocalPlayer()) == "SF") then
                local x,y,z = unpack(PizzasMarkersSF[math.random(#PizzasMarkersSF)])
                loadingMarker = createMarker (x,y,z, "cylinder", 1.5,255,255,0)
                loadingBlip = createBlipAttachedTo(loadingMarker, 29)
                exports.UGCnoty:sendNotification("Go to the restaurant blip to load your pizza boy.",255,255,0)
            end
        else
            if (exports.UGCchat:getPlayerZone(getLocalPlayer()) == "LS") then
                createDeliveryMarker(PizzaslocLS)
            elseif (exports.UGCchat:getPlayerZone(getLocalPlayer()) == "SF") then
                createDeliveryMarker(PizzaslocSF)
            end
        end    
    end
end)

addEventHandler("onClientPlayerResign", getRootElement(), function (job)
    if (job ~= "Pizza Boy") then return false end
    cancelJob() 
end
)


addEventHandler("onClientMarkerHit", root, function (hitPlayer, matchingDim)

    if not (matchingDim) then return false end
    if (source ~= loadingMarker) then return false end
    if (hitPlayer ~= localPlayer) then return false end
    pizzas = 5
    temp = 100
    exports.UGCnoty:sendNotification("Your pizza boy is now loaded, head to pizza blips to devlier the pizza!",255,255,0)
    decreaseTimer = setTimer(decreaseTemp, 5000,0)
    progress = exports.UGCdx:drawProgressBar("Temperature", 500000, 255, 255, 0, true)
        if (exports.UGCchat:getPlayerZone(hitPlayer) == "LS") then
            destroyElement (loadingBlip)
            loadingBlip = nil
            destroyElement(source)
            loadingMarker = nil
            createDeliveryMarker(PizzaslocLS)
        elseif (exports.UGCchat:getPlayerZone(hitPlayer) == "SF") then
            destroyElement (loadingBlip)
            loadingBlip = nil
            destroyElement(source)
            loadingMarker = nil
            createDeliveryMarker(PizzaslocSF)
        end
end
)


addEventHandler("onClientMarkerHit", root, function (hitPlayer, matchingDim)

    if not (matchingDim) then return false end
    if (source ~= deliveryMarker) then return false end
    if (hitPlayer ~= localPlayer) then return false end
    if (0 >= pizzas) then
        exports.UGCnoty:sendNotification("You don't anymore pizzas, go and bake some!",255,0,0)
        cancelJob ()
        if (exports.UGCchat:getPlayerZone(getLocalPlayer()) == "LS") then
                local x,y,z = unpack(PizzasMarkersLS[math.random(#PizzasMarkersLS)])
                loadingMarker = createMarker (x,y,z, "cylinder", 1.5,255,255,0)
                loadingBlip = createBlipAttachedTo(loadingMarker, 50)
                exports.UGCnoty:sendNotification("Go to the restaurant blip to load your pizza boy.",255,255,0)
            elseif (exports.UGCchat:getPlayerZone(getLocalPlayer()) == "SF") then
                local x,y,z = unpack(PizzasMarkersSF[math.random(#PizzasMarkersSF)])
                loadingMarker = createMarker (x,y,z, "cylinder", 1.5,255,255,0)
                loadingBlip = createBlipAttachedTo(loadingMarker, 29)
                exports.UGCnoty:sendNotification("Go to the restaurant blip to load your pizza boy.",255,255,0)
        end
    end
    if (getPedOccupiedVehicle(hitPlayer)) then return exports.UGCnoty:sendNotification("You need to exit your vehicle first!",255,0,0) end
    local x,y,z = getElementPosition(hitPlayer)
    object[hitPlayer] = createObject (1582, x,y,z)
    attachElements(hitPlayer, object[hitPlayer], 0,-0.45,-0.39,1,0,0)
    setPedAnimation(hitPlayer, "VENDING", "VEND_Use", 15, true, false, false, false)
    setPedAnimation(peds[source], "VENDING", "VEND_Use", 15, true, false, false, false)
    setTimer(function (p) destroyElement(object[p]) object[p] = nil end,1000*5,1,hitPlayer)
    setTimer(function (m) destroyElement(peds[m]) peds[m] = nil end, 1000*5,1,source)
    destroyElement(deliveryBlip)
    deliveryBlip = nil
    destroyElement(source)
    deliveryMarker = nil
    pizzas = pizzas-1
    exports.UGCnoty:sendNotification("Pizzas left: "..tostring(pizzas).."",255,255,0)
    triggerServerEvent("UGCpizzaboy:givePayment", resourceRoot, hitPlayer)
        if (exports.UGCchat:getPlayerZone(hitPlayer) == "LS") then
            createDeliveryMarker(PizzaslocLS)
        elseif (exports.UGCchat:getPlayerZone(hitPlayer) == "SF") then
            createDeliveryMarker(PizzaslocSF)
        end
end)