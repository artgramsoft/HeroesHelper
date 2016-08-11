; Example: On-screen display (OSD) via transparent window:

class OnScreenDisplay
{
	__New(id, x, y, alpha := 255)
	{
		this.on := false
		this.init := false
		this.id := id
		this.alpha := alpha
		this.CustomColor := "EEAA99"  ; Can be any RGB color (it will be made transparent below).
		
		If (x = "")
		{
			x := 0
		}
		
		If (y = "")
		{
			y := 0
		}
		
		this.SetPosition(x, y)
	}
	
	SetPosition(x, y)
	{
		isMoved := false
		
		if (this.init)
		{
			if (this.posX <> x or this.posY <> y)
			{
				isMoved := true
			}
		}
		
		this.posX := x
		this.posY := y
		
		if isMoved
		{
			this.Show()
		}
	}
	
	SetFont(font, size, color := "FFFFFF")
	{
		id := this.id
		Gui, %id%:Font, s%size% c%color%, %font%
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
	
	Begin()
	{
		id := this.id
		Gui, %id%:+LastFound +AlwaysOnTop -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
		Gui, %id%:Color, % this.CustomColor
	}
	
	End()
	{
		bgColor := this.CustomColor
		alpha := this.alpha
		;WinSet, TransColor, %bgColor% %alpha%
		WinSetTransColor, %bgColor% %alpha%
		this.init := true
	}
	
	Show()
	{
		if (!this.init)
		{
			MsgBox, Please Init OnScreenDisplay first. (Use Begin() and End() Method.)
			return
		}
		
		this.on := true
		id := this.id
		posX := this.posX
		posY := this.posY

		Gui, %id%:Show, x%posX% y%posY% NoActivate  ; NoActivate avoids deactivating the currently active window.
		;Gui, %id%:Show, % "x" . this.posX . " y" . this.posY . " NoActivate"
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
