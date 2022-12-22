#define INFANTRY_FIND_EMPTY_DISTANCE 10
#define INFANTRY_WP_COMPLETION_RADIUS 5
#define VIC_FIND_EMPTY_DISTANCE 150
#define VIC_WP_COMPLETION_RADIUS 25
#define PACE_STOP -1
#define PACE_NORMAL 0
#define PACE_FAST 1
#define INFANTRY_REINFORCEMENTS_AFTER 8
#define MECHANIZED_REINFORCEMENTS_AFTER 16

Foley_fnc_deployPatrol = {
	params ["_routes"];
	_routes params ["_mainObjectives", "_infantryRoutes", "_vicRoutes"];

	private _infantryPlatoon = allGroups select {side _x == independent && _x getVariable ["Foley_infantryPlatoon", false]};
	private _vicPlatoon = allGroups select {side _x == independent && _x getVariable ["Foley_vicPlatoon", false]};

	assert (count _infantryPlatoon <= count _infantryRoutes);
	assert (count _vicPlatoon <= count _vicRoutes);

	{
		private _group = _x;
		private _groupIndex = _forEachIndex;
		private _route = _infantryRoutes select _groupIndex;
		_route params ["_objectives", "_paths"];

		assert (count _objectives > 0);
		assert (count _paths == (count _objectives) - 1);

		private _initialPosition = _objectives select 1;

		{
			private _unit = _x;
			private _pos = [_initialPosition, 5, INFANTRY_FIND_EMPTY_DISTANCE, 3] call BIS_fnc_findSafePos;

			if (_pos isEqualTo []) then {
				_pos = _initialPosition getPos [5 + random (INFANTRY_FIND_EMPTY_DISTANCE - 5), random 360];
			};

			_unit setPos _initialPosition;
			_unit doFollow leader _group;
		} forEach units _group;

		_group setVariable ["Foley_progressMajor", 0];
		_group setVariable ["Foley_progressMinor", 0];
		_group setVariable ["Foley_requestedPace", PACE_NORMAL];

		{
			private _objectiveIndex = _forEachIndex + 2;
			private _waypointPositions = _x;

			{
				private _waypointPosition = _x;
				private _waypointIndex = _forEachIndex;

				private _wp = _group addWaypoint [_waypointPosition, 0];
    			_wp setWaypointType "MOVE";
				_wp setWaypointCompletionRadius INFANTRY_WP_COMPLETION_RADIUS;

				private _condition = {
					(group this) getVariable "Foley_requestedPace" != PACE_STOP
				};
				
				private _statement = {
					(group this) setVariable ["Foley_progressMajor", __MAJOR__];
					(group this) setVariable ["Foley_progressMinor", __MINOR__];
				};
				private _statementStr = str _statement;
   				_statementStr = _statementStr regexReplace ["__MAJOR__", str _objectiveIndex];
   				_statementStr = _statementStr regexReplace ["__MINOR__", ((_waypointIndex + 1) / count _waypointPositions) toFixed 2];

    			_wp setWaypointStatements ["call " + str _condition, "call " + _statementStr];
			} forEach _waypointPositions;
		} forEach (_paths select [1, count _paths]);
	} forEach _infantryPlatoon;

	{
		private _group = _x;
		private _groupIndex = _forEachIndex;
		private _route = _vicRoutes select _groupIndex;
		_route params ["_objectives", "_paths"];

		assert (count _objectives > 0);
		assert (count _paths == (count _objectives) - 1);

		private _initialPosition = _objectives select 1;
		private _vehiclesDuplicated = (units _group) select {vehicle _x != _x};
		private _vehicles = [];
		{
			_vehicles pushBackUnique (vehicle _x);
		} forEach _vehiclesDuplicated;

		{
			private _vehicle = _x;
			private _pos = [_initialPosition, 5, VIC_FIND_EMPTY_DISTANCE, 6] call BIS_fnc_findSafePos;

			if (_pos isEqualTo []) then {
				_pos = _initialPosition getPos [5 + random (INFANTRY_FIND_EMPTY_DISTANCE - 5), random 360];
			};

			[_vehicle, _pos] spawn {
				params ["_vehicle", "_pos"];

				_vehicle allowDamage false;
				_vehicle setPos _pos;

				sleep 10;
				_vehicle allowDamage true;
			};
			_vehicle setVariable ["Foley_stuckFor", 0];
			_vehicle setVariable ["Foley_lastPosition", getPosATL _vehicle];
			_vehicle setVariable ["Foley_lastPositionTime", time];
		} forEach _vehicles;

		_group setVariable ["Foley_progressMajor", 0];
		_group setVariable ["Foley_progressMinor", 0];
		_group setVariable ["Foley_requestedPace", PACE_NORMAL];

		{
			private _objectiveIndex = _forEachIndex + 2;
			private _waypointPositions = _x;

			{
				private _waypointPosition = _x;
				private _waypointIndex = _forEachIndex;

				private _nearRoads = nearestTerrainObjects [
					_waypointPosition, 
					["ROAD", "MAIN ROAD", "TRACK", "TRAIL"],
					20,
					true
				];

				if (count _nearRoads > 0) then {
					_waypointPosition = getPos (_nearRoads select 0);
				};

				private _wp = _group addWaypoint [_waypointPosition, 0];
    			_wp setWaypointType "MOVE";
				_wp setWaypointCompletionRadius VIC_WP_COMPLETION_RADIUS;

				private _condition = { true };
				
				if (_waypointIndex == count _waypointPositions - 1) then {
					_condition = {
						(group this) getVariable "Foley_requestedPace" >= PACE_NORMAL
					};
				};
				
				private _statement = {
					(group this) setVariable ["Foley_progressMajor", __MAJOR__];
					(group this) setVariable ["Foley_progressMinor", __MINOR__];
				};
				private _statementStr = str _statement;
   				_statementStr = _statementStr regexReplace ["__MAJOR__", str _objectiveIndex];
   				_statementStr = _statementStr regexReplace ["__MINOR__", ((_waypointIndex + 1) / count _waypointPositions) toFixed 2];

    			_wp setWaypointStatements ["call " + str _condition, "call " + _statementStr];
			} forEach _waypointPositions;
		} forEach (_paths select [1, count _paths]);
	} forEach _vicPlatoon;

	[] spawn {
		while {true} do {
			private _infantryPlatoon = allGroups select {side _x == independent && _x getVariable ["Foley_infantryPlatoon", false]};
			private _vicPlatoon = allGroups select {side _x == independent && _x getVariable ["Foley_vicPlatoon", false]};

			private _progress = _infantryPlatoon apply {
				(_x getVariable ["Foley_progressMajor", 0]) + (_x getVariable ["Foley_progressMinor", 0])
			};

			private _averageProgress = _progress call BIS_fnc_arithmeticMean;
			
			{
				private _group = _x;
				private _groupProgress = (_group getVariable ["Foley_progressMajor", 0]) + (_group getVariable ["Foley_progressMinor", 0]);

				private _pace = PACE_NORMAL;

				if (_groupProgress > _averageProgress + 0.15 || ceil _groupProgress > ceil (_averageProgress + 0.05)) then {
					_pace = PACE_STOP;
				};

				if (_groupProgress < _averageProgress - 0.15) then {
					_pace = PACE_FAST;
				};

				_group setVariable ["Foley_requestedPace", _pace];
			} forEach _infantryPlatoon;

			{
				private _group = _x;
				private _groupProgress = (_group getVariable ["Foley_progressMajor", 0]) + (_group getVariable ["Foley_progressMinor", 0]);

				private _pace = PACE_NORMAL;

				if (_groupProgress > _averageProgress) then {
					_pace = PACE_STOP;
				};

				_group setVariable ["Foley_requestedPace", _pace];
			} forEach _vicPlatoon;

			private _vehicles = vehicles select {(group driver _x) in _vicPlatoon && canMove _x};
			{
				private _vehicle = _x;
				private _group = group driver _vehicle;

				if (isNil "_group") then {
					continue;
				};

				private _pace = _group getVariable "Foley_requestedPace";
				private _lastPosition = _vehicle getVariable "Foley_lastPosition";
				
				if (_pace >= PACE_NORMAL && alive driver _vehicle && canMove _vehicle) then {
					if (_lastPosition distance (getPosATL _vehicle) < 5) then {
						private _diff = time - (_vehicle getVariable "Foley_lastPositionTime");
						_vehicle setVariable ["Foley_stuckFor", (_vehicle getVariable "Foley_stuckFor") + _diff];
					} else {
						_vehicle setVariable ["Foley_stuckFor", 0];
					};
				} else {
					_vehicle setVariable ["Foley_stuckFor", 0];
				};

				_vehicle setVariable ["Foley_lastPosition", getPosATL _vehicle];
				_vehicle setVariable ["Foley_lastPositionTime", time];

				[_vehicle] spawn {
					params ["_vehicle"];

					while {alive _vehicle} do {
						private _friendliesNearby = {
							side _x == independent &&
							alive _x &&
							_x distance _vehicle < 25
						} count allUnits;

						if (_friendliesNearby > 0) then {
							_vehicle limitSpeed 20;
							
							private _friendlyInfantryDangerClose = {
								side _x == independent &&
								vehicle _x == _x &&
								alive _x &&
								_x distance _vehicle < 10
							} count allUnits;

							if (_friendlyInfantryDangerClose > 0) then {
								_vehicle limitSpeed 1;
							};
						} else {
							_vehicle limitSpeed -1;
						};

						sleep 1;
					};
				};
			} forEach _vehicles;

			sleep 5;
		};
	};

	[] spawn {
		private _infantryPlatoon = allGroups select {side _x == independent && _x getVariable ["Foley_infantryPlatoon", false]};

		{
			private _group = _x;

			_group setBehaviour "AWARE";
			_group setFormation "FILE";
			_group setSpeedMode "NORMAL";
		} forEach _infantryPlatoon;

		sleep 15;

		while {true} do {
			private _infantryPlatoon = allGroups select {side _x == independent && _x getVariable ["Foley_infantryPlatoon", false]};
			private _vicPlatoon = allGroups select {side _x == independent && _x getVariable ["Foley_vicPlatoon", false]};
			private _vehicles = vehicles select {(group driver _x) in _vicPlatoon && canMove _x};
			private _joinableGroups = [_infantryPlatoon, [], {{alive _x} count (units _x)}, "ASCEND", {{alive _x} count (units _x) >= 3}] call BIS_fnc_sortBy;
			private _infantryPositions = (_infantryPlatoon apply {getPos leader _x}) select {!(_x isEqualTo [0, 0, 0])};
			private _infantryCenter = [0, 0, 0];
			private _isNighttime = dayTime > 20 || dayTime < 4;

			if (count _infantryPositions > 0) then {
				{
					_infantryCenter = _infantryCenter vectorAdd _x;
				} forEach _infantryPositions;
				_infantryCenter = _infantryCenter vectorMultiply (1 / count _infantryPositions);
			};

			{
				private _group = _x;
				private _pace = _group getVariable "Foley_requestedPace";

				if (_pace == PACE_FAST) then {
					_group setBehaviour "AWARE";
					_group setFormation "STAG COLUMN";
					_group setCombatMode "GREEN";
					_group setSpeedMode "NORMAL";
				};

				if (_pace == PACE_NORMAL) then {
					_group setBehaviour "SAFE";
					_group setFormation "STAG COLUMN";
					_group setCombatMode "GREEN";
					_group setSpeedMode "LIMITED";
				};

				if (_pace == PACE_STOP) then {
					_group setBehaviour "AWARE";
					_group setFormation "WEDGE";
					_group setCombatMode "GREEN";
					_group setSpeedMode "LIMITED";
					private _dir = _infantryCenter getDir (leader _group);
					(leader _group) setDir _dir;
					_group setFormDir _dir;
				};

				if (count _joinableGroups > 0) then {
					private _groupToJoin = _joinableGroups select 0;
					if ({alive _x} count (units _group) <= 2 && _group != _groupToJoin) then {
						(units _group) join _groupToJoin;
					};
				};

				if (_isNighttime) then {
					_group enableGunLights "ForceOn";
				} else {
					_group enableGunLights "ForceOff";
				};
				
				{
					private _unit = _x;

					if (_unit distance leader _group > 100) then {
						_unit setPos (_unit getPos [random 0.5, random 360]);
						_unit doFollow leader _group;
					};

					if (_isNighttime) then {
						if (random 100 < 67 || damage _unit > 0.1) then {
							_unit disableAI "LIGHTS";
						} else {
							_unit enableAI "LIGHTS";
						};
					} else {
						_unit disableAI "LIGHTS";
					};
				} forEach units _group;
			} forEach _infantryPlatoon;

			private _joinableVicGroups = [_vicPlatoon, [], {{alive _x} count (units _x)}, "ASCEND", {{alive _x} count (units _x) >= 3}] call BIS_fnc_sortBy;
			{
				private _group = _x;
				private _pace = _group getVariable "Foley_requestedPace";

				if (_pace == PACE_STOP) then {
					_group setBehaviour selectRandom ["AWARE", "COMBAT"];
					_group setFormation "FILE";
					_group setCombatMode "RED";
					_group setSpeedMode "LIMITED";

					private _targets = (leader _group) targets [true, 600];

					if (count _targets == 0) then {
						_group setFormDir random 360;
						private _gunner = gunner vehicle leader _group;

						if (!isNil "_gunner") then {
							_gunner doWatch (_gunner getPos [50 + random 250, random 360]);
						};
					};
				} else {
					_group setBehaviour "SAFE";
					_group setFormation "FILE";
					_group setCombatMode "GREEN";
					_group setSpeedMode "NORMAL";
				};

				if (count _joinableVicGroups > 0) then {
					private _groupToJoin = _joinableVicGroups select 0;

					if (_group == _groupToJoin && count _joinableVicGroups >= 2) then {
						_groupToJoin = _joinableVicGroups select 1;
					};

					private _groupHasVehicle = ({vehicle _x != _x && canMove vehicle _x} count units _group) > 0;

					if (!_groupHasVehicle && _group != _groupToJoin) then {
						(units _group) join _groupToJoin;
					};
				};
			} forEach _vicPlatoon;

			{
				private _vehicle = _x;
				private _group = group driver _vehicle;
				private _driver = driver _x;

				if (isNil "_group" || isNil "_driver") then {
					continue;
				};

				if (_vehicle getVariable "Foley_stuckFor" < 30) then {
					continue;
				};

				private _temporaryDestination = _vehicle getPos [5, getDir _vehicle];

				_group move _temporaryDestination;
				_driver doMove _temporaryDestination;
				
				private _playersNearby = {_x distance _vehicle < 200 && alive _x} count allPlayers;

				if (_playersNearby == 0) then {
					private _adjustedPosition = _vehicle getPos [-0.2 + random 0.4, getDir _vehicle];
					_vehicle setPos _adjustedPosition;
				};

				sleep 0.1;
				_driver doFollow (leader _group);

				sleep 0.1;
				_group setCurrentWaypoint [_group, (currentWaypoint _group) + 1];
			} forEach _vehicles;

			sleep 15;
		};
	};
};

