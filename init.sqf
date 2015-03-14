IS_STREAMABLE = paramsArray select 0;
enableSaving [false, false];
waitUntil {isDedicated || {not(isNull player)}};

diag_log "start";

SYSTEM_LOG_LEVEL = 0;
execVM "export-missiondata.sqf";
