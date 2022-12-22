if (!isMultiplayer) exitWith {};

private _rcArgs = [
	TOUR_core,
	[
		[
			["TOUR_player_1", "TOUR_player_2", "TOUR_player_3"],
			"COMMAND"
		],
		[
			["TOUR_player_4", "TOUR_player_5", "TOUR_player_6", "TOUR_player_7", "TOUR_player_8"],
			"ALPHA"
		],
		[
			["TOUR_player_9", "TOUR_player_10", "TOUR_player_11", "TOUR_player_12", "TOUR_player_13"],
			"BRAVO"
		],
		[
			["TOUR_player_14", "TOUR_player_15", "TOUR_player_16"],
			"TANGO"
		],
		[
			["TOUR_player_17", "TOUR_player_18"],
			"SIERRA"
		],
		[
			["TOUR_player_19", "TOUR_player_20", "TOUR_player_21", "TOUR_player_22", "TOUR_player_23", "TOUR_player_24", "TOUR_player_25", "TOUR_player_26", "TOUR_player_27", "TOUR_player_28", "TOUR_player_29", "TOUR_player_30"],
			"Spectators"
		]
	],
	TOUR_param_respawnType,
	TOUR_param_respawnTickets,
	TOUR_param_respawnTime,
	[150, 150, 0, false],
	"respawn_west"
];

private _rc = _rcArgs execVM "scripts\TOUR_RespawnControl\TOUR_RC_init.sqf";
waitUntil {
	scriptDone _rc;
}