Foley_fnc_deployStationedGroups = {
	private _mechanizedPlatoon = allGroups select {side _x == independent && _x getVariable ["Foley_mechanizedPlatoon", false]};
	private _secondInfantryPlatoon = allGroups select {side _x == independent && _x getVariable ["Foley_secondInfantryPlatoon", false]};
	private _staticGuns = allGroups select {side _x == independent && _x getVariable ["Foley_staticGuns", false]};

	{
		private _group = _x;

		{
			private _unit = _x;
			doStop _unit;
		} forEach units _group;
	} forEach _staticGuns;

	[_mechanizedPlatoon + _secondInfantryPlatoon] spawn {
		params ["_haltedGroups"];

		{
			private _group = _x;
			_group setVariable ["Foley_reinforcementsRequested", false];
			{
				private _unit = _x;
				_unit enableSimulationGlobal false;
			} forEach units _group;
		} forEach _haltedGroups;

		while {count _haltedGroups > 0} do {
			{
				private _group = _x;
				private _leader = leader _group;

				if (
					{side _x == blufor && _x distance _leader < 500} count allUnits > 0 ||
					_group getVariable "Foley_reinforcementsRequested"
				) then {
					{
						private _unit = _x;
						_unit enableSimulationGlobal true;
					} forEach units _group;
					_haltedGroups deleteAt (_haltedGroups find _group);
				};

			} forEach _haltedGroups;

			sleep 2;
		};
	};

	[_mechanizedPlatoon, _secondInfantryPlatoon] spawn {
		params ["_mechanizedPlatoon", "_secondInfantryPlatoon"];

		sleep 15;

		private _initialStrength = {side _x == independent && alive _x} count allUnits;

		waitUntil {
			sleep 5;
			private _currentStrength = {side _x == independent && alive _x} count allUnits;

			_currentStrength <= _initialStrength - INFANTRY_REINFORCEMENTS_AFTER
		};
		
		{
			private _group = _x;
			private _threat = selectRandom (allUnits select {side _x == blufor && independent knowsAbout _x >= 2});

			if (isNil "_threat") then {
				_threat = getMarkerPos "start_marker";
			} else {
				_threat = getPos _threat;
			};

			_group setVariable ["Foley_reinforcementsRequested", true];

			private _approachPos = _threat getPos [250 + random 250, _threat getDir (leader _group)];
			private _wp = _group addWaypoint [_approachPos, 0];
			_wp setWaypointType "MOVE";
			_wp setWaypointBehaviour "AWARE";
			_wp setWaypointCombatMode "YELLOW";
			_wp setWaypointSpeed "FULL";
			_wp setWaypointFormation "STAG COLUMN";
			_wp setWaypointTimeout [5, 30, 120];
			
			private _wp = _group addWaypoint [_threat, 100];
			_wp setWaypointType "SAD";
			_wp setWaypointBehaviour "AWARE";
			_wp setWaypointCombatMode "RED";
			_wp setWaypointSpeed "NORMAL";
			_wp setWaypointFormation "WEDGE";

			private _wp = _group addWaypoint [_threat, 100];
			_wp setWaypointType "GUARD";
		} forEach _secondInfantryPlatoon;

		waitUntil {
			sleep 5;
			private _currentStrength = {side _x == independent && alive _x} count allUnits;

			_currentStrength <= _initialStrength - MECHANIZED_REINFORCEMENTS_AFTER
		};

		{
			private _group = _x;

			_group setVariable ["Foley_reinforcementsRequested", true];
		} forEach _mechanizedPlatoon;
	};
};

Foley_fnc_deployCamps = {
	if (isNil "lambs_wp_fnc_taskCamp") exitWith {};

	{
		private _leader = leader _x;
		private _area = [50, 50, 0, false, 50];
		[_leader, getPos _leader, 50, _area, true, true] call lambs_wp_fnc_taskCamp;
	} forEach [Foley_campGroup1, Foley_campGroup2];
};
