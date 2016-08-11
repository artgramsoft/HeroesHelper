
g_dynamicHotstring := null

class DynamicHotstring
{
	__New(fileName, sectionName)
	{
		this.on := false
		this.fileName := fileName
		this.sectionName := sectionName
		this.trigger_string := ""
		this.trigger_array := Object()
		this.message_array := Object()
		
		this.InitDynamicHotstring()
		
		global g_dynamicHotstring := this
	}
	
	InitDynamicHotstring()
	{
		sectionName := this.sectionName
		
		;파일 체크.
		;IfNotExist, % this.fileName
		if (!FileExist(this.fileName))
		{
			FileAppend, [%sectionName%], % this.fileName
		}
		
		;파일 파싱.
		IniRead, plainHotstring, % this.fileName, % this.sectionName		
		;StringSplit, chat_array, plainHotstring, `n
		chat_array := StrSplit(plainHotstring, "`n")
		
		for index, element in chat_array
		{
			chat_msg := StrSplit(element, "=", " ")
			
			chat_trigger := Trim(chat_msg[1])
			chat_message := Trim(chat_msg[2])
			
			;MsgBox, % chat_trigger . " : " . chat_message
			
			this.trigger_array.Push(chat_trigger)
			this.message_array.Push(chat_message)
			this.trigger_string := Trim(this.trigger_string . "`," . chat_msg[1])
			
			;MsgBox, % index . " : " . this.trigger_array[index] . " : " . this.message_array[index]
		}
	}

	SetUse(on)
	{
		this.on := on
	}
	
	StartDynamicHotstring(timer := 250)
	{
		global g_dynamicHotstring
		
		this.on := true
		
		SetTimer, OnUpdateHotstring, %timer%
		Return
		
		OnUpdateHotstring:
			OnUpdateDynamicHotstring(g_dynamicHotstring)
		Return
	}
}

OnUpdateDynamicHotstring(obj)
{
	;more specific hotstring_trigger_array texts can be added here:
	Input, UserInput, *VI, {ESC}{Enter}, % obj.trigger_string

	if !obj.on
		return
	
	for index, element in obj.trigger_array
	{
		;IfNotEqual, UserInput, , MsgBox % "user input is " . UserInput . ", index is " . index . ", element is " . element . "`."
		
		;IfInString, UserInput, %element%
		if (InStr(UserInput, element))
		{
			currentKeyDelay := A_KeyDelay
			;SetKeyDelay, -1, -1
		
			;StringLen, Tlen, element
			Tlen := Strlen(element)
			;IniRead, ToSend, % A_ScriptDir . "\" . obj.fileName, % obj.sectionName, %element%
			ToSend := obj.message_array[index]
			;IfNotEqual, ToSend, Error, Send, {BS %Tlen%}%ToSend%
			if (ToSend != Error)
			{
				;Send, {BS %Tlen%}%ToSend%
				SendInput, {BS %Tlen%}%ToSend%
			}
			
			SetKeyDelay, %currentKeyDelay%
			Break
		}
	}
}
