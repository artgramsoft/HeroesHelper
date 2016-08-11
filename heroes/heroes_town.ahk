

#if WinActive("ahk_class Valve001") and IsMode(MODE_TOWN)

;------------------------------------------------------
; 마을 모드.
;------------------------------------------------------

;대사 스킵 1
~Space::
	if (A_PriorHotkey <> "~Space" or A_TimeSincePriorHotkey > double_click_speed)
	{
		KeyWait, Space
		return
	}

	SetKeyDelay, 10, 10
	
	While GetKeyState("Space","P")
	{
		Send, {Space}
		Sleep, 50
	}
return

;대사 스킵 2
~LButton::
	if (A_PriorHotkey <> "~LButton" or A_TimeSincePriorHotkey > double_click_speed)
	{
		KeyWait, LButton
		return
	}
	
	Sleep, 200

	SetKeyDelay, 10, 10
	
	While GetKeyState("LButton","P")
	{
		Send, {LButton}
		Sleep, 50
	}
return

~+LButton::
	MouseGetPos, curr_x, curr_y
		
	if (CheckSystemOKButton())
	{
		MouseMove, %curr_x%, %curr_y%
		return 	
	}	
return

~+RButton::
	MouseGetPos, curr_x, curr_y
	
	if (CheckEnterShipButton())
	{
		MouseMove, %curr_x%, %curr_y%
		return
	}
return

\::
	SendInput, 999
return

+Enter::
	notify_path := "heroes\notify.PNG"
	
	if (FindImage(notify_path, ix, iy, 20))
	{
		MouseGetPos, curr_x, curr_y
		
		;buy all 1
		btn_offset_x := 85
		btn_offset_y := 170
		ClickWithOffset(ix, iy, btn_offset_x, btn_offset_y)
		
		;buy all 2
		btn_offset_x := 85
		btn_offset_y := 185
		ClickWithOffset(ix, iy, btn_offset_x, btn_offset_y)
		
		MouseMove, %curr_x%, %curr_y%
	}
return

;나가기
MButton::
	town_mbutton_start := true
	
	While GetKeyState("MButton","P")
	{
		Send, {Esc}
		
		if (town_mbutton_start)
		{
			Sleep, 200
			town_mbutton_start := false
		}
		else
		{
			Sleep, 50
		}
	}
return

;달리기
RButton::
	if ((A_PriorHotkey <> "RButton") || (A_TimeSincePriorHotkey > double_click_speed))
	{
		;시점 변경을 위한 우클릭 드래그 기능 구현을 위해 Down과 Up 이벤트를 따로 발생시킨다.
		Send, {RButton Down}		
		KeyWait, RButton, Up		
		Send, {RButton Up}
	
		return
	}

	;우클릭을 연속으로 클릭할 경우, 씹히지 않도록 이벤트를 발생시킨다.
	Send, {RButton}
	AutoRun("RButton")	
return

;------------------------------------------------------
; 매크로.
;------------------------------------------------------

;분해 매크로.
^!-::
	btn_decompose_path := "heroes\btn_decompose.PNG"
	btn_ok_path := "heroes\btn_ok.PNG"
	;decompose_progress := "heroes\decompose_progress.PNG"

	btn_offset_x := 10
	btn_offset_y := 10

	cell_width := 42
	cell_height := 42
	row_count := 6

	MouseGetPos, start_x, start_y

	Loop
	{
		MouseClick, right
		Sleep, 300

		if (!ClickToImage(btn_decompose_path, btn_offset_x, btn_offset_y))
		{
			break
		}
		
		Sleep, 1000

		Loop
		{
			if (FindImageOnly(btn_ok_path))
				break
			else
				Sleep, 300
			
			;if (FindImageOnly(decompose_progress))
			;	Sleep, 300
			;else
			;	break
		}

		if (!ClickToImage(btn_ok_path, btn_offset_x, btn_offset_y))
		{
			MsgBox, can not find ok button.
			return
		}

		Sleep, 500
		MoveToCell(A_Index, start_x, start_y, cell_width, cell_height, row_count)
	}

	MsgBox, complete.
return

