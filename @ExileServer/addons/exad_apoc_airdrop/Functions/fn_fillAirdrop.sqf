// ******************************************************************************************
// * This script is licensed under the GNU Lesser GPL v3.
// ******************************************************************************************
// Based on the box-filling function from A3Wasteland (AgentRev)
// Reconfigurated to work for exile and all that jazz - Apoc
// OK, so hardly any original code left, but still props to 'Rev


if (!isServer) exitWith {};

private ["_object", "_DropSelection", "_dropItems"];
_object 		= _this select 0;
_DropSelection 	= _this select 1;

_object allowDamage false;

// Empty the crate, since ARMA has to auto-fill everything
clearBackpackCargoGlobal _object;
clearMagazineCargoGlobal _object;
clearWeaponCargoGlobal _object;
clearItemCargoGlobal _object;

//Finding Contents
 for "_i" from 0 to (count APOC_AA_Drop_Contents)-1 do {
    _Selection = (APOC_AA_Drop_Contents select _i) select 0;

    if (_DropSelection == _Selection) then
    {
      _dropItems = ((APOC_AA_Drop_Contents select _i) select 1);
    };
  };

//Call the filling of the crate function
[_object, _dropItems] call processItems;
