detectHiddenWindows, On ; @ auto-execute section
SetTitleMatchMode, 2

;ControlGet, heroesHwnd, Hwnd, , , ahk_class Valve001
ControlGetFocus, heroesHwnd, Untitled - Notepad

^j::
Send, i
return


^k::
SetTitleMatchMode, 2
ControlSend, , i, ������ ������
return


^l::
SetTitleMatchMode, 2
ControlSend, , i, ������ ������
return

^h::
;ControlGet, outputHwnd, Hwnd, , , ahk_class Valve001
ControlGetFocus, outputHwnd, ahk_class Valve001
if ErrorLevel
    MsgBox There was a problem.
else
    MsgBox HWND %outputHwnd% is active.
return