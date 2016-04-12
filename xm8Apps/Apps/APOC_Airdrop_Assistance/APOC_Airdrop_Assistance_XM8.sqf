/*
BASE script made by Shix http://www.exilemod.com/profile/4566-shix/
this is just the base for any project so scripters do not have to figure out how to hide controlls and figure out a go back solution
Made for XM8 Apps http://www.exilemod.com/topic/9040-updated-xm8-apps/
I would strongly suggest reading these 2 BIS WIKI articles if you have never done anything like this before
https://community.bistudio.com/wiki/ctrlCreate
https://community.bistudio.com/wiki/ctrlSetPosition
*/

// ******************************************************************************************
// * This script is licensed under the GNU Lesser GPL v3.
// ******************************************************************************************
// Apoc's Airdrop Assistance
// https://github.com/osuapoc
// Basic Framework for the XM8 app by Shix (http://www.exilemod.com/topic/9040-xm8-apps/), all credit for that work is to his greatness
// GNU Licensing required for my portions to comply with borrowed function from A3Wasteland


disableSerialization;
scriptName "APOC_Airdrop_Assistance_XM8";

_display = uiNameSpace getVariable ["RscExileXM8", displayNull];

//Hides all xm8 apps controlls then deletes them for a smooth transition
_xm8Controlls = [991,881,992,882,993,883,994,884,995,885,996,886,997,887,998,888,999,889,9910,8810,9911,8811,9912,8812];
{
    _fade = _display displayCtrl _x;
    _fade ctrlSetFade 1;
    _fade ctrlCommit 0.5;
} forEach _xm8Controlls;
{
    ctrlDelete ((findDisplay 24015) displayCtrl _x);
} forEach _xm8Controlls;
uiSleep 0.2;

//Custom Code In Here //

_cbDropCategories = _display ctrlCreate ["RscCombo",6601];
_cbDropCategories ctrlSetPosition [0.085,0.18,0.38,0.04];
_cbDropCategories ctrlSetEventHandler ["LBSelChanged", "_this call fn_DropCategory_Load"];
_cbDropCategories ctrlCommit 0;

_lbDropList = _display ctrlCreate ["RscListBox", 6602];
_lbDropList ctrlSetPosition [0.085, 0.24, 0.38, 0.28];
_lbDropList ctrlSetEventHandler ["LBSelChanged", "_this call fn_DropContents_Load"];
_lbDropList ctrlCommit 0;

_lbDropContentList = _display ctrlCreate ["RscListBox", 6603];
_lbDropContentList ctrlSetPosition [0.48, 0.24, 0.42, 0.57];
_lbDropContentList ctrlCommit 0;

_btnOrderDrop = _display ctrlCreate ["RscButtonMenu", 6604];
_btnOrderDrop ctrlSetPosition [0.48,0.18,0.21,0.04];
_btnOrderDrop ctrlCommit 0;
_btnOrderDrop ctrlSetText "Order Drop";
_btnOrderDrop ctrlSetEventHandler ["ButtonClick", "_this call fn_OrderDrop;"];


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
    (_display displayCtrl 6601) lbAdd Format["%1",_x];
    (_display displayCtrl 6601) lbSetData [_forEachIndex,_x];
  } foreach _DropCategories;
(_display displayCtrl 6601) lbSetCurSel 0; //Try and select the first value from the newly populated listbox, should force the downstream listbox to populate as well, due to EH firing


//Created the go back button and add the button click event handeler to it
//Note you do need to add all Idds for all the controlls you have created to the _Ctrls array
_GoBackBtn = _display ctrlCreate ["RscButtonMenu", 1116];
_GoBackBtn ctrlSetPosition [(32 - 3) * (0.025),(20 - 2) * (0.04),6 * (0.025),1 * (0.04)];
_GoBackBtn ctrlCommit 0;
_GoBackBtn ctrlSetText "Go Back";
_GoBackBtn ctrlSetEventHandler ["ButtonClick", "[] call fnc_goBack"];

fnc_goBack = {
  _display = uiNameSpace getVariable ["RscExileXM8", displayNull];
  _Ctrls = [6601,6602,6603,6604,1116]; //Place ctrl ids here
  {
      _ctrl = (_display displayCtrl _x);
      _ctrl ctrlSetFade 1;
      _ctrl ctrlCommit 0.25;
      ctrlEnable [_x, false];
  } forEach _Ctrls;
  execVM "xm8Apps\XM8Apps_Init.sqf";
  {
    ctrlDelete ((findDisplay 24015) displayCtrl _x);
  } forEach _Ctrls;
};

