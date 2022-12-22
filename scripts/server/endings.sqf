#define TIME_TO_LET_THINGS_SETTLE 15
#define DELAY_BEFORE_FINISH 3

if (!isServer) exitWith {};

sleep TIME_TO_LET_THINGS_SETTLE;
waitUntil {
	time > 0 && ({alive _x && faction _x != "CIV_F"} count allPlayers) > 0
};

private _initialEnemyStrength = {side _x == independent && alive _x} count allUnits;

while {true} do {
	private _anyPlayerAlive = {alive _x && faction _x != "CIV_F"} count allPlayers > 0;
	
	if (!_anyPlayerAlive) exitWith {
		sleep DELAY_BEFORE_FINISH;
		"loser" call BIS_fnc_endMissionServer;
	};

	private _retreated = (["retreat"] call BIS_fnc_taskState) == "SUCCEEDED";
	private _ambushSuccessful = (["ambushEnemy"] call BIS_fnc_taskState) == "SUCCEEDED";
	private _noHeavyCasualties = (["avoidLosses"] call BIS_fnc_taskState) != "FAILED";

	if (_retreated) exitWith {
		if (!_ambushSuccessful) then {
			0 = ["ambushEnemy", "FAILED", false] spawn BIS_fnc_taskSetState;
		};

		if (_noHeavyCasualties) then {
			0 = ["avoidLosses", "SUCCEEDED", false] spawn BIS_fnc_taskSetState;
		};

		sleep DELAY_BEFORE_FINISH;

		if (_ambushSuccessful && _noHeavyCasualties) exitWith {
			"VictoryEnding" call BIS_fnc_endMissionServer;
		};

		if (_ambushSuccessful && !_noHeavyCasualties) exitWith {
			"MinorVictoryEnding" call BIS_fnc_endMissionServer;
		};

		if (!_ambushSuccessful && _noHeavyCasualties) exitWith {
			"MinorDefeatEnding" call BIS_fnc_endMissionServer;
		};

		if (!_ambushSuccessful && !_noHeavyCasualties) exitWith {
			"DefeatEnding" call BIS_fnc_endMissionServer;
		};
	};

	sleep 1;
};