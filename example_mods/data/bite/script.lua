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
		debugPrint('Started 1 tap, EXCUTED COUNTDOWN')
	end
	if mouseClicked('left') and twoT then
		stopped = false
		startCountdown()
		debugPrint('Started 2 tap, EXCUTED COUNTDOWN WITH CONTINUE')
	end
end --[TROUBLESHOOTING]
