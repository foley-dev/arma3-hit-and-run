#define GARAGE_SOUND_INTERVAL 5

params ["_target", "_caller", "_id", "_anim"];

if (isNil "Foley_technical") exitWith {
	hint "Error: The vehicle cannot be identified.";
};

if (!alive Foley_technical) exitWith {
	hint "The vehicle is destroyed.";
};

if (isNull Foley_technical) exitWith {
	hint "The vehicle is already being worked on.";
};

if (Foley_technical distance getMarkerPos "garage_marker" >= 3) exitWith {
	hint "The vehicle must be parked in the garage.";
};

if (typeOf player != "B_G_engineer_F" && typeOf player != "B_soldier_repair_F") exitWith {
	hint "You must be a crewman to do this.";
};

if (isNil "Foley_garageSoundLastPlayed") then {
	Foley_garageSoundLastPlayed = 0;
};

if (time - Foley_garageSoundLastPlayed > GARAGE_SOUND_INTERVAL) then {
	playSound3D ["A3\Missions_F_EPA\data\sounds\Acts_carFixingWheel.wss", Foley_technical, true];
	Foley_garageSoundLastPlayed = time;
	publicVariable "Foley_garageSoundLastPlayed";
};

if (_anim == "PAINT0") exitWith {
	playSound3D ["z\ace\addons\tagging\sounds\spray.ogg", Foley_technical, true];
	private _current = (getObjectTextures Foley_technical) select 0;
	private _textures = [
		"UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_uaz\data\uaz_main_civil2_co.paa",
		"UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_uaz\data\uaz_main_civil_co.paa",
		"UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_uaz\data\uaz_main_green_co.paa",
		"UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_uaz\data\uaz_main_civil4_co.paa",
		"UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_uaz\data\uaz_acr_main_co.paa",
		"UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_uaz\data\napa_uaz_main_co.paa",
		"UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_uaz\data\uaz_main_civil3_co.paa",
		"UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_uaz\data\uaz_main_sov_co.paa",
		"UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_uaz\data\uaz_main_rus_co.paa",
		"UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_uaz\data\uaz_main_civil1_co.paa",
		"UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_uaz\data\ard_uaz_main_co.paa",
		"UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_uaz\data\nfa_uaz_main_co.paa",
		"UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_uaz\data\lnm_uaz_main_co.paa"
	];
	_textures = _textures select {toLower _x != toLower _current};
	Foley_technical setObjectTextureGlobal [0, selectRandom _textures];
};

if (_anim == "PAINT1") exitWith {
	playSound3D ["z\ace\addons\tagging\sounds\spray.ogg", Foley_technical, true];
	private _current = (getObjectTextures Foley_technical) select 1;
	private _textures = [
		"UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_uaz\data\uaz_mount_black_co.paa",
		"UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_uaz\data\uaz_mount_khk_co.paa",
		"UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_uaz\data\uaz_mount_white_co.paa",
		"UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_uaz\data\uaz_mount_rus_co.paa"
	];
	_textures = _textures select {toLower _x != toLower _current};

	Foley_technical setObjectTextureGlobal [1, selectRandom _textures];
};

if (_anim == "FLAG") exitWith {
	if (getForcedFlagTexture Foley_technical == "") then {
		Foley_technical forceFlagTexture "\A3\Data_F\Flags\Flag_FIA_CO.paa";
	} else {
		Foley_technical forceFlagTexture "";
	};
};

private _currentPhase = Foley_technical animationPhase _anim;
private _newPhase = 1;
if (_currentPhase > 0) then {
	_newPhase = 0;
};
Foley_technical animate [_anim, _newPhase];
