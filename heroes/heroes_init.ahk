;------------------------------------------------------
; 트레이 메뉴.
;------------------------------------------------------
Menu, Tray, NoStandard,
Menu, Tray, Add,About,About
Menu, Tray, Add,Reset,Reset
Menu, Tray, Add,Quit,Quit
return

About:
	MsgBox, %title% %version% `nMade by whitesnake (whitesnake@uzoo.in)
return

Reset:
	reload
return

Quit:
	ExitApp
return