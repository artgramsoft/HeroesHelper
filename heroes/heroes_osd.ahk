;------------------------------------------------------
; 화면 출력.
;------------------------------------------------------
#include ../common/osd.ahk
#include ../common/second_mouse.ahk

turnOnColor := "00FF00"
turnOffColor := "FFFFFF"
;osd_update_count := 0

osd := new OnScreenDisplay(1, window_x + heroes_x, window_y + heroes_y)
osd.Begin()
osd.SetFont("Fixedsys", 12)
osd.AddText("", "[" . title . "]", "FFFF00", , "section", "x0 y0")
osd.AddText("OSD_MODE_TOWN", "TOWN", turnOffColor, , "col", "y0")
osd.AddText("OSD_MODE_BATTLE", "BATTLE", turnOffColor, , "col", "y0")
osd.AddText("OSD_MODE_READY", "READY", turnOffColor, , "col", "y0")
osd.AddText("OSD_MODE_PIPET", "PIPET", turnOffColor, , "col", "y0")
osd.AddText("HELP", "[HELP:CTRL+H] " . version . "", "FE9A2E", , "col", "y0")
osd.End()
;osd.Show()

second_mouse := new SecondMouse(77, 26, 26, "pipet.png")
second_mouse.Begin()
second_mouse.SetFont("Impact", 12)
;second_mouse.SetBold(true)
second_mouse.AddText("RED", "R:255", "FF0000", , "new", "x0 y30")
second_mouse.AddText("GREEN", "G:255", "00FF00", , "row", "x0 y48")
second_mouse.AddText("BLUE", "B:255", "0000FF", , "row", "x0 y66")
second_mouse.End()
;second_mouse.Show(window_x + 100, window_y + 100)

/*
splash_window := new SecondMouse(79, 300, 250, "splash.jpg")
splash_window.Begin()
splash_window.SetFont("Arial", 12)
;splash_window.SetBold(true)
splash_window.AddText("", title . " " . version, "000000", , "new", "x50 y100")
splash_window.End()
splash_window.Show( (A_ScreenWidth - 300) / 2, (A_ScreenHeight - 350) / 2)
Sleep, 5000
splash_window.Close()
*/

if (transform_notify > 0)
{
	transform_offset_x := 130
	transform_offset_y := 150
	
	transform_osd := new OnScreenDisplay(2, window_x + window_width/2 - transform_offset_x, window_y + window_height/2 - transform_offset_y, transform_alpha)
	transform_osd.Begin()
	transform_osd.SetFont("Fixedsys", 12)
	;transform_osd.AddText("TransformTime", "Transform Remained : 00 min", "04B404")
	Gui, 2:Add, Button, vTransformTime gButtonTransform, Transform Remained : 00 min
	transform_osd.End()
	;transform_osd.Show()
}

UpdateOSD()
{
	global
	
	if (IsMode(MODE_TOWN))
		osd.SetTextColor("OSD_MODE_TOWN", turnOnColor)
	else
		osd.SetTextColor("OSD_MODE_TOWN", turnOffColor)
	
	if (IsMode(MODE_BATTLE))
		osd.SetTextColor("OSD_MODE_BATTLE", turnOnColor)
	else
		osd.SetTextColor("OSD_MODE_BATTLE", turnOffColor)	
	
	if (IsMode(MODE_READY))
		osd.SetTextColor("OSD_MODE_READY", turnOnColor)
	else
		osd.SetTextColor("OSD_MODE_READY", turnOffColor)	
	
	if (IsMode(MODE_PIPET))
		osd.SetTextColor("OSD_MODE_PIPET", turnOnColor)
	else
		osd.SetTextColor("OSD_MODE_PIPET", turnOffColor)	
	
	WinGetPos, window_x, window_y, window_width, window_height, ahk_class Valve001
	
	osd.SetPosition(window_x + heroes_x, window_y + heroes_y)
	
	if (show_help)
		help_osd.SetPosition(window_x + heroes_x, window_y + heroes_y + 20)
	
	;osd_update_count++
	
	;if (osd_update_count = 2)
	;{
	;	UpdateTransformOSD()
	;	osd_update_count := 0
	;}	
}

UpdateTransformOSD()
{
	global
	
	if (transform_notify > 0)
	{
		local current_hour, current_minute, remain_minute
		
		FormatTime, current_hour, , H
		FormatTime, current_minute, , m
		
		if (transform_clicked_hour = current_hour)
		{
			return
		}
		else
		{
			transform_clicked_hour := ""
		}
		
		remain_minute := 60 - current_minute
		
		if (transform_notify >= remain_minute)
		{
			transform_osd.SetText("TransformTime", "Transform Remained : " . remain_minute . " min")
			transform_osd.SetPosition(window_x + window_width/2 - transform_offset_x, window_y + window_height/2 - transform_offset_y)
			
			if (!transform_osd.on)
			{
				transform_osd.Show()
			}
		}
		else
		{
			transform_osd.Hide()
		}
	}
}

