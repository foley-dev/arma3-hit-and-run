#define MARKER_UPDATE_INTERVAL 5

if (!Foley_param_debugMode) exitWith {};

[] spawn {
	private _markers = [];
	
	while {true} do {
		{
			deleteMarker _x;
		} forEach _markers;

		_markers = [];

		{
			private _pos = getPos leader _x;
			private _label = format [
				"%1 (%2 strong)",
				groupId _x,
				{alive _x} count units _x
			];

			if (_x getVariable ["Foley_progressMajor", -1] >= 0) then {
				_label = format [
					"%1 (%2%3)",
					_x getVariable "Foley_progressMajor",
					100 * (_x getVariable "Foley_progressMinor"),
					"%"
				];
			};

			private _markerId = "debug_grp_" + str random 100000;
			private _marker = createMarker [_markerId, _pos];
			_markers pushBack _marker;
			_marker setMarkerShape "ICON";
			_marker setMarkerType "b_unknown";
			_marker setMarkerSize [0.75, 0.75];
			_marker setMarkerText _label;
			private _color = "colorCivilian";
			if (side _x == blufor) then {
				_color = "colorBLUFOR";
			};
			if (side _x == independent) then {
				_color = "colorIndependent";
			};
			_marker setMarkerColor _color;
		} forEach allGroups;

		sleep MARKER_UPDATE_INTERVAL;
	};
};
