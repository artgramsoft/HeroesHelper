;======================================================
; 공용 매크로.
;======================================================
;매크로 재시작.
^!`::
	reload
return 

;윈도우 정보 얻기.
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

;항상 위로 설정.
^!t::
	;Winset, AlwaysOnTop, Toggle, A
	WinSetAlwaysOnTop("On", "A")
return

;현재 마우스 커서위치의 색상 값 얻기.
^!c::
	MouseGetPos, MouseX, MouseY
	PixelGetColor, color, %MouseX%, %MouseY%
	MsgBox The color at the current cursor position is %color%.
return

;======================================================
; 노트패드 매크로. * 테스트용.
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
