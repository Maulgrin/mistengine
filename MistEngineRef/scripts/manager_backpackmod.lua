function onInit()
	OOBManager.registerOOBMsgHandler("backpackitemmod", handleBackpackItemMod);
	OOBManager.registerOOBMsgHandler("scratchitemmod", handleScratchItemMod);
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

function sendBackpackItemModMessage(sActorName, sItemName, nMod)
	local msgOOB = {};
	msgOOB.type = "backpackitemmod";
	msgOOB.sActorName = sActorName or "Unknown Actor";
	msgOOB.sItemName = sItemName or "Item";
	msgOOB.nMod = tonumber(nMod) or 1;

	if Session.IsHost then
		handleBackpackItemMod(msgOOB);
	else
		Comm.deliverOOBMessage(msgOOB, "");
	end
end

function handleBackpackItemMod(msgOOB)
	local sActorName = msgOOB.sActorName or "Unknown Actor";
	local sItemName = msgOOB.sItemName or "Item";
	local nMod = tonumber(msgOOB.nMod) or 1;

	sendModMessageToAll(sActorName .. " added " .. sItemName .. " " .. getModifierText(nMod));
end

function sendScratchItemModMessage(sActorName, sItemName, nMod)
	local msgOOB = {};
	msgOOB.type = "scratchitemmod";
	msgOOB.sActorName = sActorName or "Unknown Actor";
	msgOOB.sItemName = sItemName or "Item";
	msgOOB.nMod = tonumber(nMod) or 3;

	if Session.IsHost then
		handleScratchItemMod(msgOOB);
	else
		Comm.deliverOOBMessage(msgOOB, "");
	end
end

function handleScratchItemMod(msgOOB)
	local sActorName = msgOOB.sActorName or "Unknown Actor";
	local sItemName = msgOOB.sItemName or "Item";
	local nMod = tonumber(msgOOB.nMod) or 3;

	sendModMessageToAll(sActorName .. " scratched " .. sItemName .. " " .. getModifierText(nMod));
end