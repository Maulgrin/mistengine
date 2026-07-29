function update(bReadOnly, bForceHide)
	local bLocalShow;
	if bForceHide then
		bLocalShow = false;
	else
		bLocalShow = true;
		if bReadOnly and not nohide and isEmpty() then
			bLocalShow = false;
		end
	end
	
	setReadOnly(bReadOnly);
	setVisible(bLocalShow);
	
	local sName = getName();
	if window[sName .. "_label"] then
		window[sName .. "_label"].setVisible(bLocalShow);
	elseif window[sName .. "_header"] then
		window[sName .. "_header"].setVisible(bLocalShow);
	end
	if separator then
		if window[separator[1]] then
			window[separator[1]].setVisible(bLocalShow);
		end
	end
	
	return bLocalShow;
end