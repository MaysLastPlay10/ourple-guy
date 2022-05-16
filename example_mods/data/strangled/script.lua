-- Script by Shadow Mario
-- Customized for Simplicity by Kevin Kuntz
function onCreate()
	makeAnimationList();
	makeOffsets();
	
	makeAnimatedLuaSprite('dee', 'characters/dee_Assets', 4300.15, 4791.75);
	addAnimationByPrefix('dee', 'idle', 'dee idle', 30, false);
	addAnimationByPrefix('dee', 'singLEFT', 'left', 30, false);
	addAnimationByPrefix('dee', 'singDOWN', 'down', 30, false);
	addAnimationByPrefix('dee', 'singUP', 'up', 30, false);
	addAnimationByPrefix('dee', 'singRIGHT', 'right', 30, false);
	addAnimationByPrefix('dee', 'die', 'dee dead', 30, true);
	setObjectOrder('dee', getObjectOrder('steven') - 1)
	
	addLuaSprite('dee', true);

	playAnimation('dee', 'idle', true);
end

animationsList = {}
holdTimers = {dee = 10.0};
singAnimations = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'};
function makeAnimationList()
	animationsList['idle'] = 'idle';
	animationsList['singLEFT'] = 'singLEFT';
	animationsList['singDOWN'] = 'singDOWN';
	animationsList['singUP'] = 'singUP';
	animationsList['singRIGHT'] = 'singRIGHT';
	animationsList['die'] = 'die';
end

offsetsdee = {};
function makeOffsets()
	offsetsdee['idle'] = {x = 0, y = 0}; --idle
	offsetsdee['singLEFT'] = {x = 170, y = -25}; --left
	offsetsdee['singDOWN'] = {x = -150, y = -310}; --down
	offsetsdee['singUP'] = {x = -190, y = 40}; --up
	offsetsdee['singRIGHT'] = {x = -237, y = 0}; --right
	offsetsdee['die'] = {x = -61, y = -271}; --die
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'Special Sing' then
		if not isSustainNote then
			animToPlay = singAnimations[direction+1];
		end	
		characterToPlay = 'dee'
		holdTimers.dee = 0;
				
		playAnimation(characterToPlay, animToPlay, true);
	end
	
	if noteType == 'Spite Note' then
		local charPick = math.random(1,3)
		local charName = ''
		
		if charPick == 1 then 
			charName = 'dee'
		elseif charPick == 2 then
			charName = 'bf'
		elseif charPick == 3 then
			charName = 'gf'
		end
		
		
		if charPick == 1 then 
			playAnimation(charName, 'singLEFT', true);
		elseif charPick == 2 or charPick == 3 then
			triggerEvent('Play Animation', 'singLEFT', charName)
		end
	end
end

function onUpdate(elapsed)
	holdCap = stepCrochet * 0.004;
	if holdTimers.dee >= 0 then
		holdTimers.dee = holdTimers.dee + elapsed;
		if holdTimers.dee >= holdCap then
			playAnimation('dee', 'idle', false);
			holdTimers.dee = -1;
		end
	end
end

function onCountdownTick(counter)
	beatHitDance(counter);
end

function onBeatHit()
	beatHitDance(curBeat);
end

function beatHitDance(counter)
	if counter % 2 == 0 then
		if holdTimers.dee < 0 and getProperty('dee.animation.curAnim.name') ~= 'die' then
			playAnimation('dee', 'idle', false);
		end
	end
end

function playAnimation(character, animId, forced)
	-- 0 = idle
	-- 1 = singLEFT
	-- 2 = singDOWN
	-- 3 = singUP
	-- 4 = singRIGHT
	animName = animationsList[animId];
	--debugPrint(animName);
	objectPlayAnimation(character, animName, forced); -- this part is easily broke if you use objectPlayAnim (I have no idea why its like this)
	offsetTable = offsetsdee
	setProperty(character..'.offset.x', offsetTable[animId].x);
	setProperty(character..'.offset.y', offsetTable[animId].y);
end

function onEvent(n,v1,v2)

	if n == 'Object Play Animation' then
		playAnimation(v1,v2,true)
	end

end