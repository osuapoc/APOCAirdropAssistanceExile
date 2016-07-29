scriptName "onLoad";
/*--------------------------------------------------------------------
// ******************************************************************************************
// * This script is licensed under the GNU Lesser GPL v3.
// ******************************************************************************************
	file: onLoad.sqf
	======
	Author: Bill Springer <Apoc@MayhemServers.com>
	Description: XM8 App onLoad for ExAd APOC Airdrop Port
--------------------------------------------------------------------*/

params["_display","_slide","_idc"];

_pW = 0.025;
_pH = 0.04;
_leftCol = 1;
_leftColW = 12.8;
_rightCol = _leftCol + _leftColW + 2;
_rightColW = _leftColW + 3;
_margin = 0.2;

_slideClass = "ExAd_APOC_Airdrop";

[_display,_slide,([_slideClass,"backButton"] call ExAd_fnc_getNextIDC),[27 * _pW, 17 * _pH, 6 * _pW, 1 * _pH],'["extraApps", 1] call ExileClient_gui_xm8_slide;',"Go Back"] call ExAd_fnc_createButton;

_newParent = [_display,_slide,([_slideClass,"ctrlGrp"] call ExAd_fnc_getNextIDC),[_leftCol * _pW, 1 * _pH, (_leftColW + _rightCol + 6) * _pW, 16 * _pH]] call ExAd_fnc_createCtrlGrp;

_idcCbDropCategories = [_slideClass,"cbDropCategories"] call ExAd_fnc_getNextIDC;
[_display,_slide,_idcCbDropCategories,[_leftCol * _pW, 4 * _pH, _leftColW * _pW, 1 * _pH],format["[_this select 0] call fn_DropCategory_Load"],""] call ExAd_fnc_createCombo;

_idcLbDropList = [_slideClass,"lbDropList"] call ExAd_fnc_getNextIDC;
[_display,_slide,_idcLbDropList,[_leftCol * _pW, 6 * _pH, _leftColW * _pW, 5 * _pH],format["[_this select 0] call fn_DropContents_Load"],""] call ExAd_fnc_createList;

_idcLbDropContentList = [_slideClass,"lbDropContentList"] call ExAd_fnc_getNextIDC;
[_display,_slide,_idcLbDropContentList,[_rightCol * _pW, 6 * _pH, _rightColW * _pW, 10 * _pH],format[""],""] call ExAd_fnc_createList;

_idcBtnOrderDrop = [_slideClass, "btnOrderDrop"] call ExAd_fnc_getNextIDC;
[_display,_slide,_idcBtnOrderDrop,[_leftCol*_pW, 17*_pH, _leftColW*_pW, 1 *_pH],format["_this call fn_OrderDrop"],"Order Drop",""] call ExAd_fnc_createButton;