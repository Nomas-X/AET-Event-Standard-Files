/*
Author: Redwan S. / Nomas
Description:
    This function takes all triggers in a Layer and places an area marker on it with its size and places a normal marker on the Trigger's center.

Arguments:
	0. <String> Layer Name

Return Value: <nil>

Example:
	[_Triggers] call A3A_fnc_markTriggersInLayer;
	[[_layer], "A3A_fnc_getLayer", [], "A3A_fnc_markTriggersInLayer"] remoteExec ["A3A_fnc_useRemoteReturn", 2];
*/
params ["_layer"];

private _Triggers = (_layer select 0) select 0;

private _counter = 1;
// getMissionLayerEntities
{
	// Get all the trigger info and prepare markaer names
	private _triggerPosition = getPosATL _x;
	private _triggerText = triggerText _x;
	private _triggerAreaMarkerName = "triggerArea_A3AScript_InLayer_" + str(_counter);
	private _triggerPointMarkerName = "triggerPoint_A3AScript_InLayer_" + str(_counter);
	private _triggerAreaInfo = triggerArea _x;

	// Creates the trigger area marker and sets its settings
	createMarkerLocal [_triggerAreaMarkerName, _triggerPosition];
	_triggerAreaMarkerName setMarkerSizeLocal [_triggerAreaInfo select 0, _triggerAreaInfo select 1];
	_triggerAreaMarkerName setMarkerDirLocal (_triggerAreaInfo select 2);
	_triggerAreaMarkerName setMarkerColorLocal "ColorCIV";
	_triggerAreaMarkerName setMarkerBrushLocal "DiagGrid";

	if (_triggerAreaInfo select 3) then {
		_triggerAreaMarkerName setMarkerShapeLocal "RECTANGLE";
	} else {
		_triggerAreaMarkerName setMarkerShapeLocal "ELLIPSE";
	};

	// Creates the trigger point marker and sets its settings
	createMarkerLocal [_triggerPointMarkerName, _triggerPosition];
	_triggerPointMarkerName setMarkerColorLocal "ColorBlack";
	_triggerPointMarkerName setMarkerTypeLocal "mil_dot";

	if (_triggerText != "") then {
		_triggerPointMarkerName setMarkerText _triggerText;
	} else {
		_triggerPointMarkerName setMarkerText ("Trigger_" + str(_counter) + "_InLayer");
	};

	_counter = _counter + 1;
} forEach _Triggers;