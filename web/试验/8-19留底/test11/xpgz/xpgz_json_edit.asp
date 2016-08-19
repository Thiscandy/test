<!--#include file="class/API.asp"-->
<% 
Session.Codepage=65001

GZ_SPU=request("SPU")
key=request("key")
value=request("value")


'建立API对象
Set API = New Yiten_API
ParaTemp = Array()
ParaTemp=ADD_Array(ParaTemp,"method","SPUGZ_XPGZ_EDIT")

'ParaTemp=ADD_Array(ParaTemp,"field",field)
'ParaTemp=ADD_Array(ParaTemp,"value",value)

ParaTemp=ADD_Array(ParaTemp,key,value)

ParaTemp=ADD_Array(ParaTemp,"GZ_SPU",GZ_SPU)
sHtml = API.Post(ParaTemp)
set API = nothing

response.Write sHtml		
%>