;======================================================
; ���� ��ũ��.
;======================================================
;��ũ�� �����.
^!`::
	reload
return 

;������ ���� ���.
^!i::
	WinGetTitle, window_title, A
	WinGetClass, window_class, A
	window_id := WinExist("A")
	WinGetPos, window_x, window_y, window_width, window_height, A
		
	result := "Title is %window_title%, Class is %window_class%, ID is %window_id%, Position(%window_x%, %window_y%), Size(%window_width%, %window_height%)"
	MsgBox %result%
	
	FileName := "info.txt"
	file := FileOpen(FileName, "w")
	
	if !IsObject(file)
	{
		MsgBox Can't open "%FileName%" for writing.
		return
	}
	
	file.Write(result)
	file.Close()
return

;�׻� ���� ����.
^!t::
	;Winset, AlwaysOnTop, Toggle, A
	WinSetAlwaysOnTop("On", "A")
return

;���� ���콺 Ŀ����ġ�� ���� �� ���.
^!c::
	MouseGetPos, MouseX, MouseY
	PixelGetColor, color, %MouseX%, %MouseY%
	MsgBox The color at the current cursor position is %color%.
return

;======================================================
; ��Ʈ�е� ��ũ��. * �׽�Ʈ��.
;======================================================
#IfWinActive ahk_class Notepad
f8::
	;ShowSplashText(300, 25, "testsetst", 3000)
	;ShowMessageBox("hi hello")

	MsgBox press.
	KeyWait, f8  ; Wait for user to physically release it.
	MsgBox release.
return
#IfWinActive
