--function onInit()
--	ActionsManager.registerResultHandler("twod6result", onRollResult);
--end
--
--function onRollResult(rSource, rTarget, rRoll)
--	local nTotal = ActionsManager.total(rRoll);
--	local nMod = rRoll.nMod or 0;
--
--	local sOutcome = "";
--
--	if nTotal < 7 then
--		sOutcome = "Failure";
--	elseif nTotal > 9 then
--		sOutcome = "Success";
--	else
--		sOutcome = "Mixed";
--	end
--
--	local msg = ActionsManager.createActionMessage(rSource, rRoll);
--
--	msg.text = msg.text .. "\nModifier: " .. nMod;
--	msg.text = msg.text .. "\nTotal: " .. nTotal;
--	msg.text = msg.text .. "\nResult: " .. sOutcome;
--
--	Comm.deliverChatMessage(msg);
--end
function onInit()
	ActionsManager.registerResultHandler("twod6result", onRollResult);
end

function onRollResult(rSource, rTarget, rRoll)
	local nTotal = ActionsManager.total(rRoll);
	local nMod = rRoll.nMod or 0;

	local nDie1 = 0;
	local nDie2 = 0;

	if rRoll.aDice then
		if rRoll.aDice[1] then
			nDie1 = rRoll.aDice[1].result or 0;
		end
		if rRoll.aDice[2] then
			nDie2 = rRoll.aDice[2].result or 0;
		end
	end

	local bSnakeEyes = nDie1 == 1 and nDie2 == 1;
	local bBoxCars = nDie1 == 6 and nDie2 == 6;

	local sOutcome = "";
	local sIcon = "";

	if bSnakeEyes then
		sOutcome = "Failure - Snake Eyes";
		sIcon = "action_save_failure_crit";
	elseif bBoxCars then
		sOutcome = "Success - Boxcars";
		sIcon = "action_save_success_crit";
	elseif nTotal < 7 then
		sOutcome = "Failure";
		sIcon = "action_save_failure";
	elseif nTotal > 9 then
		sOutcome = "Success";
		sIcon = "action_save_success";
	else
		sOutcome = "Mixed";
		sIcon = "action_modifier";
	end


	local msg = ActionsManager.createActionMessage(rSource, rRoll);
	
	if sIcon ~= "" then
		msg.icon = sIcon;
	end

	msg.text = msg.text or "";

--	msg.text = msg.text .. "\nDice: " .. nDie1 .. " + " .. nDie2;
	msg.text = msg.text .. "Result: " .. sOutcome;
	
--Need to read rules on Power at least 1
--	if nMod < 1 then
--		nMod = 1
--	else
--	end
	
	msg.text = msg.text .. "\nPower: " .. nMod;
	
--Need to read rules on if 10+ is +1 power
--	if nTotal > 9 then
--		msg.text = msg.text .. " + 1"
--	else
--	end 


--	msg.text = msg.text .. "\nTotal: " .. nTotal;
--	msg.text = msg.text .. "\nResult: " .. sOutcome;

--	if bSnakeEyes then
--		msg.text = msg.text .. "\nResult: Failure - Double 1s";
--	elseif bBoxCars then
--		msg.text = msg.text .. "\nResult: Success - Double 6s";
--	else
--		msg.text = msg.text .. "\nResult: " .. sOutcome;
--	end

	Comm.deliverChatMessage(msg);
end