;제작 매크로.
^!=::
	btn_open_craft := "heroes\btn_open_craft.PNG"
	
	craft_sp_ll_head := "heroes\craft_sp_ll_head.PNG"
	craft_sp_ll_hand := "heroes\craft_sp_ll_hand.PNG"
	craft_sp_ll_foot := "heroes\craft_sp_ll_foot.PNG"
	
	craft_rp_ll_head := "heroes\craft_rp_ll_head.PNG"
	craft_rp_ll_hand := "heroes\craft_rp_ll_hand.PNG"
	craft_rp_ll_foot := "heroes\craft_rp_ll_foot.PNG"
	
	craft_mix_ll_head := "heroes\craft_mix_ll_head.PNG"
	craft_mix_ll_hand := "heroes\craft_mix_ll_hand.PNG"
	craft_mix_ll_foot := "heroes\craft_mix_ll_foot.PNG"
	
	craft_sp_br_head := "heroes\craft_sp_br_head.PNG"
	craft_sp_br_hand := "heroes\craft_sp_br_hand.PNG"
	craft_sp_br_foot := "heroes\craft_sp_br_foot.PNG"
	
	craft_rp_br_head := "heroes\craft_rp_br_head.PNG"
	craft_rp_br_hand := "heroes\craft_rp_br_hand.PNG"
	craft_rp_br_foot := "heroes\craft_rp_br_foot.PNG"
	
	craft_mix_br_head := "heroes\craft_mix_br_head.PNG"
	craft_mix_br_hand := "heroes\craft_mix_br_hand.PNG"
	craft_mix_br_foot := "heroes\craft_mix_br_foot.PNG"
	
	craft_sp_bg_head := "heroes\craft_sp_bg_head.PNG"
	craft_sp_bg_hand := "heroes\craft_sp_bg_hand.PNG"
	craft_sp_bg_foot := "heroes\craft_sp_bg_foot.PNG"
	
	craft_rp_bg_head := "heroes\craft_rp_bg_head.PNG"
	craft_rp_bg_hand := "heroes\craft_rp_bg_hand.PNG"
	craft_rp_bg_foot := "heroes\craft_rp_bg_foot.PNG"
	
	craft_mix_bg_head := "heroes\craft_mix_bg_head.PNG"
	craft_mix_bg_hand := "heroes\craft_mix_bg_hand.PNG"
	craft_mix_bg_foot := "heroes\craft_mix_bg_foot.PNG"
	
	btn_offset_x := 10
	btn_offset_y := 10
	
	craft_step := 0
	
	Loop
	{
		if (ClickToImage(btn_open_craft, btn_offset_x, btn_offset_y, 50))
		{
			Sleep, 1000
			MouseMove, 0, -50, 0, R
			MouseClick, left
			Sleep, 1000
			MouseClick, left
			
			Sleep, 500
			Send, i
			Sleep, 2000
			
			craft_step++
			
			if (CraftItem90Level(craft_sp_bg_head, craft_rp_bg_head, craft_mix_bg_head))
			{
				continue
			}
			
			if (CraftItem90Level(craft_sp_bg_hand, craft_rp_bg_hand, craft_mix_bg_hand))
			{
				continue
			}
			
			if (CraftItem90Level(craft_sp_bg_foot, craft_rp_bg_foot, craft_mix_bg_foot))
			{
				continue
			}
			
			if (CraftItem90Level(craft_sp_ll_head, craft_rp_ll_head, craft_mix_ll_head))
			{
				continue
			}
			
			if (CraftItem90Level(craft_sp_ll_hand, craft_rp_ll_hand, craft_mix_ll_hand))
			{
				continue
			}
			
			if (CraftItem90Level(craft_sp_ll_foot, craft_rp_ll_foot, craft_mix_ll_foot))
			{
				continue
			}
			
			if (CraftItem90Level(craft_sp_br_head, craft_rp_br_head, craft_mix_br_head))
			{
				continue
			}
			
			if (CraftItem90Level(craft_sp_br_hand, craft_rp_br_hand, craft_mix_br_hand))
			{
				continue
			}
			
			if (CraftItem90Level(craft_sp_br_foot, craft_rp_br_foot, craft_mix_br_foot))
			{
				continue
			}
			
			break
		}
		else
		{
			break
		}		
	}

	MsgBox, complete, %craft_step%
return

CraftItem90Level(sp_target, rp_target, mix_target)
{
	btn_craft := "heroes\btn_craft.PNG"
	btn_craft_mix := "heroes\btn_craft_mix.PNG"
	
	craft_progress := "heroes\craft_progress.PNG"
	
	craft_ts_hard := "heroes\craft_ts_hard.PNG"
	craft_mix_hard := "heroes\craft_mix_hard.PNG"
	
	btn_offset_x := 10
	btn_offset_y := 10
	
	craft_step := 0
	
	if (MoveToImage(sp_target, 50))
	{
		craft_step++
		if (ClickToImage(rp_target, btn_offset_x, btn_offset_y, 90))
		{
			craft_step++
			Sleep, 500
			if (ClickToImage(btn_craft, btn_offset_x, btn_offset_y, 40))
			{
				craft_step++
				
				;Sleep, 500						
				;ClickToImage(sp_target, btn_offset_x, btn_offset_y, 50)
				;Sleep, 500
				;ClickToImage(mix_target, btn_offset_x, btn_offset_y, 20)
				;Sleep, 500
				;Send, {LButton}
				
				;Sleep, 500						
				;ClickToImage(craft_ts_hard, btn_offset_x, btn_offset_y, 50)
				;Sleep, 500
				;ClickToImage(craft_mix_hard, btn_offset_x, btn_offset_y, 20)
				;Sleep, 500
				;Send, {LButton}
				
				Sleep, 500						
				RClickToImage(sp_target, btn_offset_x, btn_offset_y, 50)
				Sleep, 500						
				RClickToImage(craft_ts_hard, btn_offset_x, btn_offset_y, 50)
				
				Sleep, 500
				ClickToImage(btn_craft_mix, btn_offset_x, btn_offset_y, 40)
				
				Loop
				{
					Sleep, 5000
					
					if (!MoveToImage(craft_progress, 20))
					{
						break
					}							
				}
				
				Sleep, 5000
				
				return true
			}
		}
	}
	
	;msgbox, craft failed %craft_step%
	
	return false
}

#if