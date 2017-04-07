fuelLocs = {
    {-1672.05, 405.35, 6.85 },
	{-1666.75, 410.37, 6.85 },
	{-1679.24, 412.21, 6.85 },
	{-1673.81, 417.5, 6.85 },
	{-2407.49, 971.53, 44.97 },
	{-2407.56, 982.32, 44.97 },
	{-2414.68, 980.48, 44.97 },
	{-2414.68, 970.04, 44.97 },
	{-2249.57, -2558.71, 31.58 },
	{-2239.06, -2563.1, 31.6 },
	{-2244.82, -2561.4, 31.6 },
	{-95, -1161.41, 1.91 },
	{-99.95, -1173.21, 2.12 },
	{-88.1, -1164.68, 1.96 },
	{-92.88, -1176.37, 1.88 },
	{1378.92, 458.36, 19.61 },
	{1383.41, 456.51, 19.61 },
	{1385.15, 461.04, 19.8 },
	{1380.73, 463.16, 19.8 },
	{652.66, -560.14, 16.01 },
	{652.74, -570.98, 16.01 },
	{658.22, -569.71, 16.01 },
	{658.27, -558.89, 16.01 },
	{1590.09, 2190.96, 10.82 },
	{1601.8, 2190.69, 10.82 },
	{1590.38, 2196.61, 10.82 },
	{1601.84, 2196.18, 10.82 },
	{1602.17, 2202.28, 10.82 },
	{1590.28, 2201.79, 10.82 },
	{1596, 2206.69, 10.82 },
	{2141.41, 2756.27, 10.82 },
	{2153.37, 2756.49, 10.82 },
	{2153.23, 2750.65, 10.82 },
	{2141.55, 2750.51, 10.82 },
	{2147.46, 2740.06, 10.82 },
	{2194.45, 2470.04, 10.82 },
	{2194.61, 2480.42, 10.82 },
	{2205.36, 2480.33, 10.82 },
	{2205.01, 2469.95, 10.82 },
	{622.3, 1679.94, 6.99 },
	{618.93, 1684.98, 6.99 },
	{615.32, 1689.81, 6.99 },
	{612.02, 1694.95, 6.99 },
	{608.64, 1699.88, 6.99 },
	{605.27, 1704.75, 6.99 },
	{2120.77, 928.59, 10.82 },
	{2108.88, 928.72, 10.82 },
	{2120.69, 917.61, 10.82 },
	{2109.05, 917.79, 10.82 },
	{2634.68, 1097.78, 10.82 },
	{2645.61, 1097.5, 10.82 },
	{2645.34, 1109.25, 10.82 },
	{2634.64, 1109.06, 10.82 },
	{283.12, 2000.55, 17.64 },
	{282.15, 2033.92, 17.64 },
	{64.56, 1219.51, 18.82 },
	{70.53, 1218.7, 18.81 },
	{76.42, 1217.21, 18.82 },
	{-1328.92, 2672.1, 50.06 },
	{-1327.91, 2677.47, 50.06 },
	{-1327.51, 2682.94, 50.06 },
	{-1477.61, 1857.44, 32.63 },
	{-1464.91, 1857.88, 32.63 },
	{-1465.24, 1865.8, 32.63 },
	{-1477.75, 1865.01, 32.63 },
	{999.97, -940, 42.17 },
	{1007.03, -939.19, 42.17 },
	{1007.75, -933.45, 42.17 },
	{1000.55, -934.48, 42.17 },
	{1944.29, -1776.53, 13.39 },
	{1944.3, -1769.2, 13.39 },
	{1938.93, -1769.1, 13.38 },
	{1938.91, -1776.63, 13.39 },
	{-742.21, 2751.14, 47.22 },
	{-1602.46, -2709.84, 48.53 },
	{-1605.85, -2714.2, 48.53 },
	{-1609.22, -2718.53, 48.53 },
	{1943.16, -2643.56, 13.54 },
	{1973.68, -2642.29, 13.54 },
	{2006.33, -2641.51, 13.54 },
	{2042.73, -2640.8, 13.54 },
	{11332.48, 1571.46, 10.82 },
	{11332.54, 1609.93, 10.82 },
	{-1308.82, 25.31, 14.14 },
	{-1292.43, 8.07, 14.14 },
	{-1275.06, -9.45, 14.14 },
	{1326.45, 1391.54, 10.47 },
	{1910.71, -2335.42, 13.25 },
	{-2175.83, 2427.19, 0.75 },
	{2372.07, 505.63, 0.47 },
	{2285.01, -2501.6, 0.61 },
	{-11.01, -1656.07, 0.53 },
}

addEventHandler("onClientResourceStart", resourceRoot,
    function()
    	for i=1,#fuelLocs do
    		 outputDebugString("Created markers")
    		 local fuelMarker = Marker( fuelLocs[i][1], fuelLocs[i][2], fuelLocs[i][3]-1, "cylinder", 2.5, 255, 0, 0, 100 )
    		 if ( fuelMarker ) then 
    		    addEventHandler("onClientMarkerHit", fuelMarker, onFuelMarkerHit, false )
    		 end
    	end    	
    end
)

