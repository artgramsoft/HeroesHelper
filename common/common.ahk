;======================================================
; 공용 함수.
;======================================================
ShowMessageBox(title, text)
{
	MsgBox, 0, %title%, %text%
}

ShowMessageBoxYesNo(title, text)
{
	MsgBox, 4, %title%, %text%

	if A_MsgBoxResult = "Yes"
	    return true
	else
	    return false
}

IsCapsLockOn()
{
	if GetKeyState("CapsLock", "T") = 1
		return true
	else
		return false
}

SetCapsLockOn(on)
{
	if on
	{
		SetCapsLockState, on
	}
	else
	{
		SetCapsLockState, off
	}
}

GetRandomValue(min, max)
{
	Random, output, %min%, %max%
	return output
}

GetRandomArray(arr)
{
	arrLength := arr.Length()
	Random, output, 1, %arrLength%
	selected := arr[output]
	return selected
}

ChatMessage(msg)
{
	SetKeyDelay, 0, 0
	
	Send, {Enter}
	Sleep, 200
	Send, %msg%
	Sleep, 200
	Send, {Enter}
}

MoveToCell(current_idx, sx, sy, w, h, x_count)
{
	mx := sx + (Mod(current_idx, x_count) * w)
	my := sy + (Floor(current_idx / x_count) * h)
	MouseMove, %mx%, %my%
}

MoveToWH(w, h)
{
	MouseGetPos, xpos, ypos
	mx := xpos + w
	my := ypos + h
	MouseMove, %mx%, %my%
}

SetImageRegion(x, y, width, height)
{
	image_region_left := x
	image_region_top := y
	image_region_right := x + width
	image_region_bottom := y + height
}

FindImageRegion(image_path, x, y, width, height, ByRef ix, ByRef iy, variation := 10)
{
	ImageSearch, ix, iy, %x%, %y%, %width%, %height%, *%variation% %image_path%

	if (errorlevel=1 || errorlevel=2)
	{
		return false
	}		 

	return true
}

FindImage(image_path, ByRef ix, ByRef iy, variation := 10)
{
	if (!FindImageRegion(image_path, 0, 0, A_ScreenWidth, A_ScreenHeight, ix, iy, variation))
	{
		return false
	}		 

	return true
}

FindImageOnly(image_path, variation := 10)
{
	if (!FindImageRegion(image_path, 0, 0, A_ScreenWidth, A_ScreenHeight, ix, iy, variation))
	{
		return false
	}		 

	return true
}

MoveToImage(image_path, variation := 10)
{
	if (!FindImage(image_path, ix, iy, variation))
	{
		return false
	}		 

	MouseMove, %ix%, %iy%

	return true
}

ClickToImage(image_path, offset_x, offset_y, variation := 10)
{
	if (!FindImage(image_path, ix, iy, variation))
	{
		return false
	}

	;SetMouseDelay, 100

	mx := ix + offset_x
	my := iy + offset_y

	MouseClick, left, %mx%, %my%
	;MouseMove, %mx%, %my%
	;Sleep, 100
	;Send, {LButton}	
	;Sleep, 100

	return true
}

RClickToImage(image_path, offset_x, offset_y, variation := 10)
{
	if (!FindImage(image_path, ix, iy, variation))
	{
		return false
	}

	mx := ix + offset_x
	my := iy + offset_y

	MouseClick, right, %mx%, %my%

	return true
}

ClickWithOffset(x, y, offset_x, offset_y)
{
	mx := x + offset_x
	my := y + offset_y

	MouseClick, left, %mx%, %my%
}