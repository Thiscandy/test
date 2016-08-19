<!--#include file="class/API.asp"-->
<% 
Session.Codepage=65001

SPU_Type=request("SPU_Type")
Pool_MB=request("Pool_MB")
IS_Analysis=request("IS_Analysis")

'建立API对象
Set API = New Yiten_API
ParaTemp = Array()
ParaTemp=ADD_Array(ParaTemp,"method","DMYC_SPU_TYPE_Seting_EDIT")

ParaTemp=ADD_Array(ParaTemp,"SPU_Type",SPU_Type)
ParaTemp=ADD_Array(ParaTemp,"Pool_MB",Pool_MB)
ParaTemp=ADD_Array(ParaTemp,"IS_Analysis",IS_Analysis)
sHtml = API.Post(ParaTemp)
set API = nothing

response.Write sHtml		
%>