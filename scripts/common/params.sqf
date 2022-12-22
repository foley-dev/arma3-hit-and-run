Foley_param_timeOfDay = ["Foley_param_timeOfDay", 4] call BIS_fnc_getParamValue;
Foley_param_viewDistance = ["Foley_param_viewDistance", 1800] call BIS_fnc_getParamValue;
Foley_param_debugMode = 1 == (["Foley_param_debugMode", 1] call BIS_fnc_getParamValue);

TOUR_respawnTime = ["TOUR_param_respawn", 30] call BIS_fnc_getParamValue;
TOUR_respawnTickets = [
	["TOUR_param_tickets", 1] call BIS_fnc_getParamValue,
	["TOUR_param_tickets", 1] call BIS_fnc_getParamValue,
	["TOUR_param_tickets", 1] call BIS_fnc_getParamValue,
	["TOUR_param_tickets", 1] call BIS_fnc_getParamValue
];
