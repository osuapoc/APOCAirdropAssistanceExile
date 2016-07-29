/*--------------------------------------------------------------------
// ******************************************************************************************
// * This script is licensed under the GNU Lesser GPL v3.
// ******************************************************************************************
	file: functions.sqf
	======
	Author: Bill Springer <Apoc@MayhemServers.com>
	Description: XM8 App client functions for ExAd APOC Airdrop Port
--------------------------------------------------------------------*/

/* ************************************************************************
Functions Called from the Dialog
************************************************************************ */

fn_DropCategory_Load = {
	params ["_ctrl","_Selection","_Category","_Drop","_DropID","_DropDesc","_DropPrice","_playerMoney","_playerRespect"];
	_display = uiNameSpace getVariable ["RscExileXM8", displayNull];
	/*
	{
		_ctrlIDC = ctrlIDC ([_display,"ExAd_APOC_Airdrop",_x select 0] call ExAd_fnc_getAppCtrl);
		(_x select 1) = _ctrlIDC;

	} forEach
	[
		["cbDropCategories", _idcCbDropCategories],
		["lbDropList", _idcLbDropList],
		["lbDropContentList", _idcLbDropContentList],
		["btnOrderDrop", _idcBtnOrderDrop]
	];
	*/
	_idcCbDropCategories = ctrlIDC ([_display,"ExAd_APOC_Airdrop","cbDropCategories"] call ExAd_fnc_getAppCtrl);
	_idcLbDropList = ctrlIDC ([_display,"ExAd_APOC_Airdrop","lbDropList"] call ExAd_fnc_getAppCtrl);
	_idcLbDropContentList = ctrlIDC ([_display,"ExAd_APOC_Airdrop","lbDropContentList"] call ExAd_fnc_getAppCtrl);
	_idcBtnOrderDrop = ctrlIDC ([_display,"ExAd_APOC_Airdrop","btnOrderDrop"] call ExAd_fnc_getAppCtrl);

	lbClear _idcLbDropList;			//Clear Drop List lb
	lbClear _idcLbDropContentList;	//Clear Drop Content

	_Selection = _ctrl lbData (lbCurSel _ctrl);

	//Initializing some variables
	_Category = "";
	_Drop = "";
	_DropID = "";
	_DropDesc = "";
	_DropPrice  = 0;

	_playerMoney = 0;
	_playerRespect = 0;
	if (APOC_AA_UseExileLockerFunds) then {
	    _playerMoney = player getVariable ["ExileLocker",0];
	} else {
	   _playerMoney = player getVariable ["ExileMoney", 0];
	};

	_playerRespect = player getVariable ["ExileScore",0];
	//Load in the Drops under this category
	for "_i" from 0 to (count APOC_AA_Drops)-1 do {
	_Category = (APOC_AA_Drops select _i) select 0; //Grabs the string of the drop category ie: "Vehicles" or "Supplies" or "Lawn Gnomes"

	if (_Category == _Selection) then
	{
	  {
	    _DropDesc =  _x select 0;
	    _DropID = _x select 1;
	    _DropPrice = _x select 2;
	    if (count _x > 3) then {
	    	_DropRespectThreshold = _x select 4;
	    } else {
	    	_DropRespectThreshold = 0;
	    };


	    _Drop = format ["%1 - Cost: %2 tabs", _DropDesc, _DropPrice];

	    (_display displayCtrl _idcLbDropList) lbAdd Format["%1",_Drop];
	    (_display displayCtrl _idcLbDropList) lbSetData [_forEachIndex,_DropID];

	    if ((_DropPrice > _playerMoney)||(_DropRespectThreshold > _playerRespect)) then {
	        (_display displayCtrl _idcLbDropList) lbSetColor [_forEachIndex,[1,0,0,1]]; //Set drop text to red if too expensive for player
	    };

	    _toolTip = format ["Respect Required: %1", _DropRespectThreshold];
	    (_display displayCtrl _idcLbDropList) lbSetTooltip [_forEachIndex, _toolTip];

	  } forEach ((APOC_AA_Drops select _i) select 1);
	};
	};
};

