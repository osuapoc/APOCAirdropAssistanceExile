class CfgRemoteExec
{
	class Functions
	{
		mode = 1;
		jip = 0;
		class fnc_AdminReq { allowedTargets=2; };
		class ExileServer_system_network_dispatchIncomingMessage { allowedTargets=2; };
		class APOC_srv_startAirdrop { allowedTargets=2;};
	};
	class Commands
	{
		mode=0;
		jip=0;
	};
};
