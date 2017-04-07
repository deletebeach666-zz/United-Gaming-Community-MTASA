local posX, posY = guiGetScreenSize()

function loadingBar()
	dxDrawRectangle( posX * 0.305, posY * 0.375, 515, 60, tocolor( 255, 255, 0 ) )
	dxDrawRectangle( posX * 0.31, posY * 0.38, 500, 50, tocolor( 0, 0, 0 ) )
    

	dxDrawRectangle( posX * 0.318, posY * 0.39, getProgress(), 30, tocolor( 255, 255, 0 ) )


	dxDrawLine(posX * 0.318, posY * 0.39, posX * 0.318, posY * 0.39 + 30, tocolor( 255, 255, 0, 255), 1 )
    dxDrawLine(posX * 0.318, posY * 0.39 + 30, posX * 0.318 + 480, posY * 0.39 + 30, tocolor( 255, 255, 0, 255), 1 )
    dxDrawLine(posX * 0.318 + 480, posY * 0.39 + 30, posX * 0.318 + 480, posY * 0.39, tocolor( 255, 255, 0, 255), 1 )
    dxDrawLine(posX * 0.318 + 480, posY * 0.39, posX * 0.318, posY * 0.39, tocolor( 255, 255, 0, 255), 1 )
    dxDrawText( "70%", posX * 0.318, posY * 0.39, 480+posX * 0.318, 33+posY * 0.39, tocolor( 0, 0, 0 ), 1.3, "pricedown", "center", "center", true, false, false )

end
addEventHandler("onClientRender", root, loadingBar )


fixing = false 

function onFixVehicle()
	fixing = true 
	localPlayer:setData("fixingVehicle", 0 )
    localPlayer:setData("fixingVehicle", localPlayer:getData("fixingVehicle") + 1 )
	Timer( onFixVehicle, 500, 0 )
end
addCommandHandler("testfix", onFixVehicle)

function getProgress() 
	if ( fixing ) then 
		width = localPlayer:getData("fixingVehicle")
		if ( width >= 480 ) then 
			width = 480
		else
			width = localPlayer:getData("fixVehicle")
		end
		return width 
	else
		return
	end
end