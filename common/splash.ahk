;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                         Splash Text with a transparent background.                          ;;;
;;; This is accomplished by using a gui window with a transcolor set.  The parameters to pass to;;;
;;; the function are as follows. A demonstration script is included at the bottom of this page. ;;;
;;;                                                                                             ;;;
;;;  Usage:  TransSplashText_On(Text)        TransSplashText_Off()                              ;;;
;;;                                                                                             ;;;
;;; You may also pass the following parameters to the On command.                               ;;;
;;;                                                                                             ;;;
;;;  TransSplashText_On(Text,Font,TC,SC,TS,xPos,yPos,TimeOut)                                   ;;;
;;;                                                                                             ;;;
;;;  Text = Text to display,    Font = Example "Arial",    TC = Color                           ;;;
;;;  SC = Shadow Color, use "0" for no shadow,             TS = Font Size                       ;;;
;;;  xPos and yPos = The screen position to display the text.                                   ;;;
;;;  TimeOut = Milliseconds to display the text, "0" is infinite, Meaning splashtext stays      ;;;
;;;  until TransSplashText_Off() is used.                                                       ;;;
;;;                                                                                             ;;;
;;;  Only the parameters to change need to be used as long as the other parameters are empty    ;;;
;;;  strings.  Example, the following would only change the shadow color, other parameters      ;;;
;;;  still retain their default values.                                                         ;;;
;;;  TransSplashText_On(Text,"","","Red","","","","")                                           ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

TransSplashText_On(Text="",Font="",TC="",SC="",TS="",xPos="",yPos="",TimeOut="")
{
	If Text = 
		Text = TransSplashText
	If Font = 
		Font = Impact
	If TC = 
		TC = White
	If SC = 
		SC = 828284
	If TS = 
		TS = 20
	If xPos = 
		xPos = Center
	If yPos = 
		yPos = Center
	If TimeOut = 
		TimeOut = 0
	If SC != 0
	{
		Gui, 99:Font, S%TS% C%SC%, %Font%
		Gui, 99:Add, Text, x12 y12, %Text%
	}
	
	Gui, 99:+LastFound -Caption +AlwaysOnTop +ToolWindow
	Gui, 99:Color, E9E9E9
	
	Gui, 99:Font, S%TS% C%TC%, %Font%
	Gui, 99:Add, Text, x10 y10 BackgroundTrans, %Text%
	
	WinSet, TransColor, E9E9E9 255
	Gui, 99:Show, x%xPos% y%yPos% NoActivate AutoSize, TransSplashTextWindow
	If TimeOut != 0
	{
		SetTimer, TextOff, %TimeOut%
		Return
		TextOff:
		TransSplashText_Off()
		Return
	}
}

TransSplashText_Off()
{
	Gui, 99:Destroy
	SetTimer, TextOff, Off
}
