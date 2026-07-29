local _sTarget = "";
function setTarget(sTarget)
	_sTarget = sTarget;
end

function onClickDown()
	return true;
end
function onClickRelease(button)
	return window[_sTarget].activate(button);
end
function onHover(oncontrol)
	window[_sTarget].refreshButtonDisplay(oncontrol);
end