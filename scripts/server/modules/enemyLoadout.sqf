Foley_fnc_applyEnemyLoadout = {
	{
		private _betterLoadout = _x getVariable ["Foley_betterLoadout", false];

		if (!_betterLoadout) then {
			_x unlinkItem "NVGoggles_INDEP";
			_x removePrimaryWeaponItem "acc_pointer_ir";
			_x addPrimaryWeaponItem "acc_flashlight";

			if ("GL" in primaryWeapon _x) then {
				_x addMagazines ["UGL_FlareGreen_F", 6];
				_x addMagazines ["UGL_FlareWhite_F", 2];
			};
		} else {
			_x linkItem "NVGoggles_INDEP";
		};

		if ("H_HelmetIA" in (headgear _x)) then {
			removeHeadgear _x;
			_x addHeadgear selectRandom ["UK3CB_AAF_I_H_MKVI_Helmet_A_GRN", "UK3CB_AAF_I_H_MKVI_Helmet_B_GRN"];
		};
	} forEach (allUnits select {side _x == independent});
};
