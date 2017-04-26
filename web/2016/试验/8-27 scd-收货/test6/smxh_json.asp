<!--#include file="class/API.asp"-->
<% 
Session.Codepage=65001

fhdh=request("mc")

Set API = New Yiten_API
ParaTemp = Array()
ParaTemp=ADD_Array(ParaTemp,"method","GetApp_Get_fahuodan_box_mx")
ParaTemp=ADD_Array(ParaTemp,"order_id",order_id)
ParaTemp=ADD_Array(ParaTemp,"box_no",box_no)
sHtml = API.Post(ParaTemp)
set API = nothing

response.Write sHtml
%>