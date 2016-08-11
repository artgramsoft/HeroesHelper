;------------------------------------------------------
; 단축키 설정.
;------------------------------------------------------
Hotkey, IfWinActive, ahk_class Valve001
if town_mode_key != ""
Hotkey, %town_mode_key%, ModeTownActive
if battle_mode_key != ""
Hotkey, %battle_mode_key%, ModeBattleActive
if ready_mode_key != ""
Hotkey, %ready_mode_key%, ModeReadyToggle
if pipet_mode_key != ""
Hotkey, %pipet_mode_key%, ModePipetToggle
if screenshot_manager_key != ""
Hotkey, %screenshot_manager_key%, OpenScreenShotManager

if hotkey_key_1 != ""
Hotkey, %hotkey_key_1%, HotkeyRun1
if hotkey_key_2 != ""
Hotkey, %hotkey_key_2%, HotkeyRun2
if hotkey_key_3 != ""
Hotkey, %hotkey_key_3%, HotkeyRun3
if hotkey_key_4 != ""
Hotkey, %hotkey_key_4%, HotkeyRun4
if hotkey_key_5 != ""
Hotkey, %hotkey_key_5%, HotkeyRun5

if summon_key_1 != ""
Hotkey, %summon_key_1%, SummonPet1
if summon_key_2 != ""
Hotkey, %summon_key_2%, SummonPet2
if summon_key_3 != ""
Hotkey, %summon_key_3%, SummonPet3
if summon_key_4 != ""
Hotkey, %summon_key_4%, SummonPet4
if summon_key_5 != ""
Hotkey, %summon_key_5%, SummonPet5
if summon_key_6 != ""
Hotkey, %summon_key_6%, SummonPet6
if summon_key_7 != ""
Hotkey, %summon_key_7%, SummonPet7
if summon_key_8 != ""
Hotkey, %summon_key_8%, SummonPet8
if summon_key_Release != ""
Hotkey, %summon_key_Release%, SummonRelease

if ErrorLevel
    MsgBox, Hotkey Error : %ErrorLevel%
Hotkey, IfWinActive

;------------------------------------------------------
; 트레이 메뉴.
;------------------------------------------------------
Menu, Tray, NoStandard,
Menu, Tray, Add,About,About
Menu, Tray, Add,Config,Config
Menu, Tray, Add,ScreenShot,ScreenShot
Menu, Tray, Add,Reset,Reset
Menu, Tray, Add,Quit,Quit
return

About:
	MsgBox, %title% %version% `n- http://heroes.uzoo.in`n- made by whitesnake
return

Config:
	Run, heroes.ini
return

ScreenShot:
	Run, screenshot_manager.exe
return

Reset:
	reload
return

Quit:
	ExitApp
return

;------------------------------------------------------
; 시스템 메뉴.
;------------------------------------------------------
#IfWinActive ahk_class Valve001

^Esc::
	ExitApp
return

+Esc::
	reload
return

^!p::
	Suspend
Return

^h::
	;mode_show := mod(mode_show + 1, 3)
	show_help := !show_help
	
	if (show_help)
	{
		help_osd.Show()
	}
	else
	{
		help_osd.Hide()
	}
return

#IfWinActive

;------------------------------------------------------
; 기타 메뉴.
;------------------------------------------------------
ButtonTransform:
	transform_osd.Hide()
	FormatTime, transform_clicked_hour, , H
return
