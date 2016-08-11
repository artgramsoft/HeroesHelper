
iniFile := "heroes.ini"

;[CONFIG]
IniRead, heroes_x, %iniFile%, CONFIG, PosX, 0
IniRead, heroes_y, %iniFile%, CONFIG, PosY, 0
IniRead, double_click_speed, %iniFile%, CONFIG, DoubleClickSpeed, 300

double_click_speed := double_click_speed + 0 ;string to int

;[MODE]
IniRead, town_mode_key, %iniFile%, MODE, TownModeKey, ^F1
IniRead, battle_mode_key, %iniFile%, MODE, BattleModeKey, ^F2
IniRead, ready_mode_key, %iniFile%, MODE, ReadyModeKey, ^F3
IniRead, pipet_mode_key, %iniFile%, MODE, PipetModeKey, ^F4

IniRead, use_town_mode, %iniFile%, MODE, UseTownMode, on
IniRead, use_battle_mode, %iniFile%, MODE, UseBattleMode, on
IniRead, use_ready_mode, %iniFile%, MODE, UseReadyMode, on
IniRead, use_pipet_mode, %iniFile%, MODE, UsePipetMode, on

use_town_mode := StrLower(use_town_mode)
use_battle_mode := StrLower(use_battle_mode)
use_ready_mode := StrLower(use_ready_mode)
use_pipet_mode := StrLower(use_pipet_mode)

;[COMMON]
IniRead, transform_notify, %iniFile%, COMMON, TransformNotify, 5
IniRead, transform_alpha, %iniFile%, COMMON, TransformAlpha, 100
IniRead, auto_save_screenshot, %iniFile%, COMMON, AutoSaveScreenShot, on
IniRead, screenshot_manager_key, %iniFile%, COMMON, ScreenShotManagerKey, ^F5
IniRead, ready_message, %iniFile%, COMMON, ReadyMessage, ""

auto_save_screenshot := StrLower(auto_save_screenshot)
saved_screenshot := false
transform_clicked_hour := ""

;[HOTKEY]
IniRead, hotkey_key_1, %iniFile%, HOTKEY, Key1, ^F6
IniRead, hotkey_key_2, %iniFile%, HOTKEY, Key2, ^F7
IniRead, hotkey_key_3, %iniFile%, HOTKEY, Key3, ^F8
IniRead, hotkey_key_4, %iniFile%, HOTKEY, Key4, ^F9
IniRead, hotkey_key_5, %iniFile%, HOTKEY, Key5, ^F10

IniRead, hotkey_run_1, %iniFile%, HOTKEY, Run1, notepad
IniRead, hotkey_run_2, %iniFile%, HOTKEY, Run2, notepad
IniRead, hotkey_run_3, %iniFile%, HOTKEY, Run3, notepad
IniRead, hotkey_run_4, %iniFile%, HOTKEY, Run4, notepad
IniRead, hotkey_run_5, %iniFile%, HOTKEY, Run5, notepad

;[BATTLE]
IniRead, auto_battle_mode, %iniFile%, BATTLE, AutoBattleMode, on
IniRead, use_yuna_step, %iniFile%, BATTLE, UseYunaStep, on
IniRead, battle_wheel_up, %iniFile%, BATTLE, WheelUp, ""
IniRead, battle_wheel_down, %iniFile%, BATTLE, WheelDown, ""
IniRead, battle_wheel_click, %iniFile%, BATTLE, WheelClick, ""
IniRead, battle_xbutton1, %iniFile%, BATTLE, XButton1, ""
IniRead, battle_xbutton2, %iniFile%, BATTLE, XButton2, ""
IniRead, battle_shift_wheel_up, %iniFile%, BATTLE, +WheelUp, ""
IniRead, battle_shift_wheel_down, %iniFile%, BATTLE, +WheelDown, ""
IniRead, battle_shift_wheel_click, %iniFile%, BATTLE, +WheelClick, ""
IniRead, battle_shift_xbutton1, %iniFile%, BATTLE, +XButton1, ""
IniRead, battle_shift_xbutton2, %iniFile%, BATTLE, +XButton2, ""

