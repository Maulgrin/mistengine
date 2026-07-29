function onInit()
	OOBManager.registerOOBMsgHandler("relationshipmod", handleRelationshipMod);
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

function handleRelationshipMod(msgOOB)
	local sActorName = msgOOB.sActorName or "Unknown Actor";
	local sModName = msgOOB.sModName or "Relationship";
	local nMod = tonumber(msgOOB.nMod) or 1;

	sendModMessageToAll(sActorName .. " added " .. sModName .. " " .. getModifierText(nMod));
end