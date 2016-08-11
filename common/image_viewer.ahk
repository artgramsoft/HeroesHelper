; Example: Simple image viewer:

Gui, +Resize
Gui, Add, Button, default, &Load New Image
Gui, Add, Radio, ym+5 x+12 vRadio checked, Load &actual size`tCtrl+U
Gui, Add, Radio, ym+5 x+2, Load to &fit screen
Gui, Add, Pic, xm vPic
Gui, Show
return

ButtonLoadNewImage:
FileSelectFile, file,,, Select an image:, Images (*.gif; *.jpg; *.bmp; *.png; *.tif; *.ico; *.cur; *.ani; *.exe; *.dll)
if file =
    return
;MsgBox, you select %file%
Gui, Submit, NoHide ; Save the values of the radio buttons.
if Radio = 1  ; Display image at its actual size.
{
    Width = 0
    Height = 0
}
else ; Second radio is selected: Resize the image to fit the screen.
{
    Width := A_ScreenWidth - 28  ; Minus 28 to allow room for borders and margins inside.
    Height = -1  ; "Keep aspect ratio" seems best.
}
GuiControl,, Pic, *w%width% *h%height% %file%  ; Load the image.
Gui, Show, xCenter yCenter AutoSize, %file%  ; Resize the window to match the picture size.
return

GuiClose:
ExitApp