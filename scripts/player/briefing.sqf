player createDiaryRecord [
	"Diary", 
	[
		"About",
		"<img image='assets\picture.paa' width='256' height='128'/><br />
<font size=16>18 [Tour] Hit and Run</font><br />
by Foley<br />
<br />
<font face='RobotoCondensedLight'>“The conventional army loses if it does not win.<br />
&#160;&#160;&#160;&#160;The guerilla wins if he does not lose.”</font><br />
<br />
<font size=12>Version: <font face='RobotoCondensedBold'>v1.4</font><br />
Discord: <font face='RobotoCondensedBold'>Foley#1330</font></font>"
	]
];

player createDiaryRecord [
	"Diary", 
	[
		"Assets",
		"<font size=16>Units:</font><br />
<img image='ca\ui\data\markers\b_hq2.paa' height='20' valign='middle' /> <font size=15 valign='middle'>COMMAND</font> - Command Element - <font face='RobotoCondensedLight'>Ch5</font><br />
<img image='ca\ui\data\markers\b_inf.paa' height='20' valign='middle' /> <font size=15 valign='middle'>ALPHA</font> - Fireteam (MG) - <font face='RobotoCondensedLight'>Ch1</font><br />
<img image='ca\ui\data\markers\b_inf.paa' height='20' valign='middle' /> <font size=15 valign='middle'>BRAVO</font> - Fireteam (AT) - <font face='RobotoCondensedLight'>Ch2</font><br />
<img image='ca\ui\data\markers\b_motor_inf.paa' height='20' valign='middle' /> <font size=15 valign='middle'>TANGO</font> - Technical Crew (UAZ) - <font face='RobotoCondensedLight'>Ch3</font><br />
<img image='ca\ui\data\markers\b_recon.paa' height='20' valign='middle' /> <font size=15 valign='middle'>SIERRA</font> - Scout Team - <font face='RobotoCondensedLight'>Ch4</font><br />
<br />
<font size=16>Vehicles:</font><br />
<img image='\A3\soft_f_gamma\van_01\Data\UI\portrait_van_01_dropside_CA.paa' height='20' /> 1x Truck<br />
<img image='\UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_vwgolf\data\ui\picture_vwgolf_ca.paa' height='20' /> 1x Hatchback<br />
<img image='\UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_motorbikes\data\ui\picture_tt650_ca.paa' height='20' /> 1x Motorbike<br />
<img image='\UK3CB_Factions\addons\UK3CB_Factions_Vehicles\wheeled\UK3CB_Factions_Vehicles_bicycles\data\ui\picture_mmt_ca.paa' height='20' /> 5x Bicycle<br />
<img image='\UK3CB_Factions\addons\UK3CB_Factions_Vehicles\water\UK3CB_Factions_Vehicles_small_boat\data\ui\picture_smallboat_wood_ca.paa' height='20' /> 3x Boat<br />
<img image='\rhsafrf\addons\rhs_a2port_car\data\ico\rhs_uaz_open_pic_ca.paa' height='20' /> 1x UAZ <font face='RobotoCondensedLight'>(AGS-30 / DShK / SPG-9 / Transport)</font><br />
<br />
<font size=16>Equipment:</font><br />
- Equipment is available in the <marker name='start_marker'>arsenal</marker>.<br />
- Crewmen can weaponize the UAZ inside the <marker name='garage_marker'>garage</marker>.<br />
- Explosive Technicians have access to IEDs and tripwire mines. IEDs can be triggered by a pressure plate, a dead man switch or a cellphone (which is also available to all leaders).<br />
- <font face='RobotoCondensedBold'>GPS</font> is available only to the UAV operator!"
	]
];

if (player getVariable ["Foley_canChangeRoute", false]) then {
	Foley_routeIndex = 0;
	private _changePatrolRouteBriefing = player createDiaryRecord [
		"Diary", 
		[
			"Change patrol route",
			"This section visible to commander only.<br />
Click the link below to change the enemy patrol route.<br /><br />
<execute expression='systemChat ""Rolling the dice...""; Foley_routeIndex = Foley_routeIndex + 1; publicVariable ""Foley_routeIndex"";'>Roll the dice</execute>"
		]
	];
	
	[_changePatrolRouteBriefing] spawn {
		params ["_changePatrolRouteBriefing"];
		
		waitUntil {
			uisleep 0.1;

			time > 1
		};
		
		player removeDiaryRecord ["Diary", _changePatrolRouteBriefing];
	};
};

player createDiaryRecord [
	"Diary", 
	[
		"Briefing",
		"The AAF unit stationed at <marker name='fob_marker'>FOB Gamekeeper</marker> is heading out on a patrol of the woods. The patrol is composed of an infantry platoon backed by a few BRDMs. The <marker name='infantry_route_3'>expected route</marker> has been sketched on your maps. Keep in mind that BRDMs tend to follow the roads.<br />
<br />
<font face='RobotoCondensedBold'>The patrol has just moved out at a walking pace.</font><br />
<br />
Your goal is to:<br />
<font face='RobotoCondensedBold'>1. Ambush and harass the enemy patrol<br />
2. Once it's too hot, escape <marker name='exfil_marker'>off the shore</marker></font><br />
<br />
Beware of reinforcements! If the patrol suffers casualties, more units will show up. The <marker name='molos_marker'>BMPs</marker> might get involved if we put up a good fight. Be agile, your goal is not to defeat the enemy but to wear them down."
	]
];