;StringLower, auto_battle_mode, auto_battle_mode
auto_battle_mode := StrLower(auto_battle_mode)
use_yuna_step := StrLower(use_yuna_step)

;[READY]
IniRead, ready_update_interval, %iniFile%, READY, UpdateInterval, 2000
IniRead, auto_f12_button, %iniFile%, READY, AutoF12Button, on
IniRead, auto_esc_button, %iniFile%, READY, AutoESCButton, on
IniRead, auto_exit_to_town, %iniFile%, READY, AutoExitToTown, on
IniRead, use_key_remapping, %iniFile%, READY, UseKeyRemapping, off

ready_update_interval := ready_update_interval + 0 ;string to int
auto_f12_button := StrLower(auto_f12_button)
auto_esc_button := StrLower(auto_esc_button)
auto_exit_to_town := StrLower(auto_exit_to_town)
use_key_remapping := StrLower(use_key_remapping)

;[PIPET]
IniRead, pipet_update_interval, %iniFile%, PIPET, UpdateInterval, 100
pipet_update_interval := pipet_update_interval + 0 ;string to int

;[SUMMON]
IniRead, summon_key_1, %iniFile%, SUMMON, Key1, !F1
IniRead, summon_key_2, %iniFile%, SUMMON, Key2, !F2
IniRead, summon_key_3, %iniFile%, SUMMON, Key3, !F3
IniRead, summon_key_4, %iniFile%, SUMMON, Key4, !F4
IniRead, summon_key_5, %iniFile%, SUMMON, Key5, !F5
IniRead, summon_key_6, %iniFile%, SUMMON, Key6, !F6
IniRead, summon_key_7, %iniFile%, SUMMON, Key7, !F7
IniRead, summon_key_8, %iniFile%, SUMMON, Key8, !F8
IniRead, summon_key_Release, %iniFile%, SUMMON, KeyRelease, !Esc

IniRead, summon_1, %iniFile%, SUMMON, Name1, NoName
IniRead, summon_2, %iniFile%, SUMMON, Name2, NoName
IniRead, summon_3, %iniFile%, SUMMON, Name3, NoName
IniRead, summon_4, %iniFile%, SUMMON, Name4, NoName
IniRead, summon_5, %iniFile%, SUMMON, Name5, NoName
IniRead, summon_6, %iniFile%, SUMMON, Name6, NoName
IniRead, summon_7, %iniFile%, SUMMON, Name7, NoName
IniRead, summon_8, %iniFile%, SUMMON, Name8, NoName
IniRead, summon_9, %iniFile%, SUMMON, Name9, NoName

/*
msgbox, % "CONFIG::PosX : " . heroes_x
msgbox, % "CONFIG::PosY : " . heroes_y

msgbox, % "FUNC_F12::AuttoBattleMode : " . auto_battle_mode
msgbox, % "FUNC_F12::ReadyMessage : " . ready_message

msgbox, % "NOTIFY::TransformNotify : " . transform_notify
msgbox, % "NOTIFY::TransformAlpha : " . transform_alpha

msgbox, % "BATTLE::WheelUp : " . battle_wheel_up
msgbox, % "BATTLE::WheelDown : " . battle_wheel_down
msgbox, % "BATTLE::WheelClick : " . battle_wheel_click
msgbox, % "BATTLE::XButton1 : " . battle_xbutton1
msgbox, % "BATTLE::XButton2 : " . battle_xbutton2
msgbox, % "BATTLE::+WheelUp : " . battle_shift_wheel_up
msgbox, % "BATTLE::+WheelDown : " . battle_shift_wheel_down
msgbox, % "BATTLE::+WheelClick : " . battle_shift_wheel_click
msgbox, % "BATTLE::+XButton1 : " . battle_shift_xbutton1
msgbox, % "BATTLE::+XButton2 : " . battle_shift_xbutton2
*/