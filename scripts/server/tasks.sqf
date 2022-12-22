#define TIME_TO_LET_THINGS_SETTLE 15
#define ACCEPTABLE_CASUALTIES_PCT 0.33

if (!isServer) exitWith {};

[
	true,
	"ambushEnemy",
	[
		"Wear down the enemy as they advance into the woods.",
		"Resist"
	],
	objNull,
	"ASSIGNED",
	20,
	false,
	"destroy"
] call BIS_fnc_taskCreate;

[
	true,
	"avoidLosses",
	[
		"Pick your fights, have an escape route prepared.",
		"Avoid heavy casualties"
	],
	objNull,
	"CREATED",
	15,
	false,
	"defend"
] call BIS_fnc_taskCreate;

[
	true,
	"retreat",
	[
		"Evacuate off the shore. North is the prefered direction though you can escape into any direction provided you travel far enough. For your convenience, there are additional boats sporadically scattered along the coastline.",
		"Escape"
	],
	objNull,
	"CREATED",
	10,
	false,
	"run"
] call BIS_fnc_taskCreate;

// Resolve "Resist"
[] spawn {
	sleep TIME_TO_LET_THINGS_SETTLE;
	
	private _initialEnemyStrength = {side _x == independent && alive _x} count allUnits;

	waitUntil {
		sleep 1;

		private _currentEnemyStrength = {side _x == independent && alive _x} count allUnits;
		private _expectedKills = ((2 * ({faction _x != "CIV_F"} count allPlayers)) min 30) max 10;
		private _remainingKills = _expectedKills - (_initialEnemyStrength - _currentEnemyStrength);
		private _approxRemaining = (ceil (_remainingKills / 5)) * 5;

		if (_approxRemaining > 0) then {
			[
				"ambushEnemy",
				[
					format [
						"Wear down the enemy as they advance into the woods. Take out %1 more enemies to call it a success.",
						_approxRemaining
					],
					"Resist",
					""
				]
			] call BIS_fnc_taskSetDescription;
		};

		_initialEnemyStrength - _currentEnemyStrength >= _expectedKills
	};

	[
		"ambushEnemy",
		[
			"Wear down the enemy as they advance into the woods",
			"Resist",
			""
		]
	] call BIS_fnc_taskSetDescription;
	["ambushEnemy", "SUCCEEDED", true] spawn BIS_fnc_taskSetState;
};

// Resolve "Avoid heavy casualties"
[] spawn {
	sleep TIME_TO_LET_THINGS_SETTLE;
	waitUntil {
		time > 0 && ({alive _x && faction _x != "CIV_F"} count allPlayers) > 0
	};

	private _peakPlayerCount = {alive _x && faction _x != "CIV_F"} count allPlayers;

	waitUntil {
		sleep 1;
	
		private _currentPlayerCount = {alive _x && faction _x != "CIV_F"} count allPlayers;

		if (_currentPlayerCount > _peakPlayerCount) then {
			_peakPlayerCount = _currentPlayerCount;
		};

		private _percentDead = (_peakPlayerCount - _currentPlayerCount) / _peakPlayerCount;

		_percentDead > ACCEPTABLE_CASUALTIES_PCT
	};

	["avoidLosses", "FAILED", true] spawn BIS_fnc_taskSetState;
};

// Resolve "Escape"
[] spawn {
	sleep TIME_TO_LET_THINGS_SETTLE;
	waitUntil {
		time > 0 && ({alive _x && faction _x != "CIV_F"} count allPlayers) > 0
	};

	waitUntil {
		sleep 1;
		
		private _playersAlive = {alive _x && faction _x != "CIV_F"} count allPlayers;
		private _playersEscaped = {alive _x && faction _x != "CIV_F" && !((getPos _x) inArea Foley_ao)} count allPlayers;

		_playersAlive > 0 && _playersEscaped >= 0.8 * _playersAlive
	};

	["retreat", "SUCCEEDED", true] spawn BIS_fnc_taskSetState;
};
