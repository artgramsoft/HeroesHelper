
;------------------------------------------------------
; 레디 모드.
;------------------------------------------------------

#if WinActive("ahk_class Valve001") and IsMode(MODE_PIPET)

OnPickingColor:
	if (!heroes_active)
	{
		return
	}
	
	if (!IsMode(MODE_PIPET))
	{
		second_mouse.Hide()
		SetTimer, OnPickingColor, off
		return
	}
	
	MouseGetPos, mx2, my2
	MouseMove, %mx1%, %my1%
	dx := mx2 - mx1
	dy := my2 - my1
	second_mouse.Move(dx, dy)
	second_mouse.GetColor(pipet_color, window_x, window_y)
	vBlue := (pipet_color & 0xFF)
	vGreen := ((pipet_color & 0xFF00) >> 8)
	vRed := ((pipet_color & 0xFF0000) >> 16)
	second_mouse.SetText("RED", "R:" . vRed)
	second_mouse.SetText("GREEN", "G:" . vGreen)
	second_mouse.SetText("BLUE", "B:" . vBlue)
return

#if
