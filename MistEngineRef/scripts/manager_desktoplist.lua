function onInit()
	OOBManager.registerOOBMsgHandler("desktoplist_deleteitem", handleDeleteItem);
end

function handleDeleteItem(msgOOB)
	if not Session.IsHost then
		return;
	end

	local sNode = msgOOB.sNode or "";
	if sNode == "" then
		return;
	end

	local node = DB.findNode(sNode);
	if node then
		node.delete();
	end
end