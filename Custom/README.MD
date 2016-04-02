# Apoc's Airdrop Assistance XM8 App
This app allows you to call in chopper-carried airdrops of supplies or vehicles.  You can configure as many aidrops as you'd like, with as many categories as you'd like.

This is an Exile port of the original Airdrop Assistance script that I put together for A3Wasteland.  Blame my laziness for the delay, I'm OK with that.

Creation of vehicles, AI, and supply boxes is handled server side.  Money handling is also completed by the server using Exile functions.

# Credits
[@Shix](http://www.exilemod.com/profile/4566-shix/) for the XM8 App script and framework for making custom apps

[@AgentRev](http://forums.a3wasteland.com/index.php?action=profile;u=53) for use of some of the A3Wasteland Functions

[@CreamPie](http://forums.a3wasteland.com/index.php?action=profile;u=260)

# Dependencies
[XM8 Apps Script by Shix](http://www.exilemod.com/topic/9040-xm8-apps/)

# Installation
This is where it gets more complicated than other XM8 Apps...

1) You'll need to add the server function to your CfgRemoteExec whitelisting
	-See the CfgRemoteExec.hpp if you're using Infistar

2) Add the line within the init.sqf to your init.sqf for your server
	-This will load the config to server/client, as well as give the server the function definitions
	
3) Copy the Custom and xm8Apps folders to your mission file

# Configuration
Within the Custom/APOC_Airdrop_Assistance/config.sqf file you will find the listings for the menus, as well as the contents of the boxes.
