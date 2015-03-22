ENABLE_REPLAY = (paramsArray select 0) == 1;
IS_STREAMABLE = (paramsArray select 1) == 1;

enableSaving [false, false];
waitUntil {isDedicated || {not(isNull player)}};

diag_log "start";

SYSTEM_LOG_LEVEL = 0;
execVM "export-missiondata.sqf";
