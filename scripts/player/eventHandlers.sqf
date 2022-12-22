player addEventHandler [
	"respawn",
	{
		removeAllWeapons player;
		removeAllItemsWithMagazines player;
		removeHeadgear player;
		execVM "scripts\player\arsenal.sqf";
		execVM "scripts\player\radioSilence.sqf";
	}
];
