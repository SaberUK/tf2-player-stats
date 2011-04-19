// =============================================================================
// [TF2] Player Stats (C) 2011 Peter "SaberUK" Powell <petpow@saberuk.com>
// =============================================================================
//
// This program is free software; you can redistribute it and/or modify it under
// the terms of the GNU General Public License, version 3.0, as published by the
// Free Software Foundation.
// 
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
// details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.
//
// =============================================================================
#include <csteamid>
#include <sourcemod>
#pragma semicolon 1

public Plugin:myinfo = 
{
	name        = "[TF2] Player Stats",
	description = "Allows players to view stats via TF2Stats.",
	author      = "Peter \"SaberUK\" Powell",
	url         = "http://www.saberuk.com/",
	version     = "1.0"
}

public OnPluginStart()
{
	LoadTranslations("common.phrases");
	RegConsoleCmd("sm_mystats", Command_SmMyStats);
	RegConsoleCmd("sm_stats", Command_SmStats);
}

public Action:Command_SmMyStats(client, args)
{
	ShowStats(client, client);
	return Plugin_Handled;
}

public Action:Command_SmStats(client, args)
{
	if (client > 0 && IsClientInGame(client))
	{
		new target = 0;
		if (args > 0)
		{
			decl String:arg1[128];
			GetCmdArgString(arg1, sizeof(arg1));
			target = FindTarget(client, arg1, true, false);
			if (target > 0)
			{
				ShowStats(client, target);
			}
		}
		else
		{
			ReplyToCommand(client, "[SM] Usage: sm_stats <#userid|name>");
		}
	}
	return Plugin_Handled;
}

ShowStats(client, target)
{
	if (client > 0 && IsClientInGame(client) && target > 0 && IsClientInGame(target))
	{
		new String:auth[64], String:uri[128];
		GetClientCSteamID(target, auth, sizeof(auth));
		Format(uri, sizeof(uri), "http://tf2stats.net/player/%s", auth);
		ShowMOTDPanel(client, "TF2Stats", uri, MOTDPANEL_TYPE_URL);
	}
	
}