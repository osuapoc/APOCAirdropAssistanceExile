/*--------------------------------------------------------------------
// ******************************************************************************************
// * This script is licensed under the GNU Lesser GPL v3.
// ******************************************************************************************
	file: config.cpp
	======
	Author: Bill Springer <Apoc@MayhemServers.com>
	Description: XM8 App config for ExAd APOC Airdrop Port Server Files
--------------------------------------------------------------------*/

class CfgPatches {
	class exad_apoc_airdrop {
		requiredVersion = 0.1;
		requiredAddons[] = {"ExAd_Core"};
	};
};

class CfgFunctions {
	class ExAdServer {
		class APOC_Airdrop {
			file = "exad_apoc_airdrop\Functions";
			class startAirdrop {};
			class findString {};
			class getBallMagazine {};
			class fillAirdrop {};
			class processItems {};
		};
	};
};

class CfgNetworkMessages
{
	class startAirdrop
	{
		parameters[] = {"STRING","STRING","STRING"};
	};
};