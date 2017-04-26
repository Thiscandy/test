<!--#include file="class/API.asp"-->
<% 
Session.Codepage=65001

Pool_MB=request("Pool_MB")
Material_Tpye=request("Material_Tpye")
PR_0=request("PR_0")
PR_light=request("PR_light")
PR_heavy=request("PR_heavy")
Profit_BZ=request("Profit_BZ")

'建立API对象
Set API = New Yiten_API
ParaTemp = Array()
ParaTemp=ADD_Array(ParaTemp,"method","DMYC_Profit_EDIT")

ParaTemp=ADD_Array(ParaTemp,"Pool_MB",Pool_MB)
ParaTemp=ADD_Array(ParaTemp,"Material_Tpye",Material_Tpye)
ParaTemp=ADD_Array(ParaTemp,"PR_0",PR_0)
ParaTemp=ADD_Array(ParaTemp,"PR_light",PR_light)
ParaTemp=ADD_Array(ParaTemp,"PR_heavy",PR_heavy)
ParaTemp=ADD_Array(ParaTemp,"Profit_BZ",Profit_BZ)
sHtml = API.Post(ParaTemp)
set API = nothing

response.Write sHtml		
%>