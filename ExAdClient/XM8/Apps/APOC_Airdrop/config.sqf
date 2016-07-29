scriptName "config.sqf";
/*--------------------------------------------------------------------
// ******************************************************************************************
// * This script is licensed under the GNU Lesser GPL v3.
// ******************************************************************************************
	file: config.sqf
	======
	Author: Bill Springer <Apoc@MayhemServers.com>
	Description: XM8 App config for ExAd APOC Airdrop Port
--------------------------------------------------------------------*/
#include "functions.sqf"; //Dialog functions for the client

/* ************************************ */

APOC_AA_AdvancedBanking = false;		// Advanced Banking support. Change false to true if you run Advanced Banking on your server.  Not sure of 0.9.8 compatability.
APOC_AA_UseExileLockerFunds = false;	//Removes funds from player's locker stash instead of their hand
APOC_AA_DamageOnWhenLanded = false;		//Turn object allowDamage back on when object is on ground, instead of when in 'chute

APOC_AA_coolDownTime = 60; //Expressed in sec

APOC_AA_Drops =[
/*
	["Category Name",
		[
			["Text displayed to player",	"Name of vehicle or drop box",	cost, "vehicle or supply (use nothing but these two!)", respectThreshold]  //This is an array, use commas between, DUH!
		] //If something breaks with your list of drops, you've likely messed up the nested arrays.
	]
*/

//Also, presently, these are NON-Persistant vehicles.  Meaning that they will not last over a restart.  Keep that in mind with prices.  Later updates I'll set that up, with pin code entry.
	["Vehicles",
		[
			["Quadbike", 		"Exile_Bike_QuadBike_Black", 		10000, 	"vehicle", 1000],
			["Offroad", 		"Exile_Car_Offroad_Red",			20000, 	"vehicle", 1000],
			["Strider", 		"Exile_Car_Strider", 				30000, 	"vehicle", 1000]
		]
	],

	["Weapons",
		[
			["Sniper Rifles", 		"airdrop_Snipers", 			50000, "supply", 1000],
			["DLC Rifles", 			"airdrop_DLC_Rifles", 			45000, "supply", 1000],
			["DLC LMGs", 			"airdrop_DLC_LMGs", 			45000, "supply", 1000]
		]
	],

	["Supplies",
		[
			["Food (small)",		"airdrop_FoodSmall",			1000, "supply", 1000],
			["Food (large)",		"airdrop_FoodLarge",			5000, "supply", 1000]
		]
	]
];

APOC_AA_Drop_Contents =[
	["airdrop_Snipers",  //Name of the drop
		[
		// Item type, Item class(es), # of items, # of magazines per weapon
		// Valid item types: wep, itm, or bac.
			["wep", ["srifle_LRR_LRPS_F"],		1, 3],
			["wep", ["srifle_LRR_camo_LRPS_F"],	1, 3],
			["wep", ["srifle_GM6_LRPS_F"],		1, 3],
			["wep", ["srifle_GM6_camo_LRPS_F"],	1, 3]
		]
	],

	["airdrop_DLC_Rifles",
		[
			["wep", ["srifle_DMR_03_multicam_F"],	1, 3],
			["wep", ["srifle_DMR_02_sniper_F"],		1, 3],
			["wep", ["srifle_DMR_05_hex_F"],		1, 3],
			["wep", ["srifle_DMR_04_Tan_F"],		1, 3],

			// ["ItemType",[Array of items/weps to choose from randomly], number of items]
			// If using wep, you need also number of mags to be included.
			["itm", ["V_PlateCarrierIAGL_dgtl", "V_TacVest_camo", "V_PlateCarrierGL_rgr"], 2],
			["itm", ["bipod_01_F_blk", "bipod_02_F_hex"], 3],
			["itm", ["optic_DMS","optic_AMS","optic_tws","optic_KHS_blk"], 2],
			["itm", ["muzzle_snds_B", "muzzle_snds_338_black", "muzzle_snds_338_sand", "muzzle_snds_93mmg"], 2],
			["bac", ["B_Carryall_mcamo", "B_Kitbag_mcamo"], 2]
		]
	],

	["airdrop_DLC_LMGs",
		[
			["wep", ["MMG_02_black_F", "MMG_02_camo_F","MMG_02_sand_F","MMG_01_hex_F","MMG_01_tan_F"], 4,4],
			["itm", ["V_PlateCarrierIAGL_dgtl", "V_TacVest_camo", "V_PlateCarrierGL_rgr"], 2],
			["bac", ["B_Carryall_mcamo", "B_Kitbag_mcamo"], 2],
			["itm", ["bipod_01_F_blk", "bipod_02_F_hex"], 2],
			["itm", ["optic_DMS","optic_AMS","optic_tws","optic_KHS_blk"], 2],
			["itm", ["muzzle_snds_338_black", "muzzle_snds_338_sand", "muzzle_snds_93mmg"], 2]
		]
	],

	["airdrop_FoodSmall",
		[
			["itm", ["Exile_Item_EMRE","Exile_Item_GloriousKnakworst","Exile_Item_Surstromming"], 5],
			["itm", ["Exile_Item_EMRE","Exile_Item_GloriousKnakworst","Exile_Item_Surstromming"], 5],
			["itm", ["Exile_Item_PlasticBottleCoffee","Exile_Item_PlasticBottleFreshWater","Exile_Item_MountainDupe"], 5],
			["itm", ["Exile_Item_PlasticBottleCoffee","Exile_Item_PlasticBottleFreshWater","Exile_Item_MountainDupe"], 5]
		]
	],

	["airdrop_FoodLarge",
		[
			["itm", ["Exile_Item_EMRE","Exile_Item_GloriousKnakworst","Exile_Item_Surstromming"], 10],
			["itm", ["Exile_Item_EMRE","Exile_Item_GloriousKnakworst","Exile_Item_Surstromming"], 10],
			["itm", ["Exile_Item_PlasticBottleCoffee","Exile_Item_PlasticBottleFreshWater","Exile_Item_MountainDupe"], 10],
			["itm", ["Exile_Item_PlasticBottleCoffee","Exile_Item_PlasticBottleFreshWater","Exile_Item_MountainDupe"], 10]
		]
	]

];