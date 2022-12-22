private _varieties = createHashMapFromArray [
	["B_G_officer_F", 1.0],
	["B_G_medic_F", 0.9],
	["B_soldier_UAV_F", 0.7],
	["B_G_Soldier_TL_F", 0.7],
	["B_G_engineer_F", 0.6],
	["B_G_Soldier_lite_F", 0.6],
	["B_G_Soldier_AR_F", 0.4],
	["B_G_Soldier_LAT_F", 0.4],
	["B_G_Sharpshooter_F", 0.4],
	["B_G_Soldier_exp_F", 0.4],
	["B_soldier_repair_F", 0.4],
	["B_G_Soldier_F", 0.3]
];

private _variety = _varieties getOrDefault [typeOf player, 1.0];

private _fnc_reduceVariety = {
	params ["_array", "_variety"];

	private _count = (ceil count _array) * _variety;
	private _shuffled = _array call BIS_fnc_arrayShuffle;

	_shuffled select [0, _count];
};

private _commonUniforms = [
	"U_I_C_Soldier_Bandit_4_F",
	"U_I_C_Soldier_Bandit_1_F",
	"U_I_C_Soldier_Bandit_2_F",
	"U_I_C_Soldier_Bandit_5_F",
	"U_I_C_Soldier_Bandit_3_F",
	"UK3CB_ADE_O_U_02_K",
	"UK3CB_ADE_O_U_02_B",
	"UK3CB_ADE_O_U_02_C",
	"UK3CB_ADE_O_U_02_D",
	"UK3CB_ADE_O_U_02_E",
	"UK3CB_ADE_O_U_02",
	"UK3CB_ADE_O_U_02_F",
	"UK3CB_ADE_O_U_02_H",
	"UK3CB_ADM_B_U_Tshirt_01_DPM",
	"UK3CB_ADM_B_U_Tshirt_01_WDL",
	"UK3CB_ADM_B_U_Tshirt_01_TCC",
	"UK3CB_NAP_B_U_Tshirt_FLK",
	"UK3CB_NAP_B_U_Tshirt_BLK",
	"UK3CB_NAP_B_U_Pilot_FLORA",
	"UK3CB_NAP_B_U_Pilot_FLK",
	"UK3CB_NAP_B_U_Officer_Uniform_FLK_BLK",
	"UK3CB_NAP_B_U_Officer_Uniform_FLK_GRN",
	"UK3CB_NAP_B_U_Officer_Uniform_GRN_BLK",
	"UK3CB_NAP_B_U_Officer_Uniform_WDL_BLK",
	"UK3CB_NAP_B_U_Officer_Uniform_WDL_GRN",
	"U_BG_Guerrilla_6_1",
	"U_BG_Guerilla1_1",
	"U_BG_Guerilla1_2_F",
	"U_BG_Guerilla2_1",
	"U_BG_Guerilla2_3",
	"UK3CB_BAF_U_JumperUniform_DPMT",
	"UK3CB_BAF_U_JumperUniform_DPMW",
	"UK3CB_BAF_U_JumperUniform_Plain",
	"U_I_L_Uniform_01_tshirt_olive_F",
	"U_I_C_Soldier_Para_3_F",
	"U_I_C_Soldier_Para_4_F",
	"U_I_C_Soldier_Para_1_F",
	"UK3CB_ADM_B_U_Shirt_Pants_01_BLU_CC",
	"UK3CB_ADM_B_U_Shirt_Pants_01_BLU_WDL_ALT",
	"UK3CB_ADM_B_U_Shirt_Pants_01_BLU_WDL",
	"UK3CB_ADM_B_U_CombatUniform_01_WDL_TCC",
	"UK3CB_ADM_B_U_CombatUniform_01_WDL_MAR_DES",
	"UK3CB_ADM_B_U_CombatUniform_01_WDL_CC",
	"UK3CB_ADM_B_U_CombatUniform_01_CC_WDL",
	"UK3CB_ADM_B_U_CombatUniform_01_TCC_WDL",
	"rhsgref_uniform_flecktarn",
	"rhsgref_uniform_altis_lizard_olive",
	"rhsgref_uniform_woodland_olive",
	"UK3CB_NAP_B_U_CombatUniform_01_FLK",
	"rhsgref_uniform_dpm_olive",
	"UK3CB_BAF_U_Smock_DPMW_OLI",
	"UK3CB_NAP_B_U_CombatUniform_FLK",
	"UK3CB_NAP_B_U_CombatUniform_WDL"
];

_commonUniforms = [_commonUniforms, _variety] call _fnc_reduceVariety;

