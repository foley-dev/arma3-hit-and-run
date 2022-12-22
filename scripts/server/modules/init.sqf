private _modules = [
	"enemyLoadout.sqf",
	"skill.sqf",
	"map.sqf",
	"debug.sqf",
	"deployment.sqf"
];

{
	call compile preprocessFileLineNumbers ("scripts\server\modules\" + _x);
} forEach _modules;
