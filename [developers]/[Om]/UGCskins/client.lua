-------------------------------->
-- UGC: United Gaming Community
-- Author: Om Bhende (RipeMangoe69)
-- Date: 27 February 2017
-- Script: UGCskins/client.lua
-- Type: Client Sided
-------------------------------->

local skins = {
{"Carl Johnson", 0},
{"Truth", 1},
{"Maccer", 2},
{"Casual Jeanjacket", 7},
{"Business Lady", 9},
{"Old Fat Lady", 10},
{"Card Dealer 1", 11},
{"Classy Gold Hooker", 12},
{"Homegirl", 13},
{"Floral Shirt", 14},
{"Plaid Baldy", 15},
{"Earmuff Worker", 16},
{"Black suit", 17},
{"Black Beachguy", 18},
{"Beach Gangsta", 19, 800},
{"Fresh Prince", 20},
{"Striped Gangsta", 21},
{"Orange Sportsman", 22},
{"Skater Kid", 23},
{"LS Coach", 24},
{"Varsity Jacket", 25},
{"Hiker", 26},
{"Construction 1", 27},
{"Black Dealer", 28},
{"White Dealer", 29},
{"Religious Essey", 30},
{"Fat Cowgirl", 31},
{"Eyepatch", 32},
{"Bounty Hunter", 33},
{"Marlboro Man", 34},
{"Fisherman", 35},
{"Mailman", 36},
{"Baseball Dad", 37},
{"Old Golf Lady", 38},
{"Old Maid", 39},
{"Classy Dark Hooker", 40},
{"Tracksuit Girl", 41},
{"Porn Producer", 43},
{"Tatooed Plaid", 44},
{"Beach Mustache", 45},
{"Dark Romeo", 46},
{"Top Button Essey", 47},
{"Ninja Sensei", 49},
{"Mechanic", 50},
{"Black Bicyclist", 51},
{"White Bicyclist", 52},
{"Golf Lady", 53},
{"Hispanic Woman", 54},
{"Rich Bitch", 55},
{"Legwarmers 1", 56, 800},
{"Chinese Businessman", 57},
{"Chinese Plaid", 58},
{"Chinese Romeo", 59},
{"Chinese Casual", 60},
{"Pilot", 61},
{"Pajama Man 1", 62},
{"Trashy Hooker", 63},
{"Transvestite", 64},
{"Varsity Bandits", 66},
{"Red Bandana", 67},
{"Preist", 68},
{"Denim Girl", 69},
{"Scientist", 70},
{"Security Guard", 71},
{"Bearded Hippie", 72, 800},
{"Flag Bandana", 73},
{"Skanky Hooker", 75},
{"Businesswoman 1", 76},
{"Bag Lady", 77},
{"Homeless Scarf", 78},
{"Fat Homeless", 79},
{"Red Boxer", 80},
{"Blue Boxer", 81},
{"Fatty Elvis", 82},
{"Whitesuit Elvis", 83},
{"Bluesuit Elvis", 84},
{"Furcoat Hooker", 85, 800},
{"Firecrotch", 87},
{"Casual Old Lady", 88},
{"Cleaning Lady", 89},
{"Barely Covered", 90},
{"Sharon Stone", 91},
{"Rollergirl", 92},
{"Hoop Earrings 1", 93},
{"Andy Capp", 94},
{"Poor Old Man", 95},
{"Soccer Player", 96},
{"Baywatch Dude", 97},
{"Rollerguy", 99},
{"Biker Blackshirt", 100},
{"Jacket Hippie", 101},
{"Baller Shirt", 102},
{"Baller Jacket", 103},
{"Baller Sweater", 104},
{"Grove Sweater", 105},
{"Grove Topbutton", 106},
{"Grove Jersey", 107},
{"Vagos Topless", 108},
{"Vagos Pants", 109},
{"Vagos Shorts", 110},
{"Russian Muscle", 111},
{"Russian Hitman", 112},
{"Russian Boss", 113},
{"Aztecas Stripes", 114},
{"Aztecas Jacket", 115},
{"Aztecas Shorts", 116},
{"Triad 1", 117},
{"Triad 2", 118},
{"Sindacco Suit", 120},
{"Da Nang Army", 121},
{"Da Nang Bandana", 122},
{"Da Nang Shades", 123},
{"Sindacco Muscle", 124},
{"Mafia Enforcer", 125},
{"Mafia Wiseguy", 126},
{"Mafia Hitman", 127},
{"Native Rancher", 128},
{"Native Librarian", 129},
{"Native Ugly", 130},
{"Native Sexy", 131},
{"Native Geezer", 132},
{"Furys Trucker", 133},
{"Homeless Smoker", 134, 800},
{"Skullcap Hobo", 135},
{"Old Rasta", 136},
{"Box Head", 137},
{"Bikini Tattoo", 138},
{"Yellow Bikini", 139},
{"Busom Bikini", 140},
{"Cute Librarian", 141},
{"African 1", 142},
{"Sam Jackson", 143},
{"Drug Worker 1", 144},
{"Drug Worker 2", 145},
{"Drug Worker 3", 146},
{"Sigmund Freud", 147},
{"Business Woman 2", 148},
{"Business Woman 3", 150},
{"Melanie", 151},
{"Schoolgirl 1", 152},
{"Foreman", 153},
{"Beach Blonde", 154},
{"Pizza Guy", 155, 800},
{"Old Reece", 156},
{"Farmer girl", 157},
{"Farmer", 158},
{"Farmer Rednech", 159},
{"Bald Rednech", 160},
{"Smoking Cowboy", 161},
{"Inbred", 162},
{"Casino Bouncer 1", 163},
{"Casino Bouncer 2", 164},
{"Agent Kay", 165},
{"Agent Jay", 166},
{"Chicken", 167},
{"Hotdog Escort", 168},
{"Asian Escort", 169},
{"PubeStache Tshirt", 170},
{"Card Dealer 2", 171},
{"Card Dealer 3", 172},
{"Rifa Hat", 173},
{"Rifa Vest", 174},
{"Rifa Suspenders", 175},
{"Style Barber", 176},
{"Vanilla Ice Barbar", 177},
{"Masked Stripper", 178},
{"War Vet", 179},
{"Bball Player", 180},
{"Punk", 181},
{"Pajama Man 2", 182, 800},
{"Klingon", 183},
{"Neckbeard", 184},
{"Nervous Guy", 185},
{"Teacher", 186},
{"Japanese Businessman 1", 187},
{"Green Shirt", 188},
{"Valet", 189},
{"Barbana Schternvart", 190},
{"Halena Wankstein", 191},
{"Michelle Cannes", 192},
{"Katie Zhan", 193},
{"Millie Perkins", 194},
{"Denise Robinson", 195},
{"Aunt May", 196},
{"Smoking Maid", 197},
{"Ranch Cowgirl", 198},
{"Heidi", 199},
{"Hairy Rednech", 200},
{"Trucker Girl", 201},
{"Beer Trucker", 202, 800},
{"Ninja 1", 203},
{"Ninja 2", 204},
{"Burger Girl", 205},
{"Money Trucker", 206},
{"Grove Booty", 207},
{"Noodle Vender", 209},
{"Sloppy Tourist", 210},
{"Tin Foil Hat", 212},
{"Hobo Elvis", 213},
{"Caligula Waitress", 214},
{"Explorer", 215},
{"Turtleneck", 216},
{"Old Woman", 218},
{"Lady in Red", 219},
{"African 2", 220},
{"Beardo Casual", 221},
{"Beardo Clubbing", 222},
{"Greasy Nightclubber", 223},
{"Elderly Asian 1", 224},
{"Elderly Asian 2", 225},
{"Legwarmers 2", 226},
{"Japanese Businessman 2", 227},
{"Japanese Businessman 3", 228},
{"Asian Tourist", 229},
{"Hooded Hobo", 230},
{"Grannie", 231},
{"Grouchy Lady", 232, 800},
{"Hoop Earrings 2", 233},
{"Buzzcut", 234},
{"Retired Tourist", 235},
{"Happy Old Man", 236},
{"Leopard Hooker", 237},
{"Amazon", 238},
{"Hugh Grant", 240},
{"Afro Brother", 241},
{"Dreadlock Brother", 242},
{"Ghetto Booty", 243},
{"Lace Stripper", 244},
{"Ghetto Ho", 245},
{"Cop Stripper", 246},
{"Biker (Vest)", 247},
{"Biker (Headband)", 248},
{"Pimp", 249},
{"Green T-Shirt", 250},
{"Lifeguard", 251},
{"Naked Freak", 252},
{"Bus Driver", 253},
{"Biker (Vest (B))", 254},
{"Limo Driver", 255},
{"Schoolgirl 2", 256},
{"Bondage Girl", 257},
{"Joe Pesci", 258},
{"Chris Penn", 259},
{"Construction 2", 260},
{"Southerner", 261},
{"Pajama Man 2 (B)", 262},
{"Asian Hostess", 263},
{"Whoopee the Clown", 264},
{"Tenpenny", 265},
{"Pulaski", 266},
{"Hern", 267},
{"Dwayne", 268},
{"Big Smoke", 269},
{"Sweet", 270},
{"Ryder", 271},
{"Forelli Guy", 272},
{"Rose", 290},
{"Kent Paul", 291},
{"Cesar", 292},
{"OG Loc", 293},
{"Wu Zi Mu", 294},
{"Mike Toreno", 295},
{"Jizzy", 296},
{"Madd Dogg", 297},
{"Catalina", 298},
{"Claude from GTA III", 299},
{"Ryder", 300},
{"Ryder (Robber)", 301},
{"Emmet", 302},
{"Andre", 303},
{"Kendl", 304},
{"Jethro", 305},
{"Zero", 306},
{"T-Bone Mendez", 307},
{"Sindaco Guy", 308},
{"Janitor", 309},
{"Big Bear", 310},
{"Big Smoke with Vest", 311},
{"Phsyco", 312}
}


