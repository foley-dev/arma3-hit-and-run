#define	SPAWN_POS_X 23782.648
#define	SPAWN_POS_Y 23002.705
#define	SPAWN_POS_Z 0.266
#define GARAGE_SOUND_INTERVAL 5

params ["_target", "_caller", "_id", "_classname"];


if (isNil "Foley_technical") exitWith {
	hint "Error: The vehicle cannot be identified.";
};

if (isNull Foley_technical) exitWith {
	hint "The vehicle is already being worked on.";
};

if (Foley_technical distance getMarkerPos "garage_marker" >= 3) exitWith {
	hint "The vehicle must be parked in the garage.";
};

if (isEngineOn Foley_technical) exitWith {
	hint "The engine must be turned off.";
};

if ({alive _x && vehicle _x == Foley_technical} count allPlayers > 0) exitWith {
	hint "The vehicle must be empty.";
};

if (typeOf player != "B_G_engineer_F" && typeOf player != "B_soldier_repair_F") exitWith {
	hint "You must be a crewman to do this.";
};

if (count (weaponCargo Foley_technical + itemCargo Foley_technical + magazineCargo Foley_technical + backpackCargo Foley_technical) > 0) exitWith {
	hint "Vehicle inventory must be emptied before this operation.";
};

private _textures = getObjectTextures Foley_technical;
private _anims = [];
{
	_anims pushBack [_x, Foley_technical animationPhase _x];
} forEach ["light_hide"];
private _flagTexture = getForcedFlagTexture Foley_technical;
private _dir = 180;
if (getDir Foley_technical > 270 || getDir Foley_technical < 90) then {
	_dir = 0;
};

deleteVehicle Foley_technical;
Foley_technical = objNull;
publicVariable "Foley_technical";

sleep 0.1;
Foley_technical = createVehicle [_classname, [SPAWN_POS_X, SPAWN_POS_Y, SPAWN_POS_Z], [], 0, "CAN_COLLIDE"];  
Foley_technical setPosATL [SPAWN_POS_X, SPAWN_POS_Y, SPAWN_POS_Z];  
Foley_technical setDir _dir;
{
	Foley_technical setObjectTextureGlobal [_forEachIndex, _x];
} forEach _textures;
{
	Foley_technical animate [_x select 0, _x select 1];
} forEach _anims;
Foley_technical forceFlagTexture _flagTexture;
clearItemCargoGlobal Foley_technical;
Foley_technical setVehicleLock "UNLOCKED";

sleep 0.1;
Foley_technical setPosATL [SPAWN_POS_X, SPAWN_POS_Y, SPAWN_POS_Z];  
Foley_technical setDir _dir;
publicVariable "Foley_technical";

if (isNil "Foley_garageSoundLastPlayed") then {Foley_garageSoundLastPlayed = 0;};
if (time - Foley_garageSoundLastPlayed > GARAGE_SOUND_INTERVAL) then {
	playSound3D ["A3\Missions_F_EPA\data\sounds\Acts_carFixingWheel.wss", Foley_technical];
	Foley_garageSoundLastPlayed = time;
	publicVariable "Foley_garageSoundLastPlayed";
};