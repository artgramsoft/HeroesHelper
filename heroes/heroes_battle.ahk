;------------------------------------------------------
; 배틀 모드.
;------------------------------------------------------

#if WinActive("ahk_class Valve001") and IsMode(MODE_BATTLE)
;---------------------------------
WheelUp::
	if (battle_wheel_up = "")
		Send, {WheelUp}
	else
		Send, % battle_wheel_up
return
;---------------------------------
WheelDown::
	if (battle_wheel_down = "")
		Send, {WheelDown}
	else
		Send, % battle_wheel_down
return
;---------------------------------
MButton::
	if (battle_wheel_click = "")
		Send, {MButton Down}
	else
		Send, {%battle_wheel_click% Down}
return
MButton Up::
	if (battle_wheel_click = "")
		Send, {MButton Up}
	else
		Send, {%battle_wheel_click% Up}
return
;---------------------------------
XButton1::
	if (battle_xbutton1 = "")
		Send, {XButton1 Down}
	else
		Send, {%battle_xbutton1% Down}
return
XButton1 Up::
	if (battle_xbutton1 = "")
		Send, {XButton1 Up}
	else
		Send, {%battle_xbutton1% Up}
return
;---------------------------------
XButton2::
	if (battle_xbutton2 = "")
		Send, {XButton2 Down}
	else
		Send, {%battle_xbutton2% Down}
return
XButton2 Up::
	if (battle_xbutton2 = "")
		Send, {XButton2 Up}
	else
		Send, {%battle_xbutton2% Up}
return
;---------------------------------
+WheelUp::
	if (battle_shift_wheel_up = "")
		Send, +{WheelUp}
	else
		Send, % battle_shift_wheel_up
return
;---------------------------------
+WheelDown::
	if (battle_shift_wheel_down = "")
		Send, +{WheelDown}
	else
		Send, % battle_shift_wheel_down
return
;---------------------------------
+MButton::
	if (battle_shift_wheel_click = "")
		Send, +{MButton Down}
	else
		Send, {%battle_shift_wheel_click% Down}
return
+MButton Up::
	if (battle_shift_wheel_click = "")
		Send, +{MButton Up}
	else
		Send, {%battle_shift_wheel_click% Up}
return
;---------------------------------
+XButton1::
	if (battle_shift_xbutton1 = "")
		Send, +{XButton1 Down}
	else
		Send, {%battle_shift_xbutton1% Down}
return
+XButton1 Up::
	if (battle_shift_xbutton1 = "")
		Send, +{XButton1 Up}
	else
		Send, {%battle_shift_xbutton1% Up}
return
;---------------------------------
+XButton2::
	if (battle_shift_xbutton2 = "")
		Send, +{XButton2 Down}
	else
		Send, {%battle_shift_xbutton2% Down}
return
+XButton2 Up::
	if (battle_shift_xbutton2 = "")
		Send, +{XButton2 Up}
	else
		Send, {%battle_shift_xbutton2% Up}
return
;---------------------------------
;달리기
^RButton::
	if (A_PriorHotkey <> "^RButton" or A_TimeSincePriorHotkey > double_click_speed)
	{
		KeyWait, RButton
		return
	}

	AutoRunWithShift("RButton")
return
;---------------------------------
#if

#if WinActive("ahk_class Valve001") and IsMode(MODE_BATTLE) and IsOn(use_yuna_step)
;---------------------------------
;연아 스텝
~LShift::
	if (A_PriorHotkey <> "~LShift" or A_TimeSincePriorHotkey > double_click_speed)
	{
		KeyWait, LShift
		return
	}
	
	SetKeyDelay, 0, 0
	
	While GetKeyState("LShift","P")
	{
		Send, {w down}
		Sleep, 80
		Send, {w up}
		Sleep, 70
	}
return
;---------------------------------
#if