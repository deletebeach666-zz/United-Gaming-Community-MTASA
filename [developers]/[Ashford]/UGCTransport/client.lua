
UGCTT = {
    gridlist = {},
    window = {},
    button = {},
    label = {},
    edit = {}
}


        UGCTT.window[1] = guiCreateWindow( 443, 296, 395, 433, "UGC ~ Teleport", false)
        guiWindowSetSizable(UGCTT.window[1], false)
        guiSetVisible( UGCTT.window[1], false )

        UGCTT.label[1] = guiCreateLabel(31, 23, 337, 53, "Select the desired location and click \" Teleport \" to warp, \nclick \" Close \" if you want to close the panel", false, UGCTT.window[1])
        
        UGCTT.edit[1] = guiCreateEdit(29, 70, 339, 25, "Search for location...", false, UGCTT.window[1])    
        
        UGCTT.gridlist[1] = guiCreateGridList(29, 100, 339, 269, false, UGCTT.window[1])

        UGCTT.button[1] = guiCreateButton(28, 374, 340, 24, "Teleport", false, UGCTT.window[1])
        UGCTT.button[2] = guiCreateButton(29, 402, 340, 21, "Close", false, UGCTT.window[1])      

        guiSetFont(UGCTT.label[1], "default-bold-small")
        guiLabelSetHorizontalAlign(UGCTT.label[1], "center", false)
        guiLabelSetVerticalAlign(UGCTT.label[1], "center")        
        guiSetFont(UGCTT.button[1], "default-bold-small")
        guiSetFont(UGCTT.button[2], "default-bold-small") 

-- Gridlist Columns 

        guiGridListAddColumn(UGCTT.gridlist[1], "Location", 0.5)
        guiGridListAddColumn(UGCTT.gridlist[1], "Cost $", 0.5)


function centerWindow() 
    local screenW,screenH=guiGetScreenSize() 
    local windowW,windowH=guiGetSize(UGCTT.window[1],false) 
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2 
    guiSetPosition(UGCTT.window[1],x,y,false) 
end 

function createMarkers()
	for _, v in ipairs( destinations ) do 
		theMarker = Marker( v[2], v[3], v[4], "cylinder", 2, 0, 255, 0, 150 )
		theMarkerName = v[1]
		theMarker:setData( "UGCTTM.title", theMarkerName )
		addEventHandler("onClientMarkerHit", theMarker, showGUI)
	end 
end 
addEventHandler("onClientResourceStart", resourceRoot, createMarkers )


function showGUI( hit, dim )
    if ( hit == localPlayer ) then
        if ( dim ) then 
        	guiGridListClear( UGCTT.gridlist[1] )
        	if ( isPedInVehicle( localPlayer ) ) then outputChatBox("Exit your vehicle before using this feature.", 255, 0, 0 ) return end
		    local data = getInformation( )
		    if ( data ) then 
			    for _, inf in ipairs( data ) do 
					local row = guiGridListAddRow( UGCTT.gridlist[1] )
					guiGridListSetItemText( UGCTT.gridlist[1], row, 1, inf[1], false, false )
					guiGridListSetItemText( UGCTT.gridlist[1], row, 2, "$"..inf[2], false, false )
					if ( inf[2] > getPlayerMoney( localPlayer ) ) then 
						guiGridListSetItemColor( UGCTT.gridlist[1], row, 2, 255, 0, 0)
					else
						guiGridListSetItemColor( UGCTT.gridlist[1], row, 2, 0, 255, 0)
					end
				end 
			end 
			local _, _, mz = getElementPosition( source ) 
			local _, _, pz = getElementPosition( localPlayer ) 
			if ( math.abs( pz-mz ) > 2 ) then return false end
			guiSetText( UGCTT.window[1], getMarkerName().." | Teleport Point" )
			guiSetVisible( UGCTT.window[1], true ) 
			localPlayer.frozen = true
			showCursor( true ) 
		end 
	end 
end