fn_DropContents_Load = {
	_display = uiNameSpace getVariable ["RscExileXM8", displayNull];
	_ctrl = _this select 0;
	_Selection = _ctrl lbData (lbCurSel _ctrl);

	/*
	{
		_ctrlIDC = ctrlIDC ([_display,"ExAd_APOC_Airdrop",_x select 0] call ExAd_fnc_getAppCtrl);
		(_x select 1) = _ctrlIDC;

	} forEach
	[
		["cbDropCategories", _idcCbDropCategories],
		["lbDropList", _idcLbDropList],
		["lbDropContentList", _idcLbDropContentList],
		["btnOrderDrop", _idcBtnOrderDrop]
	];
	*/
	_idcCbDropCategories = ctrlIDC ([_display,"ExAd_APOC_Airdrop","cbDropCategories"] call ExAd_fnc_getAppCtrl);
	_idcLbDropList = ctrlIDC ([_display,"ExAd_APOC_Airdrop","lbDropList"] call ExAd_fnc_getAppCtrl);
	_idcLbDropContentList = ctrlIDC ([_display,"ExAd_APOC_Airdrop","lbDropContentList"] call ExAd_fnc_getAppCtrl);
	_idcBtnOrderDrop = ctrlIDC ([_display,"ExAd_APOC_Airdrop","btnOrderDrop"] call ExAd_fnc_getAppCtrl);

	lbClear _idcLbDropContentList; //Clear Drop Content lb

	//Initializing some variables
	_Drop = "";
	_DropID = "";
	_DropDesc = "";
	_DropPrice  = 0;
	//Load in the Drop contents under this DropID
	for "_i" from 0 to (count APOC_AA_Drop_Contents)-1 do {
	_DropID = (APOC_AA_Drop_Contents select _i) select 0;

		if (_DropID == _Selection) then
		{
		  {
		    _DropContentItemName = (_x select 1) select 0; //Only grab the first if multiple in the items
		    _DropContentDisplayName = getText (configfile >> "CfgMagazines" >> _DropContentItemName >> "displayName");
		    if (_DropContentDisplayName == "") then
		    {
		      _DropContentDisplayName = getText (configfile >> "CfgWeapons" >> _DropContentItemName >> "displayName");
		        if (_DropContentDisplayName =="") then
		        {
		          _DropContentDisplayName = getText (configfile >> "CfgVehicles" >> _DropContentItemName >> "displayName");
		        };
		    };
		    _DropContentQuantity = _x select 2;
		    /*diag_log format["AAA - Diagnostic - DropContentItemName=%1, DisplayName=%2",_DropContentItemName,_DropContentDisplayName];*/
		    _DropContent = format ["%1 - %2", _DropContentQuantity,_DropContentDisplayName];

		    (_display displayCtrl _idcLbDropContentList) lbAdd Format["%1",_DropContent];

		  } forEach ((APOC_AA_Drop_Contents select _i) select 1);
		};
	};
};