private _commonVests = [
	"V_TacChestrig_grn_F",
	"V_TacChestrig_cbr_F",
	"V_TacChestrig_oli_F",
	"UK3CB_V_Chestrig_TKA_OLI",
	"UK3CB_V_Chestrig_WDL_01",
	"V_LegStrapBag_black_F",
	"V_LegStrapBag_coyote_F",
	"V_BandollierB_blk",
	"V_BandollierB_cbr",
	"V_BandollierB_oli",
	"UK3CB_ADA_B_V_TacVest_BLK",
	"V_TacVest_camo",
	"UK3CB_ADA_B_V_TacVest_CC",
	"V_TacVest_khk",
	"V_TacVest_blk",
	"UK3CB_AAF_B_V_TacVest_DIGI_BLK",
	"rhsgref_TacVest_ERDL"
];

_commonVests = [_commonVests, _variety] call _fnc_reduceVariety;

private _commonHeadgear = [
	"H_Bandanna_gry",
	"H_Bandanna_cbr",
	"H_Bandanna_khk",
	"H_Bandanna_sgg",
	"H_Bandanna_camo",
	"H_Bandanna_surfer_grn",
	"H_Bandanna_surfer_blk",
	"UK3CB_H_Bandanna_Camo",
	"H_Watchcap_blk",
	"UK3CB_H_Beanie_02_GRY",
	"UK3CB_H_Beanie_02_BLK",
	"H_Watchcap_camo",
	"UK3CB_BAF_H_Boonie_DPMT",
	"UK3CB_CW_US_B_EARLY_H_BoonieHat_ERDL_01",
	"H_Booniehat_tan",
	"H_Cap_blk",
	"UK3CB_CHC_C_H_Can_Cap",
	"H_Cap_grn",
	"H_Cap_tan",
	"UK3CB_ANA_B_H_Patrolcap_spec4ce",
	"UK3CB_TKA_I_H_Patrolcap_OLI",
	"UK3CB_ANP_B_H_Patrolcap_BLU",
	"rhs_fieldcap_m88_back",
	"rhs_fieldcap_m88_ttsko_vdv_back",
	"UK3CB_CW_US_B_LATE_H_OFF_Patrol_Cap_WDL_01",
	"H_Shemag_olive",
	"H_ShemagOpen_tan",
	"UK3CB_H_Shemag_white",
	"rhsgref_helmet_pasgt_flecktarn",
	"rhsgref_helmet_pasgt_olive",
	"UK3CB_CW_US_B_LATE_H_PASGT_01_WDL",
	"rhsgref_helmet_pasgt_altis_lizard"
];

_commonHeadgear = [_commonHeadgear, _variety] call _fnc_reduceVariety;

private _commonFacewear = [
	"G_Balaclava_blk",
	"G_Balaclava_oli",
	"G_Bandanna_blk",
	"G_Bandanna_oli",
	"G_Bandanna_khk",
	"G_Bandanna_sport",
	"G_Bandanna_shades",
	"G_Bandanna_aviator",
	"UK3CB_G_Bandanna_aviator_flora_alt",
	"UK3CB_G_Face_Wrap_01",
	"rhsusf_shemagh_grn",
	"rhsusf_shemagh2_grn",
	"rhsusf_shemagh2_od",
	"rhs_googles_clear",
	"rhs_googles_black",
	"G_Aviator",
	"UK3CB_G_Neck_Shemag_Oli"
];

_commonFacewear = [_commonFacewear, _variety] call _fnc_reduceVariety;

private _commonBackpacks = [
	"B_Messenger_Black_F",
	"B_Messenger_Coyote_F",
	"B_Messenger_Gray_F",
	"rhs_rpg_empty",
	"B_AssaultPack_blk",
	"B_AssaultPack_cbr",
	"B_AssaultPack_khk",
	"B_AssaultPack_wdl_F",
	"UK3CB_AAF_B_B_ASS_DIGI_BLK",
	"B_FieldPack_oli",
	"B_FieldPack_khk",
	"B_CivilianBackpack_01_Everyday_Vrana_F",
	"B_CivilianBackpack_01_Everyday_Astra_F",
	"B_CivilianBackpack_01_Everyday_Black_F",
	"B_Kitbag_tan",
	"B_Kitbag_rgr",
	"UK3CB_CW_US_B_LATE_B_RIF",
	"B_Kitbag_sgg",
	"B_Carryall_oli",
	"B_Carryall_wdl_F",
	"B_Carryall_cbr",
	"B_Carryall_taiga_F"
];

_commonBackpacks = [_commonBackpacks, _variety] call _fnc_reduceVariety;

