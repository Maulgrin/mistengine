function getScratchNumber()
	local sControlName = getName() or "";

	local sNumber = sControlName:match("scratch_item(%d+)");
	if sNumber then
		return tonumber(sNumber);
	end

	return nil;
end

function getScratchName(nScratch)
	if not nScratch then
		return "Scratch";
	end

	local sFieldName = "StringField" .. nScratch;

	if window[sFieldName] then
		local sValue = window[sFieldName].getValue();

		if sValue and sValue ~= "" then
			return sValue;
		end
	end

	return "Scratch " .. nScratch;
end

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
	if nodeActor then
		local rActor = ActorManager.resolveActor(nodeActor);
		if rActor then
			return ActorManager.getDisplayName(rActor);
		end

		local sName = DB.getValue(nodeActor, "name", "");
		if sName ~= "" then
			return sName;
		end
	end

	return User.getCurrentIdentity() or "Unknown Actor";
end

function sendScratchModOOB(sActorName, sScratchName, nMod)
	local msgOOB = {};
	msgOOB.type = "scratchmod";
	msgOOB.sActorName = sActorName or "Unknown Actor";
	msgOOB.sScratchName = sScratchName or "Scratch";
	msgOOB.nMod = nMod or 3;

	Comm.deliverOOBMessage(msgOOB, "");
end

function onClickDown(button, x, y)
	if getValue() ~= 0 then
		return true;
	end

	local nMod = 3;

	local nScratch = getScratchNumber();
	local sScratchName = getScratchName(nScratch);

	local nodeActor = getActorNode();
	local sActorName = getActorNameFromNode(nodeActor);

	ModifierStack.addSlot(sScratchName, nMod);

	sendScratchModOOB(sActorName, sScratchName, nMod);

	return true;
end

function onValueChanged()
end
