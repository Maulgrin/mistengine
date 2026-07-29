local OOB_MSGTYPE_FELLOWSHIPMOD = "fellowshipmod_message";

function onInit()
	OOBManager.registerOOBMsgHandler(OOB_MSGTYPE_FELLOWSHIPMOD, handleFellowshipModOOB);
end

function addButtonStringMod(w, cButton, nManualValue)
	if not w or not cButton then
		ChatManager.SystemMessage("Fellowship Mod Error: Missing window or button.");
		return;
	end

	local sButtonName = "";

	if cButton.getName then
		sButtonName = cButton.getName();
	end

	-- Button1, Button2, Button3, etc.
	-- This number is ONLY used to match the associated StringField.
	local nFieldIndex = tonumber(sButtonName:match("(%d+)$")) or 0;

	if nFieldIndex == 0 then
		ChatManager.SystemMessage("Fellowship Mod Error: Could not read field number from button name: " .. sButtonName);
		return;
	end

	-- This is the actual modifier value.
	-- It uses the value passed from the button code first.
	local nButtonValue = tonumber(nManualValue);

	-- If no manual value was passed, try to read getValue from the button.
	if not nButtonValue and cButton.getValue then
		nButtonValue = tonumber(cButton.getValue());
	end

	if not nButtonValue then
		ChatManager.SystemMessage("Fellowship Mod Error: No modifier value found for button: " .. sButtonName);
		return;
	end

	if nButtonValue == 0 then
		ChatManager.SystemMessage("Fellowship Mod Error: Button value is 0. Button name: " .. sButtonName);
		return;
	end

	-- Button1 reads StringField1, Button2 reads StringField2, etc.
	local sStringFieldName = "StringField" .. nFieldIndex;
	local sLabel = "";

	if w[sStringFieldName] and w[sStringFieldName].getValue then
		sLabel = w[sStringFieldName].getValue();
	end

	if sLabel == "" then
		sLabel = "Fellowship";
	end

	-- Add to the local modifier stack
	ModifierStack.addSlot(sLabel, nButtonValue);

	local sActorName = getActorNameFromWindow(w);

	sendFellowshipModMessage(sActorName, sLabel, nButtonValue);
end

function sendFellowshipModMessage(sActorName, sLabel, nButtonValue)
	sActorName = sActorName or "Unknown Actor";
	sLabel = sLabel or "Fellowship";
	nButtonValue = tonumber(nButtonValue) or 0;

	if Session.IsHost then
		broadcastFellowshipModMessage(sActorName, sLabel, nButtonValue);
	else
		local msgOOB = {};
		msgOOB.type = OOB_MSGTYPE_FELLOWSHIPMOD;
		msgOOB.sActorName = sActorName;
		msgOOB.sLabel = sLabel;
		msgOOB.nButtonValue = nButtonValue;

		-- Client sends to host
		Comm.deliverOOBMessage(msgOOB, "");
	end
end

function handleFellowshipModOOB(msgOOB)
	if not Session.IsHost then
		return;
	end

	local sActorName = msgOOB.sActorName or "Unknown Actor";
	local sLabel = msgOOB.sLabel or "Fellowship";
	local nButtonValue = tonumber(msgOOB.nButtonValue) or 0;

	broadcastFellowshipModMessage(sActorName, sLabel, nButtonValue);
end

function broadcastFellowshipModMessage(sActorName, sLabel, nButtonValue)
	local sSign = "";

	if nButtonValue >= 0 then
		sSign = "+";
	end

	local msg = {};
	msg.font = "systemfont";
	msg.text = sActorName .. " added " .. sLabel .. " " .. sSign .. nButtonValue;

	-- Host broadcasts to everyone
	Comm.deliverChatMessage(msg);
end

function getActorNameFromWindow(w)
	-- First try normal window/database-node actor detection
	if w and w.getDatabaseNode then
		local node = w.getDatabaseNode();

		while node do
			local rActor = ActorManager.resolveActor(node);

			if rActor then
				return ActorManager.getDisplayName(rActor);
			end

			local sName = DB.getValue(node, "name", "");

			if sName ~= "" then
				return sName;
			end

			node = node.getParent();
		end
	end

	-- Desktop item fallback:
	-- On a client, use the currently selected player identity.
	if User and User.getCurrentIdentity then
		local sIdentity = User.getCurrentIdentity();

		if sIdentity and sIdentity ~= "" then
			local nodeIdentity = DB.findNode("charsheet." .. sIdentity);

			if nodeIdentity then
				local rActor = ActorManager.resolveActor(nodeIdentity);

				if rActor then
					return ActorManager.getDisplayName(rActor);
				end

				local sName = DB.getValue(nodeIdentity, "name", "");

				if sName ~= "" then
					return sName;
				end
			end

			if User.getIdentityLabel then
				local sLabel = User.getIdentityLabel(sIdentity);

				if sLabel and sLabel ~= "" then
					return sLabel;
				end
			end

			return sIdentity;
		end
	end

	return "Unknown Actor";
end