#include <sourcemod>

#pragma semicolon 1
#pragma newdecls required

bool RGB[65] = { false, ... };

int r1 = 255, g1 = 0, b1 = 0;

public Plugin myinfo = 
{
	name = "Player RGB", 
	author = "ByDexter", 
	description = "Player RGB", 
	version = "1.0", 
	url = "https://steamcommunity.com/id/ByDexterTR - ByDexter#5494"
};

public void OnPluginStart()
{
	LoadTranslations("common.phrases");
	LoadTranslations("playerrgb.phrases");
	RegAdminCmd("sm_rgb", Command_RGB, ADMFLAG_ROOT, "sm_rgb");
}

public void OnGameFrame()
{
	if (r1 > 0 && b1 == 0)
	{
		r1--;
		g1++;
	}
	if (g1 > 0 && r1 == 0)
	{
		g1--;
		b1++;
	}
	if (b1 > 0 && g1 == 0)
	{
		b1--;
		r1++;
	}
	for (int i = 1; i <= MaxClients; i++)if (IsClientInGame(i) && IsPlayerAlive(i) && !IsFakeClient(i) && RGB[i])
	{
		SetEntityRenderColor(i, r1, b1, g1, 255);
	}
}

public void OnClientPostAdminCheck(int client)
{
	RGB[client] = false;
}

public Action Command_RGB(int client, int args)
{
	RGB[client] = !RGB[client];
	PrintToChatAll("[SM] %t", "Toggled RGB", client);
	if (!RGB[client])
		SetEntityRenderColor(client, 255, 255, 255, 255);
	
	return Plugin_Handled;
} 