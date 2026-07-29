function onInit()
	OOBManager.registerOOBMsgHandler("reset_tags_statuses", handleResetTagsStatuses);
end

function sendResetTagsStatusesMessage(sActorName)
	local msgOOB = {};
	msgOOB.type = "reset_tags_statuses";
	msgOOB.sActorName = sActorName or "Unknown Actor";

	-- If client, send to host.
	-- If host, handle directly and broadcast.
	if Session.IsHost then
		handleResetTagsStatuses(msgOOB);
	else
		Comm.deliverOOBMessage(msgOOB, "");
	end
end

function handleResetTagsStatuses(msgOOB)
	local sActorName = msgOOB.sActorName or "Unknown Actor";

	local msg = {};
	msg.font = "systemfont";
	msg.text = sActorName .. " reset Tags/Statuses";

	Comm.deliverChatMessage(msg);
end