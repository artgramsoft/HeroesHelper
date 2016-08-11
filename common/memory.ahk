;======================================================
; 공용 매크로.
;======================================================
^r::
	addr := 0x07B7EE7A
	offset := 0x144
	Loop, 100
	{
		value:=ReadMemory(addr, "ahk_class Notepad")
		msgbox, Memory address addr = %value%
		addr := value + offset
	}
return

ReadMemory(MADDRESS,PROGRAM)
{
	;winget, pid, PID, %PROGRAM%
	winget, pid, PID, A
	pid := 2956
	msgbox, pid is %pid%

	VarSetCapacity(MVALUE,4,0)
	ProcessHandle := DllCall("OpenProcess", "Int", 24, "Char", 0, "UInt", pid, "UInt")
	DllCall("ReadProcessMemory","UInt",ProcessHandle,"UInt",MADDRESS,"Str",MVALUE,"UInt",4,"UInt *",0)

	Loop 4
	result += *(&MVALUE + A_Index-1) << 8*(A_Index-1)

	return, result  
}

ReadMemory_Str(MADDRESS=0, pOffset = 0, PROGRAM = "StarCraft II", length = 0 , terminator = "") 
{ 
	Static OLDPROC, ProcessHandle
	VarSetCapacity(MVALUE,4,0)
	If PROGRAM != %OLDPROC%
	{
		WinGet, pid, pid, % OLDPROC := PROGRAM
		ProcessHandle := ( ProcessHandle ? 0*(closed:=DllCall("CloseHandle"
		,"UInt",ProcessHandle)) : 0 )+(pid ? DllCall("OpenProcess"
		,"Int",16,"Int",0,"UInt",pid) : 0) ;PID is stored in value pid
	}
	If (MADDRESS = 0) ; the above expression/syntax does my head, hence easy close handle
		closed:=DllCall("CloseHandle","UInt",ProcessHandle)
	If ( length = 0) ; read until terminator found
	{
		teststr = 
        Loop
        { 
            Output := "x"  ; Put exactly one character in as a placeholder. used to break loop on null 
            tempVar := DllCall("ReadProcessMemory", "UInt", ProcessHandle, "UInt", MADDRESS+pOffset, "str", Output, "Uint", 1, "Uint *", 0) 
            if (ErrorLevel or !tempVar) 
               return teststr 
            if (Output = terminator)
              break 
            teststr .= Output 
            MADDRESS++ 
		} 
        return, teststr  
		}		
	Else ; will read until X length
	{
		 teststr = 
         Loop % length
         { 
            Output := "x"  ; Put exactly one character in as a memory placeholder. 
            tempVar := DllCall("ReadProcessMemory", "UInt", ProcessHandle, "UInt", MADDRESS+pOffset, "str", Output, "Uint", 1, "Uint *", 0) 
            if (ErrorLevel or !tempVar) 
              return teststr 
            teststr .= Output
            MADDRESS++ 
         } 
          return, teststr  
	}	 
}

WriteMemory(WVALUE,MADDRESS,PROGRAM)
{
	winget, pid, PID, %PROGRAM%

	ProcessHandle := DllCall("OpenProcess", "int", 2035711, "char", 0, "UInt", PID, "UInt")
	DllCall("WriteProcessMemory", "UInt", ProcessHandle, "UInt", MADDRESS, "Uint*", WVALUE, "Uint", 4, "Uint *", 0)

	DllCall("CloseHandle", "int", ProcessHandle)
	return
}

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
	Winset, AlwaysOnTop, Toggle, A
	;WinSetAlwaysOnTop("On", "A")
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
