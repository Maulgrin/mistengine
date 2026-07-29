---- scripts/manager_modbutton.lua
--
--function onInit()
--	OOBManager.registerOOBMsgHandler("modbuttonmessage", handleModButtonMessage);
--end
--
--function getModifierText(nMod)
--	nMod = tonumber(nMod) or 0;
--
--	if nMod >= 0 then
--		return "+" .. nMod;
--	end
--
--	return tostring(nMod);
--end
--
--function broadcastModButtonMessage(sActorName, nMod)
--	local msg = {};
--	msg.font = "systemfont";
--	msg.text = sActorName .. " added " .. getModifierText(nMod);
--
--	Comm.deliverChatMessage(msg);
--end
--
--function sendModButtonMessage(sActorName, nMod)
--	nMod = tonumber(nMod) or 0;
--
--	if Session.IsHost then
--		broadcastModButtonMessage(sActorName, nMod);
--		return;
--	end
--
--	local msgOOB = {};
--	msgOOB.type = "modbuttonmessage";
--	msgOOB.sActorName = sActorName or "Actor";
--	msgOOB.nMod = nMod;
--
--	Comm.deliverOOBMessage(msgOOB, "");
--end
--
--function handleModButtonMessage(msgOOB)
--	if not Session.IsHost then
--		return;
--	end
--
--	local sActorName = msgOOB.sActorName or "Actor";
--	local nMod = tonumber(msgOOB.nMod) or 0;
--
--	broadcastModButtonMessage(sActorName, nMod);
--end
function onInit()
	OOBManager.registerOOBMsgHandler("modbutton", handleModButtonMessage);
end

function getModifierText(nMod)
	if nMod >= 0 then
		return "+" .. nMod;
	end

	return tostring(nMod);
end

function sendModButtonMessage(sActorName, nMod)
	local msgOOB = {};
	msgOOB.type = "modbutton";
	msgOOB.sActorName = sActorName or "Actor";
	msgOOB.nMod = nMod or 0;

	if Session.IsHost then
		handleModButtonMessage(msgOOB);
	else
		Comm.deliverOOBMessage(msgOOB, "");
	end
end

function handleModButtonMessage(msgOOB)
	local sActorName = msgOOB.sActorName or "Actor";
	local nMod = tonumber(msgOOB.nMod) or 0;

	local msg = {};
	msg.font = "systemfont";
	msg.text = sActorName .. " added " .. getModifierText(nMod);

	Comm.deliverChatMessage(msg);
end