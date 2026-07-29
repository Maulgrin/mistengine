local OOB_STATUS_TAG_MOD = "status_tag_mod_message";

function onInit()
	OOBManager.registerOOBMsgHandler(OOB_STATUS_TAG_MOD, handleStatusTagModMessage);
end

function sendStatusTagModMessage(sName, nPower, sActorName)
	if sName == "" then
		sName = "Status/Tag";
	end

	nPower = tonumber(nPower) or 0;

	if not sActorName or sActorName == "" then
		sActorName = "Unknown Actor";
	end

	if Session.IsHost then
		broadcastStatusTagModMessage(sName, nPower, sActorName);
	else
		local msgOOB = {};
		msgOOB.type = OOB_STATUS_TAG_MOD;
		msgOOB.sName = sName;
		msgOOB.nPower = nPower;
		msgOOB.sActorName = sActorName;

		Comm.deliverOOBMessage(msgOOB, "");
	end
end

function handleStatusTagModMessage(msgOOB)
	if not Session.IsHost then
		return;
	end

	if not msgOOB then
		return;
	end

	local sName = msgOOB.sName or "Status/Tag";
	local nPower = tonumber(msgOOB.nPower) or 0;
	local sActorName = msgOOB.sActorName or "Unknown Actor";

	broadcastStatusTagModMessage(sName, nPower, sActorName);
end

function broadcastStatusTagModMessage(sName, nPower, sActorName)
	local sSign = "";

	if nPower > 0 then
		sSign = "+";
	end

	local msg = {};
	msg.font = "systemfont";
	msg.text = sActorName .. " added Status/Tag modifier: " .. sName .. " (" .. sSign .. nPower .. ")";

	Comm.deliverChatMessage(msg);
end