help_string := help_string . "----------------------------------------------------"
help_string := help_string . "`n>> " . title . " " . version .  " by whitesnake"
help_string := help_string . "`n----------------------------------------------------"
help_string := help_string . "`nQuit Helper : Ctrl + Esc"
help_string := help_string . "`nReload INI file : Shift + Esc"
help_string := help_string . "`n"
help_string := help_string . "`nMODE-TOWN Active : Ctrl + F1" 
help_string := help_string . "`nMODE-BATTLE Active : Ctrl + F2"
help_string := help_string . "`nMODE-READY Toggle : Ctrl + F3"
help_string := help_string . "`nMODE_PIPET Toggle : Ctrl + F4"
help_string := help_string . "`nScreenShot Manager : Ctrl + F5"
help_string := help_string . "`n"
help_string := help_string . "`nCOMMON Function"
help_string := help_string . "`n- Hotstring By INI File"
help_string := help_string . "`n- QuickSlot Change : Alt + MButton Click"
help_string := help_string . "`n"
help_string := help_string . "`nMODE-TOWN Function"
help_string := help_string . "`n- Show Mouse : MButton Click"
help_string := help_string . "`n- Exit NPC's House : Hold MButton Click"
help_string := help_string . "`n- Skip NPC's Speech : Hold Double Click or Hold Space Double Tab"
help_string := help_string . "`n- Auto Run Start : RButton Double Click"
help_string := help_string . "`n- Auto Run Stop : RButton Click"
help_string := help_string . "`n- Manual Run : Hold RButton Double Click"
help_string := help_string . "`n- Buy Count Up To Max : \"
help_string := help_string . "`n- Buy All From Exchange : Shift + Enter"
help_string := help_string . "`n- Press System OK Button : Shift + LButton Click"
help_string := help_string . "`n- Press Enter To Party Button : Shift + RButton Click"
help_string := help_string . "`n"
help_string := help_string . "`nMODE-BATTLE Function"
help_string := help_string . "`n- QuickSlot 1 : Wheel Up"
help_string := help_string . "`n- QuickSlot 2 : Wheel Down"
help_string := help_string . "`n- QuickSlot 3 : Wheel Click"
help_string := help_string . "`n- QuickSlot 4 : XButton1 Click"
help_string := help_string . "`n- QuickSlot 5 : Shift + Wheel Up"
help_string := help_string . "`n- QuickSlot 6 : Shift + Wheel Down"
help_string := help_string . "`n- QuickSlot 7 : Shift + Wheel Click"
help_string := help_string . "`n- QuickSlot 8 : Shift + XButton1 Click"
help_string := help_string . "`n- QuickSlot 9 : XButton2 Click"
help_string := help_string . "`n- QuickSlot 0 : Shift + XButton2 Click"
help_string := help_string . "`n- Zoom In : Alt + Wheel Up"
help_string := help_string . "`n- Zoom Out : Alt + Wheel Down"
help_string := help_string . "`n- Yuna Step : Hold Shift Double Tab"
help_string := help_string . "`n- Auto && Manual Run with Ctrl Key"
help_string := help_string . "`n"
help_string := help_string . "`nMODE-READY Function"
help_string := help_string . "`n- Auto Press F12 Per 2 Second"
help_string := help_string . "`n- Wheel Up : E Button"
help_string := help_string . "`n- Wheel Down : Space Button"
help_string := help_string . "`n- Auto Exit When Battle Is End"
help_string := help_string . "`n- Auto && Manual Run as MODE-TOWN"
help_string := help_string . "`n"
help_string := help_string . "`nSummon Pet 1 ~ 8 : Alt + F1 ~ F8"
help_string := help_string . "`nSummon Cancel : Alt + Esc"
help_string := help_string . "`n"
help_string := help_string . "`nF12 Function"
help_string := help_string . "`n- Auto Greeting (ready on ship, auto MODE-BATTLE ON)"
help_string := help_string . "`n- Auto Start Battle (on ship, auto MODE-BATTLE ON)"
help_string := help_string . "`n- Auto Close Reward (on battle, auto MODE-BATTLE OFF)"
help_string := help_string . "`n- Auto Exit To Town (on battle, auto MODE-BATTLE OFF)"
help_string := help_string . "`n- Auto Retry Battle (Ctrl + F12 on battle, auto MODE-BATTLE OFF)"
help_string := help_string . "`n----------------------------------------------------"

help_osd := new OnScreenDisplay(90, window_x + heroes_x, window_y + heroes_y + 20)
help_osd.Begin()
help_osd.SetFont("Fixedsys", 12)
help_osd.AddText("HelpString", help_string, "FE9A2E", , , "x5")
help_osd.End()
;help_osd.Show()