addEventHandler("onClientGUIChanged", root, 
    function() 
        if ( source == UGCTT.edit[1] ) then 
            guiGridListClear(UGCTT.gridlist[1]) 
            if ( guiGetText( UGCTT.edit[1] ) == "number" ) then return end
            for i, v in ipairs( destinations ) do 
                if string.find( string.lower( string.gsub( v[1], "#%x%x%x%x%x%x", "")), string.lower( guiGetText( source ) ) ) then 
                	local row = guiGridListAddRow( UGCTT.gridlist[1] )
                    guiGridListSetItemText( UGCTT.gridlist[1], row, 1, v[1], false, false) 
                    cost = getCost( v[1] )
                    guiGridListSetItemText( UGCTT.gridlist[1], row, 2, "$"..cost, false, false)
                    if ( cost > getPlayerMoney( localPlayer ) ) then 
						guiGridListSetItemColor( UGCTT.gridlist[1], row, 2, 255, 0, 0)
					else
						guiGridListSetItemColor( UGCTT.gridlist[1], row, 2, 0, 255, 0)
					end

                end 
            end 
        end 
    end 
) 

addEventHandler("onClientGUIFocus", root, 
	function()
		if ( source == UGCTT.edit[1] ) then
			if guiGetText( source ) == "Search for location..." then
				guiSetText( source, "" )
			end
		end 
	end 
)


function onClick()
	if ( source == UGCTT.button[1] ) then 
		local row = guiGridListGetSelectedItem( UGCTT.gridlist[1] )
		local destinationName = guiGridListGetItemText( UGCTT.gridlist[1], row, 1 )
		local cost = getCost( destinationName ) 
		if ( localPlayer:getData("UGCTT.teleporting") ) then outputChatBox("You're already teleporting.", 255, 0, 0 ) return end
		if ( row == -1 or row == nil ) then outputChatBox("You didn't select a destination.", 255, 0, 0 ) return end 
		if ( not cost ) then outputChatBox("Something went wrong, contact the developer.(Cost)", 255, 0, 0 ) return end
		if ( cost > getPlayerMoney( localPlayer ) ) then outputChatBox("You don't have enough money to teleport.", 255, 0, 0 ) return end
    	if ( cost < 100 ) then outputChatBox("You are already at "..destinationName..".", 255, 0, 0 ) return end
		teleportTo( destinationName, cost )
		if guiGetVisible( UGCTT.window[1] ) then guiSetVisible( UGCTT.window[1], false ) guiSetText( UGCTT.edit[1], "Search for location..." ) end
	elseif ( source == UGCTT.button[2] ) then 
		if ( guiGetVisible( UGCTT.window[1] ) ) then 
			guiSetVisible( UGCTT.window[1], false ) 
			if localPlayer.frozen then localPlayer.frozen = false end 
			if isCursorShowing() then showCursor( false ) end 
            guiSetText( UGCTT.edit[1], "Search for location..." )
		end 
	end 
end 
addEventHandler("onClientGUIClick", resourceRoot, onClick)




function teleportTo( destinationName, cost ) 
    local x, y, z = getElementPosition( source ) 
    for _, v in ipairs( destinations ) do 
    	if ( destinationName == v[1] ) then 
    		takePlayerMoney( cost )
    		local locX, locY, locZ = v[2], v[3], v[4]
    		local cX, cY, cZ, rX, rY, rZ, _, _ = getCameraMatrix( source )
    		fadeCamera( false, 2.3, 0, 0, 0 ) 
    		localPlayer:setData("UGCTT.teleporting", true )
			Timer( function() fadeCamera( true, 1.0 ) end, 700, 1 )
			Timer( function() smoothMoveCamera( cX, cY, cZ+150, cX, cY, cZ, locX, locY, locZ+150, locX, locY, locZ, 3000)  end, 700, 1)
			Timer( 
				function() 
					localPlayer:setData("UGCTT.teleporting", false) 
					setCameraTarget( localPlayer ) 
					localPlayer.position = Vector3( locX, locY, locZ+3 ) 
					if isCursorShowing() then showCursor( false ) end 
					if localPlayer.frozen then localPlayer.frozen = false end
					outputChatBox("You've arrived to your destination ! ( "..destinationName.." )", 0,255,0 )
			    end, 
			4000, 1 )
		end 
	end 
end 