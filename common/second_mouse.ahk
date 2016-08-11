class SecondMouse
{
	__New(id, cursor_width, cursor_height, cursor_path)
	{
		this.on := false
		this.init := false
		this.id := id
		this.cursorWidth := cursor_width
		this.cursorHeight := cursor_height
		this.cursorPath := cursor_path
		this.posX := 0
		this.posY := 0
		this.CustomColor := "000001"  ; Can be any RGB color (it will be made transparent below).
	}
	
	SetPosition(x, y)
	{
		this.posX := x
		this.posY := y
	}
	
	SetFont(font, size, color := "FFFFFF")
	{
		id := this.id
		Gui, %id%:Font, s%size% c%color%, %font%
	}
	
	SetBold(bold)
	{
		id := this.id
		if (bold)
			Gui, %id%:Font, bold
		else
			Gui, %id%:Font, normal
	}
	
	SetText(name, text)
	{
		id := this.id
		GuiControl, %id%:, %name%, %text%
	}
	
	SetTextColor(name, color)
	{
		id := this.id
		Gui %id%:Font, c%color%
		GuiControl, %id%:Font, %name%
	}
	
	SetVisible(name, visible)
	{
		id := this.id
		show := "Show"
		
		if (!visible)
		{
			show := "Hide"
		}
		
		GuiControl, %id%:%show%, %name%
	}
	
	; section : normal, new, row, col
	AddText(name, text, color, space := 0, section := "normal", option := "")
	{
		global
		
		local id := this.id
		local vv := ""
		local xy := ""
		local ss := ""
		local cc := "c" . color
		local name_length := 0
		
		local name_length := Strlen(name)
		
		if (name_length > 0)
		{
			vv := "v" . name
		}
		
		if (section = "normal" and space <> 0)
		{
			xy := "y+" . space
		}
		
		if (section = "new")
		{
			ss := "section"
		}
		
		if (section = "row")
		{
			ss := "xs"
		}

		if (section = "col")
		{
			ss := "ys"
		}
				
		Gui, %id%:Add, text, %vv% %xy% %cc% %ss% %option%, %text%
	}
	
	GetColor(ByRef color, offset_x, offset_y)
	{
		posX := this.posX - offset_x - 1
		posY := this.posY - offset_y - 1
		PixelGetColor, color, %posX%, %posY%
	}
	
	Begin()
	{
		global Cursor
		
		id := this.id
		cw := this.cursorWidth
		ch := this.cursorHeight
		cp := this.cursorPath
		
		Gui, %id%:+LastFound +AlwaysOnTop -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
		Gui, %id%:Color, % this.CustomColor
		Gui, %id%:Add, Pic, x0 y0 w%cw% h%ch% vCursor, %cp%
	}
	
	End()
	{
		bgColor := this.CustomColor
		alpha := this.alpha
		;WinSet, TransColor, %bgColor% %alpha%
		WinSetTransColor, %bgColor% %alpha%
		this.init := true
	}
	
	Move(x, y)
	{
		this.Show(this.posX + x, this.posY + y)
	}
	
	Show(x, y)
	{
		if (!this.init)
		{
			MsgBox, Please Init OnScreenDisplay first. (Use Begin() and End() Method.)
			return
		}
		
		this.SetPosition(x, y)
		
		this.on := true
		id := this.id		
		posX := this.posX
		posY := this.posY
		
		Gui, %id%:Show, x%posX% y%posY% AutoSize NoActivate  ; NoActivate avoids deactivating the currently active window.
	}
	
	Hide()
	{
		this.on := false
		id := this.id
		
		Gui, %id%:CanCel
	}
	
	Close()
	{
		this.on := false
		id := this.id
		
		Gui, %id%:Destroy
	}
}

/*
gui, color, ff0000
gui -Caption -sysmenu
;WinSet, Region, 5-10 0-10 0-0, luuu
Gui, +LastFound +AlwaysOnTop -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui, Color, % this.CustomColor
;winset, alwaysontop, on, luuu
gui, show, w30 h30 x0 y0, luuu
speed = 30
return

^Esc::
	ExitApp
return

+Esc::
	reload
return

^a::
MouseGetPos, mx1, my1
winmove, luuu,, %mx1%, %my1%
return

^d::
MouseGetPos, mx1, my1
x := mx1
y := my1
gosub reload
SetTimer,Timer,50
return

^f::
SetTimer,Timer,Off
return

Timer:
     MouseGetPos,mx2,my2
	 MouseMove,mx1,my1
     dx := mx2 - mx1
	 dy := my2 - my1
	 x += dx
	 y += dy
	 gosub reload
return

esc::exitapp


reload:
;winset, alwaysontop, on, luuu
xt := x - 1
yt := y - 1
winmove, luuu,, %xt%, %yt%
return
*/