private _leaderHeadgear = [
	"H_EarProtectors_white_F",
	"H_EarProtectors_orange_F",
	"H_Cap_usblack",
	"H_Bandanna_surfer",
	"H_Hat_brown",
	"H_Hat_tan",
	"H_StrawHat_dark",
	"H_Cap_blk_CMMG",
	"H_Cap_blk_ION",
	"H_Cap_surfer",
	"UK3CB_H_Safari_Hat_Brown",
	"H_Beret_blk",
	"UK3CB_ANP_B_H_6b27m_BLK",
	"H_Cap_headphones",
	"H_Cap_oli_hs"
];

_leaderHeadgear = [_leaderHeadgear, _variety] call _fnc_reduceVariety;

private _leaderUniforms = [
	"U_C_ArtTShirt_01_v4_F",
	"U_C_ArtTShirt_01_v1_F",
	"U_C_ArtTShirt_01_v5_F",
	"U_C_ArtTShirt_01_v3_F",
	"U_C_ArtTShirt_01_v6_F",
	"U_I_L_Uniform_01_tshirt_skull_F",
	"U_I_L_Uniform_01_tshirt_black_F",
	"UK3CB_CW_US_B_LATE_U_SF_CombatUniform_02_BLK",
	"rhsgref_uniform_olive",
	"UK3CB_TKA_I_U_CombatUniform_01_OLI",
	"UK3CB_TKA_I_U_CombatUniform_02_OLI",
	"UK3CB_TKA_I_U_CombatUniform_03_OLI",
	"UK3CB_ADM_B_U_CombatUniform_01_WDL_ALT_MAR"
];

_leaderUniforms = [_leaderUniforms, _variety] call _fnc_reduceVariety;

private _crewUniforms = [
	"U_C_ArtTShirt_01_v3_F",
	"UK3CB_CHC_C_U_Overall_01",
	"UK3CB_CHC_C_U_Overall_02",
	"UK3CB_CHC_C_U_Overall_05",
	"UK3CB_CHC_C_U_Overall_03",
	"UK3CB_TKC_C_U_Pilot_A",
	"UK3CB_TKC_C_U_Pilot_B",
	"U_BG_Guerilla2_2",
	"U_C_Mechanic_01_F",
	"U_OrestesBody"
];

_crewUniforms = [_crewUniforms, _variety] call _fnc_reduceVariety;

private _crewHeadgear = [
	"UK3CB_H_Crew_Cap",
	"H_Cap_marshal",
	"rhsusf_protech_helmet",
	"rhsusf_protech_helmet_ess",
	"H_Cap_headphones",
	"rhs_tsh4",
	"rhs_tsh4_ess",
	"H_Construction_earprot_black_F",
	"H_RacingHelmet_1_black_F",
	"H_RacingHelmet_4_F"
];

_crewHeadgear = [_crewHeadgear, _variety] call _fnc_reduceVariety;

private _commonWeapons = [
	"rhs_weap_aks74",
	"rhs_weap_ak74",
	"rhs_weap_aks74un",
	"rhs_weap_akm",
	"UK3CB_BAF_L119A1",
	"UK3CB_M16A2"
];

private _sidearms = [
	"rhsusf_weap_m9"
];

private _mgWeapons = [
	"rhs_weap_fnmag",
	"rhs_weap_m249"
];

private _atWeapons = [
	"rhs_weap_rpg7"
];

private _lightAtWeapons = [
	"rhs_weap_m72a7"
];

private _leaderWeapons = [
	"rhs_weap_aks74_gp25",
	"rhs_weap_akm_gp25",
	"UK3CB_M16A2_UGL"
];

private _marksmanWeapons = [
	"UK3CB_SVD_OLD",
	"rhs_weap_svdp_wd",
	"rhs_weap_akmn",
	"UK3CB_G3A3_RIS"
];

