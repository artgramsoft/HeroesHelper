
;------------------------------------------------------
; 레디 모드.
;------------------------------------------------------

#if WinActive("ahk_class Valve001") and IsMode(MODE_READY)

OnAutoReady:
	if (!heroes_active)
	{
		return
	}
	
	if (!IsMode(MODE_READY))
	{
		SetTimer, OnAutoReady, off
		return
	}
	
	if (FindImageOnly("heroes\btn_ready.PNG"))
	{
		return
	}
	
	if (IsOn(auto_f12_button))
	{
		Send, {F12}
	}
	
	if (IsOn(auto_esc_button))
	{
		Send, {Esc}
	}
	
	if (auto_exit_to_town = "on")
	{
		if (FindImage("heroes\battle_success.PNG", ix, iy, 10))
		{
			SetTimer, OnAutoReady, off
			
			btn_offset_x := 10
			btn_offset_y := 10
			
			mx := ix + btn_offset_x
			my := iy + btn_offset_y

			MouseClick, left, %mx%, %my%, 1, 0, D
			
			while(!FindCloseButton(ix, iy))
			{
				Sleep, 500
			}
			
			MouseClick, left, , , , 0, U
			
			Send, {LAlt down}
			ClickWithOffset(ix, iy, btn_offset_x, btn_offset_y)
			Send, {LAlt up}
			
			while(!CheckExitToTownButton())
			{
				Sleep, 500
			}
			
			ChangeMode(MODE_TOWN)
		}
	}
return

#if

#if WinActive("ahk_class Valve001") and IsMode(MODE_READY) and IsOn(use_key_remapping)

WheelDown::
	Send, {e}
return

+WheelDown::
	Send, {e}
return

WheelUp::
	Send, {w Down}
	Send, {Space}
	Send, {w Up}
return

+WheelUp::
	Send, {Space}
return

;달리기
+RButton::
return

RButton::
	if ((A_PriorHotkey <> "RButton") || (A_TimeSincePriorHotkey > double_click_speed))
	{
		KeyWait, RButton, Up
		
		return
	}

	AutoRunWithShift("RButton")	
return

#if