//APOC_Airdrop_Assistance Functions
fn_DropCategory_Load = {
  _display = uiNameSpace getVariable ["RscExileXM8", displayNull];
  lbClear 6602; //Clear Drop List lb
  lbClear 6603; //Clear Drop Content lb

  _ctrl = _this select 0;
  _Selection = _ctrl lbData (lbCurSel _ctrl);

    //Initializing some variables
  _Category = "";
  _Drop = "";
  _DropID = "";
  _DropDesc = "";
  _DropPrice  = 0;
  //Load in the Drops under this category
  for "_i" from 0 to (count APOC_AA_Drops)-1 do {
    _Category = (APOC_AA_Drops select _i) select 0; //Grabs the string of the drop category ie: "Vehicles" or "Supplies" or "Lawn Gnomes"

    if (_Category == _Selection) then
    {
      {
        _DropDesc =  _x select 0;
        _DropID = _x select 1;
        _DropPrice = _x select 2;

        _Drop = format ["%1 - Cost: %2 tabs", _DropDesc, _DropPrice];

        (_display displayCtrl 6602) lbAdd Format["%1",_Drop];
        (_display displayCtrl 6602) lbSetData [_forEachIndex,_DropID];

      } forEach ((APOC_AA_Drops select _i) select 1);
    };
  };
};

fn_DropContents_Load = {
  _display = uiNameSpace getVariable ["RscExileXM8", displayNull];
  lbClear 6603; //Clear Drop Content lb
  _ctrl = _this select 0;
  _Selection = _ctrl lbData (lbCurSel _ctrl);

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

        (_display displayCtrl 6603) lbAdd Format["%1",_DropContent];

      } forEach ((APOC_AA_Drop_Contents select _i) select 1);
    };
  };
};

fn_OrderDrop = {
  private ["_DropDesc", "_DropPrice", "_DropType", "_CategorySelection", "_DropSelection"];
  //diag_log format["AAA - fn_OrderDrop Called"];
  _display = uiNameSpace getVariable ["RscExileXM8", displayNull];
  _ctrl = (_display displayCtrl 6601);
  _CategorySelection = _ctrl lbData (lbCurSel _ctrl);
  _ctrl = (_display displayCtrl 6602);
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
          ["Whoops",[_NotificationText]] call ExileClient_gui_notification_event_addNotification;
          playSound "FD_CP_Not_Clear_F";
          breakOut "APOC_Airdrop_Assistance_XM8";
        };
      };
      //diag_log format["AAA - Made it to line 203!, _DropPrice %1",_DropPrice];
    ////////////////////////////////////////////////////////

    _playerMoney = ExileClientPlayerMoney;
    if (_DropPrice > _playerMoney) exitWith
      {
        format["You don't have enough money in the bank to request this airdrop!"];
        _NotificationText =  format["You don't have enough money in the bank to request this airdrop!", ceil _timeRemainingReuse];
        ["Whoops",[_NotificationText]] call ExileClient_gui_notification_event_addNotification;
        playSound "FD_CP_Not_Clear_F";
      };
    /////////////////////////
    //Do Stuff!

    [_DropType,_DropSelection,player] remoteExec ["APOC_srv_startAirdrop",2]; //Make sure you whitelisted this!
    APOC_AA_lastUsedTime = diag_tickTime;
    diag_log format ["AAA - Just Used Time: %1; CoolDown Set At: %2; Current Time: %3, Type %4, Selection %5",APOC_AA_lastUsedTime, APOC_AA_coolDownTime, diag_tickTime,_DropType,_DropSelection];
    // Give some feedback that the pilot has heard the call to action!
    _NotificationText = format ["Your airdrop is on its way!  ETA ~90 seconds!"]; //You could put a variable here in case you change the spawn in distance
    ["Success",[_NotificationText]] call ExileClient_gui_notification_event_addNotification;
    playSound3D ["a3\sounds_f\sfx\radio\ambient_radio17.wss",player,false,getPosASL player,1,1,25]; // Thanks Lodac (TOParma!)
    //TO THE SERVER FUNCTION!
};
