diag_log "foo startet";

_logscript = compile preprocessFileLineNumbers "sock-rpc\log.sqf";
call _logscript;

diag_log "fu: log.sqf ist fertig";

_sockscript = compile preprocessFileLineNumbers "sock-rpc\sock.sqf";
call _sockscript;

diag_log "start pinging sock_rpc...";

[] spawn {
	while {true} do {
		['echo', ['keep-alive']] call sock_rpc;
		sleep 20;
	};
};

['echo', ['keep-alive']] call sock_rpc;

if (isDedicated) then {

	addMissionEventHandler ["Ended", {
		['missionEnd', []] call sock_rpc;
	}];

	['missionStart', [missionName, worldName]] call sock_rpc;

	[] spawn {
		while {count allUnits > 0} do {
			{
				['setPlayerPosition', [name _x, getPos _x]] call sock_rpc;
			} forEach allUnits;

			sleep 1;
		};
	};

	[] spawn {
		while {count allUnits > 0} do {
			{
				['setPlayerSide', [name _x, format["%1", side _x]]] call sock_rpc;

			} forEach allUnits;
			sleep 100;
		}
	};

	[] spawn {
		while {count allUnits > 0} do {
			{
				status = 'unconscious';
				if (alive _x) then {
					status = 'alive';
				} else {
					status = 'dead';
				};
				['setPlayerStatus', [name _x, status]] call sock_rpc;

			} forEach allUnits;
			sleep 3;
		}
	};
};
