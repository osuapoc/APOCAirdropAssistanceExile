scriptName "onOpen";
/*--------------------------------------------------------------------
// ******************************************************************************************
// * This script is licensed under the GNU Lesser GPL v3.
// ******************************************************************************************
	file: onLoad.sqf
	======
	Author: Bill Springer <Apoc@MayhemServers.com>
	Description: XM8 App onOpen for ExAd APOC Airdrop Port
--------------------------------------------------------------------*/
params["_display","_slide","_idc","_DropCategories","_Category","_idcCbDropCategories"];

_display = uiNameSpace getVariable ["RscExileXM8", displayNull];

_idcCbDropCategories = ctrlIDC ([_display,"ExAd_APOC_Airdrop","cbDropCategories"] call ExAd_fnc_getAppCtrl);
lbClear _idcCbDropCategories;

// Establish Category List from config file
  _DropCategories = []; //Clear the array
  /*diag_log format ["AAA - Config Count is %1",count APOC_AA_Drops];*/
  for "_i" from 0 to (count APOC_AA_Drops)-1 do {
    _Category = (APOC_AA_Drops select _i) select 0; //Grabs the string of the drop category ie: "Vehicles" or "Supplies" or "Lawn Gnomes"
    /*diag_log format ["AAA - Config Category is %1", _Category];*/
    _DropCategories pushBack _Category;
    /*diag_log format ["AAA - Config Category is %1", _DropCategories];*/
  };

  {
    (_display displayCtrl _idcCbDropCategories) lbAdd Format["%1",_x];
    (_display displayCtrl _idcCbDropCategories) lbSetData [_forEachIndex,_x];
  } foreach _DropCategories;
(_display displayCtrl _idcCbDropCategories) lbSetCurSel 0; //Try and select the first value from the newly populated listbox, should force the downstream listbox to populate as well, due to EH firing

