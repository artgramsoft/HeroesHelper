
;------------------------------------------------------
; 모드 단축키.
;------------------------------------------------------
ModeTownActive:
	ChangeMode(MODE_TOWN)
return

ModeBattleActive:
	ChangeMode(MODE_BATTLE)
return

ModeReadyToggle:
	if (IsMode(MODE_READY))
	{
		ChangeMode(MODE_TOWN)
		return
	}
	
	ChangeMode(MODE_READY)
	SetTimer, OnAutoReady, %ready_update_interval%
	Send, {F12}
	Gosub, OnAutoReady
return

ModePipetToggle:
	if (IsMode(MODE_PIPET))
	{
		ChangeMode(MODE_TOWN)
		return
	}
	
	ChangeMode(MODE_PIPET)
	MouseGetPos, mx1, my1
	second_mouse.Show(window_x + mx1, window_y + my1)
	SetTimer, OnPickingColor, %pipet_update_interval%
	Gosub, OnPickingColor
return

OpenScreenShotManager:
	Run, screenshot_manager.exe
return

;------------------------------------------------------
; 모드 함수.
;------------------------------------------------------
IsOn(OnOffValue)
{
	if (OnOffValue == "on")
	{
		return true
	}
	
	return false
}

IsMode(mode)
{
	global
	
	if (mode = MODE_TOWN)
	{
		if (use_town_mode != "on")
		{
			return false
		}
	}
	else if (mode = MODE_BATTLE)
	{
		if (use_battle_mode != "on")
		{
			return false
		}
	}
	else if (mode = MODE_READY)
	{
		if (use_ready_mode != "on")
		{
			return false
		}
	}
	else if (mode = MODE_PIPET)
	{
		if (use_pipet_mode != "on")
		{
			return false
		}
	}
	
	if (CURR_MODE = mode)
		return true
	else
		return false
}

ChangeMode(mode)
{
	global
	
	PREV_MODE := CURR_MODE
	CURR_MODE := mode
}

ChangePreviousMode()
{
	global
	
	if (!IsMode(MODE_NONE))
	{
		ChangeMode(PREV_MODE)
	}
}
