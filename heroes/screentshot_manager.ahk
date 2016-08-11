
class ScreenShotManager
{
	__New(id, x, y, w, h)
	{
		this.id := id
		this.on := false
		this.selected := 0
		
		this.screenshot_path := A_MyDocuments . "\마비노기 영웅전\스크린샷\"
		
		this.SetPosition(x, y)
		this.SetSize(w, h)
		
		this.Init()
	}
	
	SetPosition(x, y)
	{
		this.pos_x := x
		this.pos_y := y
	}
	
	SetSize(w, h)
	{
		this.width := w
		this.height := h
		
		this.margin := 30
		this.lb_width := 140
		this.lb_height := this.height - this.margin - (25 * 4) ;25 is button height
	}
	
	Init()
	{
		global CloseViewer, SaveImage, DeleteImage, DeleteAll, Pic
		
		Gui, %this.id%: default
		
		;Gui, +LastFound +AlwaysOnTop -Caption +ToolWindow
		Gui, +LastFound -Caption
		Gui, Color, 121212
		Gui, Add, Button, w%this.lb_width% vCloseViewer gButtonCloseViewer, &Close
		Gui, Add, Button, w%this.lb_width% vSaveImage gButtonSaveImage, &Save Image
		Gui, Add, Button, w%this.lb_width% vDeleteImage gButtonDeleteImage, &Delete Image
		Gui, Add, Button, w%this.lb_width% vDeleteAll gButtonDeleteAll, &Delete All
		Gui, Add, ListView, xm r20 AltSubmit w%this.lb_width% h%this.lb_height% gScreenShotListView, Name|Path

		this.LoadImage()

		LV_ModifyCol(1, "Auto") ;auto size column.
		LV_ModifyCol(2, 0) ;hide column
		
		Gui, Add, Pic, ym vPic
	}
	
	LoadImage()
	{
		Gui, %this.id%: default		
		
		Loop, Files, %this.screenshot_path%\Helper\*.*
		{
			LV_Add("", A_LoopFileName, A_LoopFileFullPath)
		}
	}
	
	Show()
	{
		Gui, %this.id%:Show, x%this.pos_x% y%this.pos_y% w%this.width% h%this.height%
	}
	
	Hide()
	{
		this.on := false
		Gui, %this.id%:Cancel
	}
	
	Close()
	{
		this.on := false
		Gui, %this.id%:Destroy
	}
	
	Select(row)
	{
		this.selected := row
		
		Gui, %this.id%: default		
		;LV_GetText(selectedFileName, row)
		LV_GetText(selectedFilePath, row, 2)
		this.ShowImage(selectedFilePath, false)
	}
	
	ReSelect()
	{
		Gui, %this.id%: default
		total_count := LV_GetCount()
		if (this.selected <= total_count)
		{
			LV_Modify(this.selected, "Select")
		}
		else
		{
			LV_Modify(total_count, "Select")
		}
	}
	
	Open(row)
	{
		Gui, %this.id%: default
		LV_GetText(selectedFilePath, row, 2)
		Run, %selectedFilePath%
	}
	
	ShowImage(file, isActualSize)
	{
		if (isActualSize)
		{
			image_width := 0
			image_height := 0
		}
		else
		{
			image_width := this.width - this.lb_width - this.margin
			image_height := -1 ;"Keep aspect ratio" seems best.
		}
		
		GuiControl,, Pic, *w%image_width% *h%image_height% %file%  ; Load the image.
	}
	
	SaveImage()
	{
		if (this.selected > 0)
		{
			Gui, %this.id%: default
			LV_GetText(selectedFilePath, this.selected, 2)
			FileCopy, %selectedFilePath%, %this.screenshot_path%
			FileDelete, %selectedFilePath%
			LV_Delete(this.selected)
			this.ReSelect()
		}
	}
	
	DeleteImage()
	{
		if (this.selected > 0)
		{
			Gui, %this.id%: default
			LV_GetText(selectedFilePath, this.selected, 2)
			FileDelete, %selectedFilePath%
			LV_Delete(this.selected)
			this.ReSelect()
		}
	}
	
	DeleteAll()
	{
		GuiControl,, Pic, ""  ; Load the image.
		FileDelete, %this.screenshot_path%\Helper\*.*
		LV_Delete()
	}
}

screenShotManager := new ScreenShotManager(1, 0, 0, A_ScreenWidth, A_ScreenHeight)
screenShotManager.Show()
return

ButtonCloseViewer:
	screenShotManager.Hide()
return

ButtonSaveImage:
	screenShotManager.SaveImage()
return

ButtonDeleteImage:
	screenShotManager.DeleteImage()
return

ButtonDeleteAll:
	screenShotManager.DeleteAll()
return

ScreenShotListView:
	if (A_GuiEvent = "Normal")
	{
		screenShotManager.Select(A_EventInfo)
	}
	else if (A_GuiEvent = "I")
	{
		if (GetKeyState("LButton","P"))
		{
			return
		}
		
		if (InStr(ErrorLevel, "S", true))
		{
			screenShotManager.Select(A_EventInfo)
		}		
	}
	else if (A_GuiEvent = "RightClick")
	{
		screenShotManager.Open(A_EventInfo)
	}
return
