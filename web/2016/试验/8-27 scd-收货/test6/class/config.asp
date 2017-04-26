<%
	Dim scriptCtrl
	Function parseJSON(str)
		If Not IsObject(scriptCtrl) Then
			Set scriptCtrl = Server.CreateObject("MSScriptControl.ScriptControl")
			scriptCtrl.Language = "JScript"
			scriptCtrl.AddCode "function ActiveXObject() {}" '覆盖 ActiveXObject
			scriptCtrl.AddCode "function GetObject() {}" '覆盖 ActiveXObject
			scriptCtrl.AddCode "Array.prototype.get = function(x) { return this[x];}; var result = null;"
		End If
		On Error Resume Next
		scriptCtrl.ExecuteStatement "result = " & str & ";"
		Set parseJSON = scriptCtrl.CodeObject.result
		If Err Then
			Err.Clear
			Set parseJSON = Nothing
		End If
	End Function
%>