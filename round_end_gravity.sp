#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = 
{
	name = "Round End Gravity", 
	author = "babka68", 
	description = "Данный плагин позволяет выдать гравитацию игрокам в конце раунда", 
	version = "1.0", 
	url = "https://vk.com/zakazserver68"
};

bool b_Enable_Gravity;
int g_iValue;
Handle g_hgravity;

public void OnPluginStart()
{
	ConVar cvar;
	
	cvar = CreateConVar("sm_enable_gravity", "1", "1 - Включить, 0 - Выключить плагин", _, true, 0.0, true, 1.0);
	cvar.AddChangeHook(CVarChanged_Enable_Gravity);
	b_Enable_Gravity = cvar.BoolValue;
	
	cvar = CreateConVar("sm_value_gravity", "210", "Значение (Число с плавающей запятой) скорости (по умолчанию 1.0)", _, true, 100.0, true, 800.0);
	cvar.AddChangeHook(CVarChangedRoundEndGravity);
	g_iValue = cvar.IntValue;
	
	HookEvent("round_start", RoundOnStart, EventHookMode_Pre);
	HookEvent("round_end", RoundEndEnd, EventHookMode_Pre);
	g_hgravity = FindConVar("sv_gravity");
	AutoExecConfig(true, "sm_round_end_gravity");
}

public void CVarChanged_Enable_Gravity(ConVar CVar, const char[] oldValue, const char[] newValue)
{
	b_Enable_Gravity = CVar.BoolValue;
}

public void CVarChangedRoundEndGravity(ConVar CVar, const char[] oldValue, const char[] newValue)
{
	g_iValue = CVar.IntValue;
}

public void RoundOnStart(Handle event, char[] name, bool dontBroadcast)
{
	SetConVarInt(g_hgravity, 800); // по умолчанию 800
}

public void RoundEndEnd(Handle event, char[] name, bool dontBroadcast)
{
	if (b_Enable_Gravity)
	{
		SetConVarInt(g_hgravity, g_iValue); // g_iValue = значению в sm_value_gravity "Значение"
	}
}
