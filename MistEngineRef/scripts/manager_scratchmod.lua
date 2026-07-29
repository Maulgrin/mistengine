function onInit()
	OOBManager.registerOOBMsgHandler("scratchmod", handleScratchMod);
end

function getModifierText(nMod)
	if nMod >= 0 then
		return "+" .. nMod;
	end

	return tostring(nMod);
end

function broadcastScratchMessage(sActorName, sScratchName, nMod)
	local msg = {};
	msg.font = "systemfont";
	msg.text = sActorName .. " scratched " .. sScratchName .. " for " .. getModifierText(nMod);

	Comm.deliverChatMessage(msg);
end

function handleScratchMod(msgOOB)
	local sActorName = msgOOB.sActorName or "Unknown Actor";
	local sScratchName = msgOOB.sScratchName or "Scratch";
	local nMod = tonumber(msgOOB.nMod) or 3;

	broadcastScratchMessage(sActorName, sScratchName, nMod);
end