GUIEditor = {
    gridlist = {},
    window = {},
    button = {}
}

-- Format: {x, y, z, dim, int}
local markers = {
	{1446.37, -1127.37, 23, 0, 0}, -- LS Heist Bank Skin Shop 1
	{1448.22, -1125.66, 23, 0, 0}, -- LS  Heist Bank Skin Skop 2
	{2245.78, -1679.64, 14.5, 0, 0}, -- LS Ganton 1
	{2243.25, -1679.84, 14.5, 0, 0}, -- LS Ganton 2
	{490.951, -1379.82, 15.39, 0, 0}, -- LS Rodeo
	{1669.44, 1736.46, 9.8, 0, 0}, -- LV Hospital Bingo 1
	{1669.514, 1733.89, 9.8, 0, 0}, -- LV Hospital Bingo 1
	{464, -1474.5, 29.8, 0, 0}, -- LS Rodeo 2
	{2868.6027832031, 2469.7006835938, 9.6665225982666-0.6}, -- Las Venturas Near KCC
}

local blips = {
	{2244.46, -1655.35, 15.47},
	{499.63, -1360.40, 16.34},
	{1456.77, -1138.020, 23.97},
	{1657.01, 1733.32, 10.82},
	{464, -1474.5, 29.8},
	{2868.6027832031, 2469.7006835938, 9.6665225982666},
}

