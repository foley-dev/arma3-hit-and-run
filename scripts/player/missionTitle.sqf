params ["_requiredDistance", "_destination", "_text"];

sleep 3;

waitUntil {
	sleep 1;
	(getPos player) distance _destination > _requiredDistance
};

[parseText _text, true, nil, 7, 0.7, 0] spawn BIS_fnc_textTiles;
