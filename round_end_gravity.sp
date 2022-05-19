#pragma semicolon 1
#pragma newdecls required

// Раскомментируйте для отладки
// #define DEBUG 1

public Plugin myinfo = 
{
	name = "Round End Gravity", 
	author = "babka68", 
	description = "Данный плагин позволяет выдать гравитацию игрокам в конце раунда", 
	version = "1.0", 
	url = "https://vk.com/zakazserver68"
};

// ConVar
bool g_bEnable_Gravity;
int g_iGravity_Value;

// FindConVar
ConVar g_hSv_Gravity;

public void OnPluginStart()
{
	#if defined DEBUG
	LogError("[DEBUG] Плагин запущен.");
	#endif
	
	g_hSv_Gravity = FindConVar("sv_gravity");
	
	HookEvent("round_start", Round_On_Start, EventHookMode_Pre);
	HookEvent("round_end", Round_End, EventHookMode_Pre);
	
	ConVar cvar;
	cvar = CreateConVar("sm_enable_gravity", "1", "1 - Включить, 0 - Выключить плагин", _, true, 0.0, true, 1.0);
	cvar.AddChangeHook(CVarChanged_Enable_Gravity);
	g_bEnable_Gravity = cvar.BoolValue;
	
	cvar = CreateConVar("sm_value_gravity", "210", "Значение гравитации (По умолчанию 800)", _, true, 100.0, true, 800.0);
	cvar.AddChangeHook(CVarChangedRoundEndGravity);
	g_iGravity_Value = cvar.IntValue;
	
	AutoExecConfig(true, "sm_round_end_gravity");
}

public void CVarChanged_Enable_Gravity(ConVar cvar, const char[] oldValue, const char[] newValue)
{
	#if defined DEBUG
	LogError("[DEBUG] CVarChanged_Enable_Gravity");
	#endif
	
	g_bEnable_Gravity = cvar.BoolValue;
	
	#if defined DEBUG
	LogError("[DEBUG] g_bEnable_Gravity = %i", g_bEnable_Gravity);
	#endif
}

public void CVarChangedRoundEndGravity(ConVar cvar, const char[] oldValue, const char[] newValue)
{
	#if defined DEBUG
	LogError("[DEBUG] CVarChangedRoundEndGravity");
	#endif
	
	g_iGravity_Value = cvar.IntValue;
	
	#if defined DEBUG
	LogError("[DEBUG] g_iGravity_Value = %i", g_iGravity_Value);
	#endif
}

public void Round_On_Start(Event event, char[] name, bool dontBroadcast)
{
	#if defined DEBUG
	LogError("[DEBUG] Round_On_Start");
	#endif
	
	g_hSv_Gravity.SetInt(800); // по умолчанию 800
}

public void Round_End(Event event, char[] name, bool dontBroadcast)
{
	#if defined DEBUG
	LogError("[DEBUG] Round_End");
	#endif
	
	if (g_bEnable_Gravity)
	{
		#if defined DEBUG
		LogError("[DEBUG] g_bEnable_Gravity = %i", g_bEnable_Gravity);
		#endif
		
		g_hSv_Gravity.SetInt(g_iGravity_Value);
		
		#if defined DEBUG
		LogError("[DEBUG] g_iGravity_Value = %i", g_iGravity_Value);
		#endif
	}
}