-- Format: {x, y, z, rot, dim, int}
local peds = {
	-- LV Hospital Bingo
	{1671.0816650391, 1736.5249023438, 10.81898021698, 90, 0, 0},
	{1671.1569824219, 1733.9300537109, 10.81898021698, 90, 0, 0},
	
	-- LS Rodeo
	{490.45349121094, -1381.1041259766, 16.392539978027, 335.76153564453, 0, 0},
	
	-- LS Ganton
	{2245.8308105469, -1681.5750732422, 15.478770256042, 2.0683565139771, 0, 0},
	{2243.2626953125, -1681.6477050781, 15.478770256042, 2.4160537719727, 0, 0},
	
	-- LS Heist Bank
	{1444.9664306641, -1125.6262207031, 23.932811737061, 218.31782531738, 0, 0},
	{1446.87109375, -1124.1301269531, 23.932811737061, 219.59265136719, 0, 0},
	
	-- LS Rodeo 2
	{465.40802001953, -1473.9682617188, 30.860343933105, 108.64170837402, 0, 0},
	
	-- LV Near KCC
	{2867.5295410156, 2470.779296875, 9.6665225982666, 224.89041137695, 0, 0},
}

local temp = {}

addEventHandler("onClientResourceStart", resourceRoot,
    function()
		local screenW, screenH = guiGetScreenSize()
        GUIEditor.window[1] = guiCreateWindow(screenW-352, screenH-550, 352, 492, "United Gaming Community - Skin Shop", false)
        guiWindowSetSizable(GUIEditor.window[1], false)
	    guiSetVisible(GUIEditor.window[1], false)

        GUIEditor.gridlist[1] = guiCreateGridList(9, 22, 333, 423, false, GUIEditor.window[1])
        name = guiGridListAddColumn(GUIEditor.gridlist[1], "Name", 0.8)
        id = guiGridListAddColumn(GUIEditor.gridlist[1], "ID", 0.1)
        for _, v in ipairs(skins) do
        	local row = guiGridListAddRow(GUIEditor.gridlist[1])
        	guiGridListSetItemText(GUIEditor.gridlist[1], row, name, v[1], false, false)
        	guiGridListSetItemText(GUIEditor.gridlist[1], row, id, v[2], false, false)
        end
        GUIEditor.button[1] = guiCreateButton(10, 448, 166, 34, "Cancel", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.button[1], "default-bold-small")
        guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFAAAAAA")
        GUIEditor.button[2] = guiCreateButton(177, 448, 165, 34, "Purchase [$500]", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.button[2], "default-bold-small")
        guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFAAAAAA")    
    for _, v in ipairs(markers) do
    	marker = createMarker(v[1], v[2], v[3], "cylinder", 1, 153, 63, 108, 150)
    	setElementDimension(marker, v[4] or 0)
    	setElementInterior(marker, v[5] or 0)
    	addEventHandler("onClientMarkerHit", marker, openWindow)
    end
	
	  for _, v in ipairs(peds) do
    	ped = createPed(211, v[1], v[2], v[3], v[4])
    	setElementDimension(ped, v[5])
    	setElementInterior(ped, v[6])
    	setElementData(ped, "employment", true)
    	setElementFrozen(ped, true)
		setPedAnimation(ped, "int_shop", "shop_cashier")
    end

    for _, v in ipairs(blips) do
    	blip = createBlip(v[1], v[2], v[3], 45, 2, 255, 0, 0, 255, 0, getElementData(localPlayer, "viewDistance") or 1000)
    end
end)

