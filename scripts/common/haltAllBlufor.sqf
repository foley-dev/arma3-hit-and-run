{
	doStop _x;
	if (leader group _x != _x) then {
		_x lookAt ASLToAGL eyePos leader group _x;
	};
} forEach (allUnits select {side _x == blufor});
