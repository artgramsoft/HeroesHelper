
#SingleInstance ignore
#MaxHotkeysPerInterval 150
SetWorkingDir %A_ScriptDir%
SendMode, Event

;======================================================
; �ʱ�ȭ.
;======================================================

title := "HEROES HELPER"
version := "v1.4a"

SplashImage, "",B M, %version%, %title%
Sleep, 500
SplashImage, Off

MODE_NONE := 0
MODE_TOWN := 1
MODE_BATTLE := 2
MODE_READY := 3
MODE_PIPET := 4

PREV_MODE := MODE_NONE
CURR_MODE := MODE_TOWN

heroes_active := false
show_help := false

UpdateTransformTimer := 0
OnScreenShotTimer := 0

WinGetPos, window_x, window_y, window_width, window_height, ahk_class Valve001

;------------------------------------------------------
; ���� ����.
;------------------------------------------------------
#include ./heroes_config.ahk

;------------------------------------------------------
; ȭ�� ���.
;------------------------------------------------------
#include ./heroes_osd.ahk

;------------------------------------------------------
; Include.
;------------------------------------------------------
#include ../common/common.ahk

#Include ../common/hotstring.ahk
dynamic_hotstring := new DynamicHotstring("heroes.ini", "CHAT")
dynamic_hotstring.StartDynamicHotstring()

;------------------------------------------------------
; ���� ���� ����.
;------------------------------------------------------
SetTimer, OnUpdateHeroes, 250
Gosub, OnUpdateHeroes

;------------------------------------------------------
; ���� �޴�.
;------------------------------------------------------
#include ./heroes_menu.ahk

;------------------------------------------------------
; ���� ����.
;------------------------------------------------------
OnUpdateHeroes:
	if WinActive("ahk_class Valve001")
	{
		if !heroes_active
			OnEnableHeroes()
		
		UpdateOSD()
		
		if ((A_TickCount - UpdateTransformTimer) > 1000)
		{
			UpdateTransformOSD()
			UpdateTransformTimer := A_TickCount
		}		
		
		if ((A_TickCount - OnScreenShotTimer) > 5000)
		{
			OnScreenShot()
			OnScreenShotTimer := A_TickCount
		}		
		
		heroes_active := true
	}
	else
	{
		if !heroes_active
			OnDisableHeroes()
		
		heroes_active := false
	}
	
	OnRenderHeroes(heroes_active)
return

OnEnableHeroes()
{
}

OnDisableHeroes()
{
}

OnRenderHeroes(on)
{
	global
	
	dynamic_hotstring.SetUse(on)
	
	if (on)
	{
		if (!osd.on)
		{
			osd.Show()
		}
		
		if (!help_osd.on && show_help)
		{
			help_osd.Show()
		}
	}
	else
	{
		if (osd.on)
		{
			osd.Hide()
		}
		
		if (help_osd.on)
		{
			help_osd.Hide()
		}
		
		if (transform_notify > 0)
		{
			if (transform_osd.on)
			{
				transform_osd.Hide()
			}
		}
	}
}

;======================================================
; ������ ��ũ��.
;======================================================

;------------------------------------------------------
; ��� ����Ű.
;------------------------------------------------------
#include ./heroes_mode.ahk

;------------------------------------------------------
; ���� ����Ű.
;------------------------------------------------------
#include ./heroes_town.ahk

;------------------------------------------------------
; ���� ����Ű.
;------------------------------------------------------
#include ./heroes_battle.ahk

;------------------------------------------------------
; ���� ����Ű.
;------------------------------------------------------
#include ./heroes_ready.ahk

;------------------------------------------------------
; ���� ����Ű.
;------------------------------------------------------
#include ./heroes_pipet.ahk

;------------------------------------------------------
; ��� ����Ű.
;------------------------------------------------------
#include ./heroes_function.ahk

;------------------------------------------------------
; �ֿϵ��� ����Ű.
;------------------------------------------------------
#include ./heroes_summon.ahk

;------------------------------------------------------
; ���� ����Ű.
;------------------------------------------------------
#include ./heroes_hotkey.ahk

;------------------------------------------------------
; ��Ÿ.
;------------------------------------------------------