fn_OrderDrop = {
  private ["_DropDesc", "_DropPrice", "_DropType", "_CategorySelection", "_DropSelection"];
  //diag_log format["AAA - fn_OrderDrop Called"];
  _display = uiNameSpace getVariable ["RscExileXM8", displayNull];

	/*
	{
		_ctrlIDC = ctrlIDC ([_display,"ExAd_APOC_Airdrop",_x select 0] call ExAd_fnc_getAppCtrl);
		(_x select 1) = _ctrlIDC;

	} forEach
	[
		["cbDropCategories", _idcCbDropCategories],
		["lbDropList", _idcLbDropList],
		["lbDropContentList", _idcLbDropContentList],
		["btnOrderDrop", _idcBtnOrderDrop]
	];
	*/
	_idcCbDropCategories = ctrlIDC ([_display,"ExAd_APOC_Airdrop","cbDropCategories"] call ExAd_fnc_getAppCtrl);
	_idcLbDropList = ctrlIDC ([_display,"ExAd_APOC_Airdrop","lbDropList"] call ExAd_fnc_getAppCtrl);
	_idcLbDropContentList = ctrlIDC ([_display,"ExAd_APOC_Airdrop","lbDropContentList"] call ExAd_fnc_getAppCtrl);
	_idcBtnOrderDrop = ctrlIDC ([_display,"ExAd_APOC_Airdrop","btnOrderDrop"] call ExAd_fnc_getAppCtrl);

  _ctrl = (_display displayCtrl _idcCbDropCategories);
  _CategorySelection = _ctrl lbData (lbCurSel _ctrl);
  _ctrl = (_display displayCtrl _idcLbDropList);
  _DropSelection = _ctrl lbData (lbCurSel _ctrl);  //_DropId

  //Initializing some variables
  _Drop = "";
  _DropID = "";
  _DropDesc = "";
  _DropPrice  = "";

  //Very convoluted system to extract the price from the arrays
    for "_i" from 0 to (count APOC_AA_Drops)-1 do {
      _Category = (APOC_AA_Drops select _i) select 0; //Grabs the string of the drop category ie: "Vehicles" or "Supplies" or "Lawn Gnomes"
      if (_Category == _CategorySelection) then
      {
        //diag_log format["AAA - _Category line 179 = %1",_Category];
        {
          _Selection = _x select 1;
          if (_DropSelection == _Selection) then
          {
            //diag_log format["AAA - _Selection line 184 = %1",_Selection];
            _DropDesc = _x select 0;
            _DropPrice = _x select 2;
            _DropType = _x select 3;
		    if (count _x > 3) then {
		    	_DropRespectThreshold = _x select 4;
		    } else {
		    	_DropRespectThreshold = 0;
		    };

          };
        } forEach ((APOC_AA_Drops select _i) select 1);
      };
    };
    //diag_log format ["AAA - _DropPrice = %1", _DropPrice];
    //Dive out of the tree if an empty order is selected (or not)
    If (isNil "_DropType") exitWith {diag_log "AAA - _DropType Not Specified, cannot place order";};
    If (isNil "_DropDesc") exitWith {diag_log "AAA - _DropDesc Not Specified, cannot place order";};
    If (isNil "_DropPrice") exitWith {diag_log "AAA - _DropPrice Not Specified, cannot place order";};

    //diag_log format["AAA - _DropDesc = %1, _DropPrice = %2, _DropType = %3",_DropDesc,_DropPrice, _DropType];
    /////////////  Cooldown Timer ////////////////////////
      if (!isNil "APOC_AA_lastUsedTime") then
      {
      //diag_log format ["AAA - Last Used Time: %1; CoolDown Set At: %2; Current Time: %3",APOC_AA_lastUsedTime, APOC_AA_coolDownTime, diag_tickTime];
      _timeRemainingReuse = APOC_AA_coolDownTime - (diag_tickTime - APOC_AA_lastUsedTime); //time is still in s
      if ((_timeRemainingReuse) > 0) then
        {
          _NotificationText =  format["You need to wait %1 seconds before calling an airdrop again!", ceil _timeRemainingReuse];
          ["ErrorTitleandText",["Airdrop Error",_NotificationText]] call ExileClient_gui_toaster_addTemplateToast;
          playSound "FD_CP_Not_Clear_F";
          breakOut "onLoad";
        };
      };
      //diag_log format["AAA - Made it to line 203!, _DropPrice %1",_DropPrice];
    ////////////////////////////////////////////////////////
    _playerMoney = 0;
    _playerRespect = 0;
    if (APOC_AA_UseExileLockerFunds) then {
        _playerMoney = player getVariable ["ExileLocker",0];
    } else {
        _playerMoney = player getVariable ["ExileMoney", 0];
    };
    _playerRespect = player getVariable ["ExileScore", 0];
    //diag_log format["AAA - Made it to line 237!, _DropPrice %1, _playerMoney %2",_DropPrice, _playerMoney];
    if (_DropPrice > _playerMoney) exitWith
      {
        _NotificationText =  "You don't have enough money to request this airdrop!";
        ["ErrorTitleandText",["Airdrop Error",_NotificationText]] call ExileClient_gui_toaster_addTemplateToast;
        playSound "FD_CP_Not_Clear_F";
      };
    if (_DropRespectThreshold > _playerRespect) exitWith
      {
        _NotificationText =  "You don't have enough respect to request this airdrop!";
        ["ErrorTitleandText",["Airdrop Error",_NotificationText]] call ExileClient_gui_toaster_addTemplateToast;
        playSound "FD_CP_Not_Clear_F";
      };
    /////////////////////////
    //Do Stuff!

    ["startAirdrop",[_DropType,_DropSelection,netId player]] call ExAd_fnc_serverDispatch;

    APOC_AA_lastUsedTime = diag_tickTime;
    diag_log format ["AAA - Just Used Time: %1; CoolDown Set At: %2; Current Time: %3, Type %4, Selection %5",APOC_AA_lastUsedTime, APOC_AA_coolDownTime, diag_tickTime,_DropType,_DropSelection];
    // Give some feedback that the pilot has heard the call to action!
    _NotificationText = format ["Your airdrop is on its way!  ETA ~90 seconds!"]; //You could put a variable here in case you change the spawn in distance
    ["SuccessTitleandText",["Airdrop Success!",_NotificationText]] call ExileClient_gui_toaster_addTemplateToast;
    playSound3D ["a3\sounds_f\sfx\radio\ambient_radio17.wss",player,false,getPosASL player,1,1,25]; // Thanks Lodac (TOParma!)
    //TO THE SERVER FUNCTION!
};