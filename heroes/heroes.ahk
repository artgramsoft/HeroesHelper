
#SingleInstance ignore
#MaxHotkeysPerInterval 150
SetWorkingDir %A_ScriptDir%
SendMode, Event

;======================================================
; 초기화.
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
; 설정 파일.
;------------------------------------------------------
#include ./heroes_config.ahk

;------------------------------------------------------
; 화면 출력.
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
; 메인 루프 시작.
;------------------------------------------------------
SetTimer, OnUpdateHeroes, 250
Gosub, OnUpdateHeroes

;------------------------------------------------------
; 헬퍼 메뉴.
;------------------------------------------------------
#include ./heroes_menu.ahk

;------------------------------------------------------
; 메인 루프.
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
; 마영전 매크로.
;======================================================

;------------------------------------------------------
; 모드 단축키.
;------------------------------------------------------
#include ./heroes_mode.ahk

;------------------------------------------------------
; 마을 단축키.
;------------------------------------------------------
#include ./heroes_town.ahk

;------------------------------------------------------
; 전투 단축키.
;------------------------------------------------------
#include ./heroes_battle.ahk

;------------------------------------------------------
; 레디 단축키.
;------------------------------------------------------
#include ./heroes_ready.ahk

;------------------------------------------------------
; 피펫 단축키.
;------------------------------------------------------
#include ./heroes_pipet.ahk

;------------------------------------------------------
; 기능 단축키.
;------------------------------------------------------
#include ./heroes_function.ahk

;------------------------------------------------------
; 애완동물 단축키.
;------------------------------------------------------
#include ./heroes_summon.ahk

;------------------------------------------------------
; 실행 단축키.
;------------------------------------------------------
#include ./heroes_hotkey.ahk

;------------------------------------------------------
; 기타.
;------------------------------------------------------
