function givePayment (hitPlayer)
	local payment = exports.UGCemployment:getPlayerJobPayment(hitPlayer, "Pizza Boy", "static")
    exports.UGCemployment:givePlayerJobMoney(hitPlayer, "Pizza Boy", payment, "+ $"..payment.." Earned", "+1 Pizza Deliveries")
    exports.UGCemployment:givePlayerProgress(hitPlayer, "Pizza Boy", 1)
end 
addEvent("UGCpizzaboy:givePayment", true)
addEventHandler("UGCpizzaboy:givePayment", root,givePayment)