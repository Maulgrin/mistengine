function onTabletopInit()
	DB.addEventHandler("onDataLoaded", MistDesktopWindowManager.onDataLoaded);
end

function onDataLoaded()
	MistDesktopWindowManager.openDesktopWindow("statuses", -500, 0, 300, 300);
	MistDesktopWindowManager.openDesktopWindow("fellowthemes", -500, 305, 300, 600);

	if Session.IsHost then
		MistDesktopWindowManager.openDesktopWindow("threats", -700, 0, 300, 300);
	end
end

function openDesktopWindow(sClass, nX, nY, nWidth, nHeight)
	local w = Interface.findWindow(sClass, "");
	local bExisting = (w ~= nil);

	if not w then
		w = Interface.openWindow(sClass, "");
	end

	if not w then
		return;
	end

	if not bExisting then
		w.setSize(nWidth, nHeight);
		w.setPosition(nX, nY, true);
	end
end
