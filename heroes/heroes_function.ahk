;------------------------------------------------------
; 기능 단축키.
;------------------------------------------------------
#IfWinActive ahk_class Valve001

;라키오라 버그 우회.
f10::
	Send, !{F10}
return

;레디.
^f12::
	if (CheckRetryBattleButton())
		return
return

;레디 후 자동 인삿말.
f12::
	Send, {F12}
	
	if (CheckReadyButton(ready_message))
		return
	if (CheckShippingButton())
		return
	if (CheckCloseButton())
		return
	if (CheckExitToTownButton())
		return
return

#IfWinActive

;------------------------------------------------------
; 기능 함수.
;------------------------------------------------------
AutoRun(stopKey)
{
	SetKeyDelay, 50, 50
	Send, {w}{w down}
	KeyWait, %stopKey%, U
	if (A_TimeSincePriorHotkey < 500)
	{
		KeyWait, %stopKey%, D
	}
	Send, {w up}
}

AutoRunWithShift(stopKey)
{
	SetKeyDelay, 50, 50
	Send, {Shift down}
	Send, {w down}
	KeyWait, %stopKey%, U
	if (A_TimeSincePriorHotkey < 500)
	{
		KeyWait, %stopKey%, D
	}
	Send, {w up}
	Send, {Shift up}
}

CheckReadyButton(msg)
{
	global auto_battle_mode, MODE_BATTLE
	
	btn_offset_x := 10
	btn_offset_y := 10
	
	if (msg <> "" && FindImageOnly("heroes\btn_ready.PNG"))
	{
		if (auto_battle_mode = "on")
		{
			ChangeMode(MODE_BATTLE)
		}
		
		ChatMessage(msg)
		return true
	}
	
	return false
}

CheckShippingButton()
{
	global auto_battle_mode, MODE_BATTLE
	
	btn_offset_x := 10
	btn_offset_y := 10
	btn_shipping_path := "heroes\btn_shipping.PNG"
	
	if (FindImageOnly(btn_shipping_path))
	{
		if (auto_battle_mode = "on")
		{
			ChangeMode(MODE_BATTLE)
		}
		
		Send, {LAlt down}
		ClickToImage(btn_shipping_path, btn_offset_x, btn_offset_y)
		Send, {LAlt up}
		return true
	}
	
	return false
}

FindCloseButton(ByRef ix, ByRef iy)
{
	btn_close_path := "heroes\btn_close.PNG"
	btn_close_battle_path := "heroes\btn_close_battle.PNG"
	
	if (FindImage(btn_close_path, ix, iy))
	{
		return true
	}
	else if (FindImage(btn_close_battle_path, ix, iy))
	{
		return true
	}
	else
	{
		return false
	}
}

CheckCloseButton()
{
	global auto_battle_mode, MODE_TOWN
	
	if (FindCloseButton(ix, iy))
	{
		if (auto_battle_mode = "on")
		{
			ChangeMode(MODE_TOWN)
		}
		
		btn_offset_x := 10
		btn_offset_y := 10
		
		Send, {LAlt down}
		ClickWithOffset(ix, iy, btn_offset_x, btn_offset_y)
		Send, {LAlt up}
		
		return true
	}
	
	return false
}

CheckExitToTownButton()
{
	global auto_battle_mode, MODE_TOWN
	
	btn_offset_x := 10
	btn_offset_y := 10
	btn_town_path := "heroes\btn_town.PNG"
	
	if (FindImageOnly(btn_town_path))
	{
		if (auto_battle_mode = "on")
		{
			ChangeMode(MODE_TOWN)
		}
		
		Send, {LAlt down}
		ClickToImage(btn_town_path, btn_offset_x, btn_offset_y)
		Send, {LAlt up}
		return true
	}
	
	return false
}

CheckRetryBattleButton()
{
	global auto_battle_mode, MODE_TOWN
	
	btn_offset_x := 10
	btn_offset_y := 10
	btn_retry_path := "heroes\btn_retry.PNG"
	
	if (FindImageOnly(btn_retry_path))
	{
		if (auto_battle_mode = "on")
		{
			ChangeMode(MODE_TOWN)
		}
		
		Send, {LAlt down}
		ClickToImage(btn_retry_path, btn_offset_x, btn_offset_y)
		Send, {LAlt up}
		return true
	}
	
	return false
}

CheckEnterShipButton()
{
	btn_enter_path := "heroes\btn_enter.PNG"
	
	if (FindImage(btn_enter_path, ix, iy, 20))
	{
		btn_offset_x := 10
		btn_offset_y := 10
		
		Send, {LAlt down}
		ClickWithOffset(ix, iy, btn_offset_x, btn_offset_y)
		Send, {LAlt up}
		
		return true
	}
	
	return false
}

CheckSystemOKButton()
{
	notify_path := "heroes\notify.PNG"
	
	if (FindImage(notify_path, ix, iy, 20))
	{
		;confirm
		btn_offset_x := 130
		btn_offset_y := 150
		ClickWithOffset(ix, iy, btn_offset_x, btn_offset_y)
		
		return true
	}
	
	return false
}

IsMouseInWindow()
{
	global
	
	MouseGetPos, mouse_x, mouse_y
	
	if (mouse_x < 0 || mouse_x > window_width)
		return false
		
	if (mouse_y < 0 || mouse_y > window_height)
		return false
	
	return true
}

OnScreenShot()
{
	global auto_save_screenshot, saved_screenshot
	
	if (auto_save_screenshot = "on")
	{
		local heroes_screenshot_path := A_MyDocuments . "\마비노기 영웅전\스크린샷\"
		local heroes_screenshot_file_prefix := "_mheroes_ss_"
		local helper_screenshot := "helper"
		
		if (InStr(FileExist(heroes_screenshot_path), "D"))
		{
			if (InStr(FileExist(heroes_screenshot_path . helper_screenshot), "D") = 0)
			{
				DirCreate(heroes_screenshot_path . helper_screenshot)
			}
			
			if FileExist(heroes_screenshot_path . heroes_screenshot_file_prefix . "0")
			{
				if (!saved_screenshot)
				{
					FormatTime, TimeString, , yyyyMMdd_HHmm
				
					local save_path := heroes_screenshot_path . helper_screenshot
					local save_name := TimeString . "_0.jpg"
					
					local original_name_prefix := heroes_screenshot_path . heroes_screenshot_file_prefix
					
					FileCopy, %original_name_prefix%0, %save_path%\%save_name%
					FileDelete, %original_name_prefix%0
					
					Loop
					{
						local original_file := heroes_screenshot_path . heroes_screenshot_file_prefix . A_Index
						local save_name := TimeString . "_" . A_Index . ".jpg"
						
						if FileExist(original_file)
						{
							FileCopy, %original_file%, %save_path%\%save_name%
							FileDelete, %original_file%
						}
						else
						{
							break
						}
					}
					
					saved_screenshot := true
				}				
			}
			else
			{
				saved_screenshot := false
			}
		}
		else
		{
			auto_save_screenshot := "off"
			msgbox, ScreenShot directory is not exist.
		}
	}
}

