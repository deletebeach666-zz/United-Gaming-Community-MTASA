

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

addEventHandler("onClientResourceStart", root, 
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

