// ******************************************************************************************
// * This script is licensed under the GNU Lesser GPL v3.
// ******************************************************************************************
// Apoc's Airdrop Assistance
// https://github.com/osuapoc
//Init for Airdrop Assistance
//Author: Apoc
//
#include "config.sqf"

if (isServer) then {
APOC_srv_startAirdrop = compile preprocessFileLineNumbers "Custom\APOC_Airdrop_Assistance\APOC_srv_startAirdrop.sqf";
serv_fillAirdrop = compile preprocessFileLineNumbers "Custom\APOC_Airdrop_Assistance\serv_fillAirdrop.sqf";
processItems = compile preprocessFileLineNumbers "Custom\APOC_Airdrop_Assistance\processItems.sqf";

//A3Wasteland Functions (AgentRev and crew)
getBallMagazine = compile preprocessFileLineNumbers "Custom\APOC_Airdrop_Assistance\getBallMagazine.sqf";
fn_findString = compile preprocessFileLineNumbers "Custom\APOC_Airdrop_Assistance\fn_findString.sqf";

diag_log "APOC_Airdrop_Assistance functions compiled on Server";
};


