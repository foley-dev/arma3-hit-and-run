Foley_fnc_drawRoutes = {
	params ["_routes", "_withTracking"];

	_routes params ["_mainObjectives", "_infantryRoutes", "_vicRoutes"];

	private _infantryPoints = [_infantryRoutes select 0] call Foley_fnc_routeToPoints;
	private _id = [
		"infantry_route", 
		_infantryPoints, 
		"colorINDEPENDENT", 
		false, 
		Foley_markers_fnc_waveInterpolation,
		[[0.3, 0.4, 0.5], 3, 10],
		Foley_markers_fnc_maxLengthSegmentation,
		[250]
	] call Foley_markers_fnc_create;

	if (_withTracking) then {
		[_id] spawn {
			params ["_id"];

			while {true} do {
				private _infantryPlatoon = allGroups select {side _x == independent && _x getVariable ["Foley_infantryPlatoon", false]};
				private _allSegments = [_id] call Foley_markers_fnc_getAllPolylines;
				private _indices = _infantryPlatoon apply {
					_allSegments find ([_id, getPos leader _x] call Foley_markers_fnc_getNearestPolyline)
				};
				private _index = selectMax _indices;

				if (_index < 0) exitWith {};

				private _slice = [_id, 0, _index] call Foley_markers_fnc_getPolylinesSlice;

				{
					_x setMarkerColor "ColorGrey";
				} forEach _slice;

				sleep 10;
			};
		};
	};

	_id
};

Foley_fnc_routeToPoints = {
	params ["_route"];
	_route params ["_objectives", "_paths"];

	private _points = [];

	{
		private _path = _x;

		private _roughPath = [];

		{
			if (_forEachIndex % 4 == 0) then {
				_roughPath pushBack _x;
			};
		} forEach _path;

		_points = _points + _roughPath;
	} forEach _paths;

	_points
};
