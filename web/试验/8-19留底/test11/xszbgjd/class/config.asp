<%
Session.Codepage=65001

Function json_str(acanshu,Adata)

	json_str=""""& acanshu&""":"""&adata&""""
	
end function 
 
Function Post(Aurl,Adata)

	dim Https 
	set Https=server.createobject("MSXML2.XMLHTTP")
	Https.open "POST",Aurl,false
	Https.setRequestHeader "Content-Type","application/x-www-form-urlencoded"
	Https.send Adata
	if Https.readystate=4 then
		dim objstream 
		set objstream = Server.CreateObject("adodb.stream")
		objstream.Type = 1
		objstream.Mode =3
		objstream.Open
		objstream.Write Https.responseBody
		objstream.Position = 0
		objstream.Type = 2
		objstream.Charset = "utf-8"
		Post = objstream.ReadText
		objstream.Close
		set objstream = nothing
		set https=nothing
	end if
End Function

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