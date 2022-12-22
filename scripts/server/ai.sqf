Foley_routeIndex = 0;

Foley_allRoutes = parseSimpleArray loadFile "assets\routes.sqf";
Foley_allRoutes = Foley_allRoutes call BIS_fnc_arrayShuffle;

[] spawn {
	private _previous = -1;
	private _routes = Foley_allRoutes select Foley_routeIndex;
	private _routeMarkerId = "";

	while {time < 1} do {
		if (Foley_routeIndex == _previous) then {
			uisleep 1;
			continue;
		};

		_routes = Foley_allRoutes select (Foley_routeIndex % count Foley_allRoutes);
		_routeMarkerId = [_routes, false] call Foley_fnc_drawRoutes;
		
		_previous = Foley_routeIndex;
	};
	
	[_routes, true] call Foley_fnc_drawRoutes;
	call Foley_fnc_applyEnemyLoadout;
	[_routes] call Foley_fnc_deployPatrol;
	call Foley_fnc_deployStationedGroups;
	call Foley_fnc_deployCamps;
	[] spawn Foley_daemon_adjustSkill;
};
