local stopped = true
local twoT = false
function onStartCountdown()
	if stopped then
		return Function_Stop;
	else
		return Function_Continue;
	end
end

function onUpdate()
	if mouseClicked('left') and not twoT then
		--stopped = false
		startCountdown()
		twoT = true
	end
	if mouseClicked('left') and twoT then
		stopped = false
		startCountdown()
	end
end --[TROUBLESHOOTING]
