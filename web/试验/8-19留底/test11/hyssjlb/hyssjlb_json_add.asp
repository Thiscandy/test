<!--#include file="class/API.asp"-->
<% 
Session.Codepage=65001

Refer_Date=request("Date")
SPU_Type=request("Type")
A_Value=request("Value")

'建立API对象
Set API = New Yiten_API
ParaTemp = Array()
ParaTemp=ADD_Array(ParaTemp,"method","DMYC_SC_ADD")

ParaTemp=ADD_Array(ParaTemp,"Refer_Date",Refer_Date)
ParaTemp=ADD_Array(ParaTemp,"SPU_Type",SPU_Type)
ParaTemp=ADD_Array(ParaTemp,"A_Value",A_Value)
sHtml = API.Post(ParaTemp)
set API = nothing

response.Write sHtml		
%>