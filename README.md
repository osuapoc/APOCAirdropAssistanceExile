# APOCAirdropAssistanceExile
The Airdrop System ported for Exile!
# Apoc's Airdrop Assistance XM8 App
This app allows you to call in chopper-carried airdrops of supplies or vehicles.  You can configure as many aidrops as you'd like, with as many categories as you'd like.

This is an Exile port of the original Airdrop Assistance script that I put together for A3Wasteland.  Blame my laziness for the delay, I'm OK with that.

Creation of vehicles, AI, and supply boxes is handled server side.  Money handling is also completed by the server using Exile functions.

# Credits
[@Janski](http://www.exilemod.com/topic/13865-updated-tutorial-appexad-package-of-virtual-garagexm8halo-parachuteadmin-eventshackinggrindingvehicle-upgrade/)

[@AgentRev](http://forums.a3wasteland.com/index.php?action=profile;u=53) - for use of some of the A3Wasteland Functions

[@CreamPie](http://forums.a3wasteland.com/index.php?action=profile;u=260) - for the original inspiration to create the A3W Airdrop

[@Brun](http://www.exilemod.com/topic/11296-xm8-app-brama-cookbook-updated/) - The Brama Cookbook provided me with spacing and such for the app layout

-Props to the others fellows whose code I perused to understand dialog functions better.
-If I've forgotten anyone specific, speak up!


#Install Instructions (ExAd Version)

1) Install ExAd, w/ XM8 Plugin (You currently need the Dev version, due to a ComboBox function)

2) Copy the client folder from the Airdrop Github to the Apps folder.

3) From the config.cpp in the Airdrop Github, you need to add the ExAd_APOC_Airdrop class to the CfgXM8 class within your mission config.cpp

4) You'll need to PBO the exad_apoc_airdrop folder from within the @ExileServer\addons  and drop it into your server's ExileServer\addons folder.

5) PROFIT

#Config Notes

You can set the respect threshold for each drop.  That is the last numeric field in the included file.  If you leave that field out, the script will treat it as if there is no respect threshold.  Or so it should. :)

You can copy your old configs over to the new system.  You just have to make sure you leave the header and such in the new file.  As well as line 11, #include "functions.sqf"

#Notes:

So, the dialog is still kinda buggy.  I probably need to add some cleanup lines to empty out the dialog so they reload properly.

##Side Note:

Also, my config is crap, if you hadn't caught on to that.  I just threw stuff in there to get some some data in.  If someone comes up with a balanced config for a vanilla exile (no weapon/vehicle addons) crate arrangement, I'll gladly drop that in the repo and credit the kind soul who submits.

#Advanced Banking:

So WolfkillArcadia was awesome enough to make the edits for compatibility with AdvancedBanking.  So just check the config file for where that gets set.

I have no idea if Advanced banking still works in this version of Exile, or if it's configs are still the same.  So yeah, let me know if that part of airdrop is broken.