private _commonMagazines = [
	"rhs_30Rnd_545x39_7N6M_AK",
	"rhs_30Rnd_545x39_AK_green",
	"rhs_30Rnd_762x39mm",
	"rhs_30Rnd_762x39mm_tracer",
	"30Rnd_556x45_Stanag_green",
	"30Rnd_556x45_Stanag_Tracer_Green",
	"SmokeShellOrange",
	"SmokeShell",
	"SmokeShellGreen",
	"Chemlight_green",
	"ACE_Chemlight_HiGreen",
	"HandGrenade",
	"rhsusf_mag_15Rnd_9x19_FMJ",
	"rhsusf_100Rnd_556x45_M855_soft_pouch",
	"rhsusf_50Rnd_762x51",
	"rhsusf_50Rnd_762x51_m61_ap",
	"rhsusf_50Rnd_762x51_m62_tracer",
	"rhs_rpg7_OG7V_mag",
	"rhs_rpg7_PG7V_mag",
	"rhs_rpg7_PG7VM_mag",
	"rhs_rpg7_PG7VL_mag",
	"rhs_rpg7_PG7VR_mag",
	"rhs_VOG25",
	"rhs_VOG25P",
	"rhs_GRD40_White",
	"rhs_GRD40_Red",
	"rhs_GRD40_Green",
	"rhs_VG40OP_white",
	"rhs_VG40OP_red",
	"rhs_VG40OP_green",
	"1Rnd_HE_Grenade_shell",
	"UK3CB_BAF_1Rnd_SmokeOrange_Grenade_shell",
	"UK3CB_BAF_1Rnd_Smoke_Grenade_shell",
	"UK3CB_BAF_1Rnd_SmokeGreen_Grenade_shell",
	"UK3CB_BAF_UGL_FlareWhite_F",
	"UK3CB_BAF_UGL_FlareRed_F",
	"UK3CB_BAF_UGL_FlareGreen_F",
	"rhs_10Rnd_762x54mmR_7N1",
	"rhs_10Rnd_762x54mmR_7N14",
	"UK3CB_G3_20rnd_762x51",
	"UK3CB_G3_20rnd_762x51_G"
];

private _explosives = [
	"IEDLandBig_Remote_Mag",
	"IEDUrbanBig_Remote_Mag",
	"IEDUrbanSmall_Remote_Mag",
	"IEDLandSmall_Remote_Mag",
	"rhs_mine_Mk2_tripwire_mag",
	"ACE_FlareTripMine_Mag"
];

private _medicUniforms = [
	"UK3CB_CHC_C_U_DOC_02",
	"U_Marshal"
];

private _scoutUniforms = [
	"UK3CB_CW_SOV_O_Late_U_CombatUniform_Ghillie_01_KLMK",
	"UK3CB_NAP_B_U_CombatUniform_Ghillie_BRN_FLEK",
	"UK3CB_NAP_B_U_CombatUniform_Ghillie_FLEK_BRN",
	"UK3CB_NAP_B_U_CombatUniform_Ghillie_BRN",
	"UK3CB_CW_SOV_O_Early_U_Sniper_Uniform_01_Ghillie_Top_KHK",
	"UK3CB_CHD_B_U_Sniper_Uniform_01_Ghillie_Top_Oakleaf",
	"UK3CB_CW_SOV_O_Early_U_Sniper_Uniform_01_Ghillie_Top_KLMK"
];

private _heavyVests = [
	"V_TacVestIR_blk",
	"UK3CB_AAF_O_V_Eagle_CREW_DIGI_BLK",
	"UK3CB_AAF_O_V_Eagle_CREW_DIGI_BRN"
];

private _scoutHeadgear = [
	"rhs_booniehat2_marpatwd",
	"rhsusf_ach_helmet_camo_ocp"
];

private _uavHeadgear = [
	"rhsusf_Bowman",
	"rhsusf_bowman_cap",
	"H_Cap_oli_hs"
];

private _leaderFacewear = [
	"G_Bandanna_beast",
	"G_Lady_Blue",
	"rhs_googles_orange",
	"rhs_googles_yellow"
];

private _crewFacewear = [
	"G_Lowprofile",
	"G_Balaclava_lowprofile"
];

private _commonItems = [
	"rhs_acc_2dpzenit",
	"rhs_acc_2dpzenit_ris",
	"ACE_EarPlugs",
	"ACRE_PRC343",
	"ACE_fieldDressing",
	"ACE_elasticBandage",
	"ACE_EntrenchingTool",
	"ACE_tourniquet",
	"ItemCompass",
	"ItemWatch",
	"ItemMap",
	"ACE_Flashlight_Maglite_ML300L",
	"ACE_Flashlight_XL50",
	"ACE_SpraypaintBlack",
	"ACE_SpareBarrel",
	"murshun_cigs_cigpack",
	"murshun_cigs_matches"
];

private _leaderItems = [
	"Binocular",
	"ACE_morphine",
	"ACE_epinephrine",
	"ACRE_PRC148",
	"ACE_Cellphone",
	"ACE_SpraypaintBlue",
	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed",
	"murshun_cigs_cigpack",
	"murshun_cigs_lighter"
];

private _uavItems = [
	"ACE_UAVBattery"
];

