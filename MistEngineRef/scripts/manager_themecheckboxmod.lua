function onInit()
	OOBManager.registerOOBMsgHandler("themecheckboxmod", handleThemeCheckboxMod);
end

function getModifierText(nMod)
	if nMod >= 0 then
		return "+" .. nMod;
	end

	return tostring(nMod);
end

function sendModMessageToAll(sText)
	local msg = {};
	msg.font = "systemfont";
	msg.text = sText;

	Comm.deliverChatMessage(msg);
end

function handleThemeCheckboxMod(msgOOB)
	local sActorName = msgOOB.sActorName or "Unknown Actor";
	local sModName = msgOOB.sModName or "Mod";
	local nMod = tonumber(msgOOB.nMod) or 1;

	sendModMessageToAll(sActorName .. " added " .. getModifierText(nMod) .. " from " .. sModName);
end
