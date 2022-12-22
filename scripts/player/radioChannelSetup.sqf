// Courtesy of Mr.Ben [Tour]

if (isDedicated) exitWith {};
if (player != (_this select 0)) exitWith {};

waitUntil {([] call acre_api_fnc_isInitialized)};
waitUntil {!isNil "acre_api_fnc_isInitialized"};

{
	waitUntil {sleep 0.5; [(_this select 0), (_x select 0)] call acre_api_fnc_hasKindOfRadio};
	[([(_x select 0)] call acre_api_fnc_getRadioByType), (_x select 1)] call acre_api_fnc_setRadioChannel;
} forEach (_this select 1);