private _scoutItems = [
	"Binocular",
	"ACRE_PRC148",
	"rhsusf_bino_lerca_1200_black",
	"ACE_Kestrel4500",
	"ACE_RangeCard",
	"rhs_acc_tgpa",
	"rhs_acc_pbs1",
	"rhsusf_acc_nt4_black",
	"uk3cb_baf_silencer_l85"
];

private _medicItems = [
	"ACE_fieldDressing",
	"ACE_elasticBandage",
	"ACE_packingBandage",
	"ACE_quikclot",
	"ACE_bloodIV_250",
	"ACE_bloodIV_500",
	"ACE_bloodIV",
	"ACE_bodyBag",
	"ACE_adenosine",
	"ACE_epinephrine",
	"ACE_morphine",
	"ACE_tourniquet",
	"ACE_surgicalKit",
	"ACE_splint"
];

private _marksmanItems = [
	"rhsusf_acc_m14_bipod",
	"optic_dms_weathered_f",
	"optic_khs_blk",
	"rhs_acc_pso1m2",
	"rhs_acc_pso1m21",
	"rhs_acc_tgpa",
	"rhs_acc_pbs1"
];

private _eodItems = [
	"ACE_Cellphone",
	"ACE_DefusalKit",
	"ACE_DeadManSwitch"
];

private _crewItems = [
	"ToolKit"
];

private _medicBackpacks = [
	"UK3CB_CHC_C_B_MED",
	"rhs_medic_bag",
	"UK3CB_CHD_B_B_MD_WDL"
];

private _itemsMap = createHashMap;

_itemsMap set [
	"B_G_Soldier_F",
	_commonUniforms +
	_commonVests + +
	_commonHeadgear + 
	_commonFacewear + 
	_commonBackpacks +
	_commonItems +
	_commonWeapons +
	_commonMagazines
];

_itemsMap set [
	"B_G_Soldier_AR_F",
	(_itemsMap get "B_G_Soldier_F") - _commonWeapons + _mgWeapons
];

_itemsMap set [
	"B_G_Soldier_LAT_F",
	(_itemsMap get "B_G_Soldier_F") + _atWeapons + _lightAtWeapons
];

_itemsMap set [
	"B_G_Soldier_exp_F",
	(_itemsMap get "B_G_Soldier_F") + _eodItems + _explosives
];

_itemsMap set [
	"B_G_Soldier_TL_F",
	(_itemsMap get "B_G_Soldier_F") + 
	_leaderUniforms +
	_heavyVests + 
	_leaderHeadgear + 
	_leaderFacewear +
	_leaderItems +
	_leaderWeapons + _sidearms
];

_itemsMap set [
	"B_G_officer_F",
	(_itemsMap get "B_G_Soldier_TL_F")
];

_itemsMap set [
	"B_G_medic_F",
	(_itemsMap get "B_G_Soldier_TL_F") - _leaderItems - _leaderWeapons + _medicUniforms + _medicBackpacks + _medicItems
];

_itemsMap set [
	"B_soldier_UAV_F",
	(_itemsMap get "B_G_Soldier_TL_F") + _uavHeadgear + _uavItems - _leaderWeapons - _commonBackpacks
];

_itemsMap set [
	"B_soldier_repair_F",
	(_itemsMap get "B_G_Soldier_F") + 
	_crewUniforms +
	_crewHeadgear +
	_crewFacewear +
	_crewItems
];

_itemsMap set [
	"B_G_engineer_F",
	(_itemsMap get "B_soldier_repair_F") + 
	+ _leaderItems
	+ _sidearms
	+ _heavyVests
	+ _leaderHeadgear
];

_itemsMap set [
	"B_G_Soldier_lite_F",
	(_itemsMap get "B_G_Soldier_F") +
	_scoutUniforms +
	_scoutHeadgear +
	_scoutItems + _leaderItems
];

_itemsMap set [
	"B_G_Sharpshooter_F",
	(_itemsMap get "B_G_Soldier_lite_F") - _commonWeapons - _leaderItems + _marksmanItems + _marksmanWeapons + _sidearms
];

_itemsMap set [
	"B_G_Soldier_F",
	(_itemsMap get "B_G_Soldier_F") + _lightAtWeapons
];

[player, false] call ace_arsenal_fnc_initBox;
private _items = _itemsMap getOrDefault [typeOf player, []];
[player, _items, false] call ace_arsenal_fnc_addVirtualItems;

player addAction [
	"<t color='#B39900'>Gear Up</t>",
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		[player, _caller] call ace_arsenal_fnc_openBox;
	},
	nil,
	1,
	false,
	true,
	"",
	"player inArea Foley_arsenalArea"
];
