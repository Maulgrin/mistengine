function getActorNode()
	local node = window.getDatabaseNode();

	while node do
		if DB.getValue(node, "name", "") ~= "" then
			return node;
		end

		node = node.getParent();
	end

	return nil;
end

function getActorNameFromNode(nodeActor)
	if not nodeActor then
		return "Unknown Actor";
	end

	local rActor = ActorManager.resolveActor(nodeActor);
	if rActor then
		return ActorManager.getDisplayName(rActor);
	end

	return DB.getValue(nodeActor, "name", "Unknown Actor");
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

function onClickDown(button, x, y)
	if getValue() ~= 0 then
		return true;
	end

	local sCheckboxName = getName();
	local sStringFieldName = sCheckboxName:gsub("Checkbox", "StringField");
	local sModName = "W";

	if window[sStringFieldName] then
		sModName = window[sStringFieldName].getValue();
	end

	if not sModName or sModName == "" then
		sModName = sCheckboxName;
	end

	local nodeActor = getActorNode();
	local sActorName = getActorNameFromNode(nodeActor);
	local sActorNode = "";

	if nodeActor then
		sActorNode = nodeActor.getPath();
	end

	local nMod = -1;

	ModifierStack.addSlot(sModName, nMod);

	local msgOOB = {};
	msgOOB.type = "themecheckboxmod";
	msgOOB.sActorName = sActorName;
	msgOOB.sActorNode = sActorNode;
	msgOOB.sModName = sModName;
	msgOOB.nMod = nMod;

	if Session.IsHost then
		sendModMessageToAll(sActorName .. " added " .. getModifierText(nMod) .. " from " .. sModName);
	else
		Comm.deliverOOBMessage(msgOOB, "");
	end

	return true;
end
