doStop player;
player addRating 50000;

[
	150,
	getPos player,
	"<t font='PuristaBold' size='1.6'>18 [Tour] Hit and Run</t><br />by Foley"
] execVM "scripts\player\missionTitle.sqf";

[
	player,
	[
		[
			"ACRE_PRC343",
			player getVariable ["Foley_radioChannel", 1]
		]
	]
] execVM "scripts\player\radioChannelSetup.sqf";