refueling = false
engineMessage = true 
function onFuelMarkerHit( h, d )
	outputDebugString("Running..")
	if ( h and d ) then 
		if ( h.vehicle ) then 
			outputChatBox("In.."..h.name)
			if ( getVehicleSpeed( h.vehicle ) > 0 ) then  outputChatBox("Your vehicle should be completely stopped.", 255, 0, 0 ) Timer( onFuelMarkerHit, 1500, 1, localPlayer, true ) return end
			if ( getVehicleEngineState( h.vehicle ) ) then  outputChatBox("Turn off your engine before refueling.") Timer( onFuelMarkerHit, 1500, 1, localPlayer, true ) return end
			if ( localPlayer.vehicle:getData("vehFuel") >= 100 ) then  outputChatBox("You already have a full can.", 255, 0, 0 ) return end 
			bindKey("space", "down", refuelVehicle )
			refueling = true
		end
	end
end

function getVehicleSpeed( vehicle )
	if ( not vehicle ) then return end 
	local speedX, speedY, speedZ = getElementVelocity( vehicle ) 
	if ( speedX ) then 
		vehicleCurrentSpeed = math.ceil( math.sqrt( speedX^2 + speedY^2 + speedZ^2 ) )
	end
	outputDebugString("Returned speed")
	return vehicleCurrentSpeed
end

addEventHandler("onClientVehicleEnter", root, 
	function( plr, st ) 
		if ( plr == localPlayer ) and ( st == 0 ) then 
			if ( not localPlayer.vehicle:getData("vehFuel") ) then 
				localPlayer.vehicle:setData( "vehFuel", 100 ) 
			else
				if ( localPlayer.vehicle:getData("vehFuel") <= 0 ) then 
					setVehicleEngineState( localPlayer.vehicle, false )
					toggleControl("brake_reverse", false )
					toggleControl("acceleration", false )
				else
					if ( not getVehicleEngineState( localPlayer.vehicle ) ) then 
						setVehicleEngineState( localPlayer.vehicle, true ) 
						toggleControl("brake_reverse", true )
						toggleControl("acceleration", true )
					end
				end
			end
		end
	end
)

addEventHandler("onClientResourceStart", resourceRoot, 
	function()
		if ( localPlayer.vehicle and getVehicleOccupant( localPlayer.vehicle, 0 ) == localPlayer ) then 
			if ( not  localPlayer.vehicle:getData("vehFuel") ) then 
				localPlayer.vehicle:setData( "vehFuel", 100 ) 
			else
				if ( localPlayer.vehicle:getData("vehFuel") <= 0 ) then 
					setVehicleEngineState( localPlayer.vehicle, false )
					toggleControl("brake_reverse", false )
					toggleControl("acceleration", false )
				else
					if ( not getVehicleEngineState( localPlayer.vehicle ) ) then 
						setVehicleEngineState( localPlayer.vehicle, true ) 
						toggleControl("brake_reverse", true )
						toggleControl("acceleration", true )
					end
				end
			end		
			vFuelTimer = Timer( decreaseFuelPercent, 50000, 0 )
		end
	end 
)


function decreaseFuelPercent()		
	if ( localPlayer.vehicle and getVehicleOccupant( localPlayer.vehicle, 0 ) == localPlayer  and localPlayer.vehicle:getData("vehFuel") > 0 ) then 
		localPlayer.vehicle:setData("vehFuel", localPlayer.vehicle:getData("vehFuel") - 1 )
		if ( localPlayer.vehicle:getData("vehFuel") <= 0 ) then 
			localPlayer.vehicle:setData("vehFuel", 0 )
			setVehicleEngineState( localPlayer.vehicle, false )
			toggleControl("brake_reverse", false )
			toggleControl("acceleration", false )
			outputChatBox("Your fuel is over")
		end
	end
end







message = true
function refuelVehicle( )
	if ( localPlayer.vehicle ) then 
		if ( getVehicleOccupant( localPlayer.vehicle, 0 ) ) then 
			neededPrice = ( 100 - localPlayer.vehicle:getData("vehFuel") ) * 10
			neededFuel = ( 100 - localPlayer.vehicle:getData("vehFuel") )
			if ( localPlayer.vehicle:getData("vehFuel") >= 100 and refueling == true ) then  outputChatBox("You've successfuly refueled your vehicle.") return end
			if ( getPlayerMoney( localPlayer ) < neededPrice ) then return outputChatBox("Not enough money.") end 
			if ( message == true ) then outputChatBox("Refueling...") message = false end

			localPlayer.vehicle:setData("vehFuel", localPlayer.vehicle:getData("vehFuel") + 1 )

			takePlayerMoney( neededPrice )
			unbindKey("space","down", refuelVehicle )
			--bindKey("space","up", quitrefuelVehicle )
			Timer( refuelVehicle, 500, 1 )
		end
	end
end