function openWindow(hitPlayer, matchingDimension)
	if hitPlayer == localPlayer then
		if matchingDimension then
			guiSetVisible(GUIEditor.window[1], true)
			showCursor(true)
			temp[localPlayer] = getElementModel(localPlayer)
		end
	end
end

function onClientPressClose(btn)
	if source ~= GUIEditor.button[1] then return end
	if btn ~= "left" then return end
	guiSetVisible(GUIEditor.window[1], false)
	showCursor(false)
	if temp[localPlayer] ~= nil then
		setElementModel(localPlayer, temp[localPlayer])
		temp[localPlayer] = nil
	end
end
addEventHandler("onClientGUIClick", resourceRoot, onClientPressClose)


function testingSkins(btn)
	if source ~= GUIEditor.gridlist[1] then return end
	if btn ~= "left" then return end
	local skinName = guiGridListGetItemText(GUIEditor.gridlist[1], guiGridListGetSelectedItem (GUIEditor.gridlist[1]), 1)
	if skinName == "" or skinName == nil then return false end
	for _, v in ipairs(skins) do
		if v[1] == skinName then
			setElementModel(localPlayer, v[2])
		end
	end
end
addEventHandler("onClientGUIClick", resourceRoot, testingSkins)

function onClientPressBuy(btn)
	if source ~= GUIEditor.button[2] then return end
	if btn ~= "left" then return end
	if getPlayerMoney() < 500 then return outputChatBox("[Skin Shop] #FFFFFFYou do not have sufficient money to buy this skin!", 255, 0, 0, true) end
	local skinName = guiGridListGetItemText(GUIEditor.gridlist[1], guiGridListGetSelectedItem (GUIEditor.gridlist[1]), 1)
	if skinName == "" or skinName == nil then return outputChatBox("[Skin Shop] #FFFFFFPlease select skins from gridlist!", 255, 0, 0, true) end
	for _, v in ipairs(skins) do
		if v[1] == skinName then
			triggerServerEvent("UGCskins.changeSkin", resourceRoot, v[2], skinName)
		if temp[localPlayer] ~= nil then
		setElementModel(localPlayer, temp[localPlayer])
		temp[localPlayer] = nil
		end
		end
	end
end
addEventHandler("onClientGUIClick", resourceRoot, onClientPressBuy)