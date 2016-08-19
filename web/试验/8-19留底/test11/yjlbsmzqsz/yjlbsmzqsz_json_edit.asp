<!--#include file="class/API.asp"-->
<% 
Session.Codepage=65001

SPU_Type=request("SPU_Type")
B_Date=request("B_Date")
E_Date=request("E_Date")
L_Percent=request("L_Percent")
E_Percent=request("E_Percent")
H_Percent=request("H_Percent")
Min_SoldWeeks=request("Min_SoldWeeks")
Min_BreakWeeks=request("Min_BreakWeeks")
IS_Analysis=request("IS_Analysis")
SoldCycleSeting_BZ=request("SoldCycleSeting_BZ")

'建立API对象
Set API = New Yiten_API
ParaTemp = Array()
ParaTemp=ADD_Array(ParaTemp,"method","DMYC_SPU_TYPE_SoldCycleSeting_EDIT")

ParaTemp=ADD_Array(ParaTemp,"SPU_Type",SPU_Type)
ParaTemp=ADD_Array(ParaTemp,"B_Date",B_Date)
ParaTemp=ADD_Array(ParaTemp,"E_Date",E_Date)
ParaTemp=ADD_Array(ParaTemp,"L_Percent",L_Percent)
ParaTemp=ADD_Array(ParaTemp,"E_Percent",E_Percent)
ParaTemp=ADD_Array(ParaTemp,"H_Percent",H_Percent)
ParaTemp=ADD_Array(ParaTemp,"Min_SoldWeeks",Min_SoldWeeks)
ParaTemp=ADD_Array(ParaTemp,"Min_BreakWeeks",Min_BreakWeeks)
ParaTemp=ADD_Array(ParaTemp,"IS_Analysis",IS_Analysis)
ParaTemp=ADD_Array(ParaTemp,"SoldCycleSeting_BZ",SoldCycleSeting_BZ)
sHtml = API.Post(ParaTemp)
set API = nothing

response.Write sHtml		
%>