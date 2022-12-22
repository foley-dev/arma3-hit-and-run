#define INITIAL_GENERAL_SKILL 0.5
#define ULTIMATE_GENERAL_SKILL 1

Foley_daemon_adjustSkill = {
	private _initialStrength = {side _x == independent && alive _x} count allUnits;
	private _alerted = false;

	while {true} do {
		private _currentStrength = {side _x == independent && alive _x} count allUnits;

		if (!_alerted) then {
			_alerted = ({alive _x && independent knowsAbout _x > 3.0} count allPlayers) > 0 || _initialStrength - _currentStrength >= 2;
		};

		// Starts off easy, gets harder as bodies drop
		private _toMin = 1.0 - ULTIMATE_GENERAL_SKILL;
		private _toMax = 1.0 - INITIAL_GENERAL_SKILL;
		private _skill = 1.0 - (linearConversion [0, _initialStrength, _currentStrength, _toMin, _toMax, true]);
		
		{
			_x setSkill ["general", _skill];

			if (!_alerted) then {
				_x setSkill ["spotDistance", 0.2];
				_x setSkill ["spotTime", 0.2];
			} else {
				_x setSkill ["aimingAccuracy", _skill];
				_x setSkill ["spotDistance", _skill];
			};
			group _x setVariable ["VCM_Skilldisable", true];
			group _x setVariable ["Vcm_Disable", true];
		} forEach (allUnits select {side _x == independent && alive _x});

		sleep 10;
	};
};
