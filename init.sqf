call compile preprocessFileLineNumbers "scripts\common\params.sqf";
call compile preprocessFileLineNumbers "scripts\common\timeAndWeather.sqf";

if (isServer) then {
	call compile preprocessFileLineNumbers "scripts\server\tasks.sqf";
	call compile preprocessFileLineNumbers "scripts\Foley_markers\init.sqf";
	call compile preprocessFileLineNumbers "scripts\server\modules\init.sqf";
	call compile preprocessFileLineNumbers "scripts\server\ai.sqf";
	execVM "scripts\server\endings.sqf";
};

if (hasInterface) then {
	waitUntil {
		!isNull player
	};

	call compile preprocessFileLineNumbers "scripts\player\briefing.sqf";
	execVM "scripts\player\arsenal.sqf";
	execVM "scripts\player\garage\initGarage.sqf";
	execVM "scripts\player\radioSilence.sqf";
	execVM "scripts\player\playerMisc.sqf";
	execVM "scripts\player\eventHandlers.sqf";
};

[TOUR_respawnTickets, TOUR_respawnTime] execVM "scripts\TOUR_RC\init.sqf";

if (!isMultiplayer) then {
	execVM "scripts\common\haltAllBlufor.sqf";
};
