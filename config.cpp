class CfgXM8
{
	extraApps[] = {"ExAd_APOC_Airdrop"};

	class ExAd_APOC_Airdrop
	{
		title = "APOC Airdrop";
		controlID = 66000;					//IDC:66000 -> 66005 || These need to be unique and out of range from each other
		logo = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa";
		config = "ExadClient\XM8\Apps\APOC_Airdrop\config.sqf";
		onLoad = "ExAdClient\XM8\Apps\APOC_Airdrop\onLoad.sqf";
		onOpen = "ExAdClient\XM8\Apps\APOC_Airdrop\onOpen.sqf";
		onClose = "ExAdClient\XM8\Apps\APOC_Airdrop\onClose.sqf";
	};
};