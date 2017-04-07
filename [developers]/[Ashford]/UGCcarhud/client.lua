



function getState( bNum, sType )
	if not ( isPedInVehicle( localPlayer ) ) then return end 
    veh = getPedOccupiedVehicle( localPlayer ) 
	if ( veh ) then 
		if ( bNum == 2 and sType == "health" ) then
		    health = veh.health 
		    if ( health >= 1000 ) then
		    	vHealth = 100
		    else
		    	vHealth = math.floor( health / 10 )
		    end
		    if ( vHealth >= 80 ) then 
		    	result = tocolor( 0, 255, 0 )
		    elseif ( vHealth < 80 and vHealth >= 60 ) then 
		    	result = tocolor( 255, 102, 0 )
		    elseif ( vHealth < 60 and vHealth >= 40 ) then 
		    	result = tocolor( 255, 255, 0 )
		    elseif ( vHealth < 40 ) then 
		    	result = tocolor( 255, 0, 0 )
		    end
		    return result 
		elseif ( bNum == 2 and sType == "width" ) then 
			health = veh.health 
			if ( health >= 1000 ) then 
				width = 200
			else
				width =  math.floor( health/10 ) * 2 
			end
			return width 
		elseif ( bNum == 3 and sType == "health" ) then
			return tocolor( 255, 255, 255 )
		elseif ( bNum == 3 and sType == "width" ) then 
            return 200 --veh:getData("vehFuel") * 2
        elseif ( bNum == 1 and sType == "health" ) then 
            return tocolor( 17, 128, 247 )
        elseif ( bNum == 1 and sType == "width" ) then 
        	sX, sY, sZ = getElementVelocity( veh )
        	currentSpeed = math.sqrt( sX^2 + sY^2 + sZ^2 ) * 180
            return currentSpeed
	    end
	end
end


addEventHandler("onClientResourceStart", resourceRoot, 
	function()
		drawIt()
		addEventHandler("onClientRender", root, drawIt )
	end
	)

x, y = guiGetScreenSize()

bars_DATA = {
	{x * 0.81, y * 0.87, 1},
	{x * 0.81, y * 0.90, 2},
	{x * 0.81, y * 0.93, 3}

}


function drawIt()
	if isPedInVehicle( localPlayer ) then
       for k, v in ipairs( bars_DATA ) do 
       	    if ( getPedOccupiedVehicle( localPlayer ) ) then 
       	    	barWidth = getState( v[3], "width" )
       	    	if ( barWidth >= 200 ) then 
       	    		barWidth = 200 
       	    	else
       	    		barWidth = getState( v[3], "width" )
       	    	end
				dxDrawRectangle( v[1], v[2], barWidth, 20, getState( v[3], "health" ), false )
				if ( getVehicleNitroCount( getPedOccupiedVehicle( localPlayer ) ) ) then 
					nosPath = "img/nosful.png"
				else
					nosPath = "img/nosemp.png"
				end
	
				dxDrawImage( x * 0.774, y * 0.909, 30, 40, nosPath )
	
				if ( isVehicleLocked( getPedOccupiedVehicle( localPlayer ) ) ) then 
					lockedPath = "img/locked.png"
				else
					lockedPath = "img/unlocked.png"
				end
				dxDrawImage( x * 0.774, y * 0.87, 30, 30, lockedPath )
	
	
				dxDrawLine(x * 0.763, y * 0.859, x * 0.763, y * 0.859 + 100, tocolor( 0, 0, 0, 255), 1.2 )
            	dxDrawLine(x * 0.763, y * 0.859 + 100, x * 0.763 + 270, y * 0.859 + 100, tocolor( 0, 0, 0, 255), 1.2 )
            	dxDrawLine(x * 0.763 + 270, y * 0.859 + 100, x * 0.763 + 270, y * 0.859, tocolor( 0, 0, 0, 255), 1.2 )
            	dxDrawLine(x * 0.763 + 270, y * 0.859, x * 0.763, y * 0.859, tocolor( 0, 0, 0, 255), 1.2 )

				dxDrawLine(v[1], v[2], v[1], v[2] + 20,tocolor( 0, 0, 0, 255) )
            	dxDrawLine(v[1], v[2] + 20, v[1] + 200, v[2] + 20, tocolor( 0, 0, 0, 255) )
            	dxDrawLine(v[1] + 200, v[2] + 20, v[1] + 200, v[2], tocolor( 0, 0, 0, 255) )
            	dxDrawLine(v[1] + 200, v[2], v[1], v[2], tocolor( 0, 0, 0, 255) )
            	dxDrawText( math.ceil( getState( 1, "width" ) ) .." KM/H", x * 0.81, y * 0.87, 200+x * 0.81, 25+y * 0.87, tocolor( 255, 255, 255 ), 1, "default-bold", "center", "center", true, false, false )
            	dxDrawText( math.floor( getPedOccupiedVehicle( localPlayer ).health/10 ).."%", x * 0.81, y * 0.90, 200+x * 0.81, 25+y * 0.90, tocolor( 255, 255, 255 ), 1, "default-bold", "center", "center", true, false, false )
            	--dxDrawText( 0.."%", x * 0.81, y * 0.93, 200+x * 0.81, 25+y * 0.93, tocolor( 0, 0, 0 ), 1, "default-bold", "center", "center", true, false, false )
            else
            	return 
            end
        end
    end
end

