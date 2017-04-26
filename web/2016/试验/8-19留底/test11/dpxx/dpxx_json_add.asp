<!--#include file="class/API.asp"-->
<% 
Session.Codepage=65001

Shop_ID=request("Shop_ID")
Shop_MC=request("Shop_MC")
Shop_ByName=request("Shop_ByName")
Shop_LX=request("Shop_LX")
Shop_BZ=request("Shop_BZ")

'建立API对象
Set API = New Yiten_API
ParaTemp = Array()
ParaTemp=ADD_Array(ParaTemp,"method","DMYC_SHOP_ADD")

ParaTemp=ADD_Array(ParaTemp,"Shop_ID",Shop_ID)
ParaTemp=ADD_Array(ParaTemp,"Shop_MC",Shop_MC)
ParaTemp=ADD_Array(ParaTemp,"Shop_ByName",Shop_ByName)
ParaTemp=ADD_Array(ParaTemp,"Shop_LX",Shop_LX)
ParaTemp=ADD_Array(ParaTemp,"Shop_BZ",Shop_BZ)
sHtml = API.Post(ParaTemp)
set API = nothing

response.Write sHtml		
%>