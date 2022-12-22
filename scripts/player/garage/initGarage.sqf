if (isDedicated) exitWith {};

waitUntil {
	!isNull player
};

{
	_x params ["_text", "_script", "_args", "_cond", "_hideOnUse"];
	player addAction [_text, _script, _args, (10 - _forEachIndex) / 1000, false, _hideOnUse, "", _cond, 1, false, ""];
} forEach [
	[
		"<t color='#eeaa22'>Install DShK</t>", 
		"scripts\player\garage\swapVehicle.sqf", 
		"UK3CB_B_G_UAZ_Dshkm",
		"player inArea Foley_garageArea && vehicle _this == _this && typeOf Foley_technical != ""UK3CB_B_G_UAZ_Dshkm""",
		true
	],
	[
		"<t color='#eeaa22'>Install SPG-9</t>", 
		"scripts\player\garage\swapVehicle.sqf", 
		"UK3CB_B_G_UAZ_SPG9",
		"player inArea Foley_garageArea && vehicle _this == _this && typeOf Foley_technical != ""UK3CB_B_G_UAZ_SPG9""",
		true
	],
	[
		"<t color='#eeaa22'>Install AGS-30</t>", 
		"scripts\player\garage\swapVehicle.sqf", 
		"UK3CB_B_G_UAZ_AGS30",
		"player inArea Foley_garageArea && vehicle _this == _this && typeOf Foley_technical != ""UK3CB_B_G_UAZ_AGS30""",
		true
	],
	[
		"<t color='#eeaa33'>Uninstall Weapon</t>",
		"scripts\player\garage\swapVehicle.sqf", 
		"UK3CB_B_G_UAZ_Open", 
		"player inArea Foley_garageArea && vehicle _this == _this && typeOf Foley_technical != ""UK3CB_B_G_UAZ_Open""",
		true
	],
	[
		"<t color='#33dd33'>Paint Job (Body)</t>", 
		"scripts\player\garage\customiseVehicle.sqf", 
		"PAINT0", 
		"player inArea Foley_garageArea",
		false
	],
	[
		"<t color='#33dd33'>Paint Job (Cage)</t>", 
		"scripts\player\garage\customiseVehicle.sqf", 
		"PAINT1", 
		"player inArea Foley_garageArea && typeOf Foley_technical != ""UK3CB_B_G_UAZ_Open"" && typeOf Foley_technical != ""UK3CB_B_G_UAZ_SPG9""",
		false
	],
	[
		"<t color='#55aa55'>Flag</t>", 
		"scripts\player\garage\customiseVehicle.sqf", 
		"FLAG",
		"player inArea Foley_garageArea",
		false
	],
	[
		"<t color='#55aa55'>Headlight Caps</t>", 
		"scripts\player\garage\customiseVehicle.sqf", 
		"light_hide",
		"player inArea Foley_garageArea",
		false
	]
];
