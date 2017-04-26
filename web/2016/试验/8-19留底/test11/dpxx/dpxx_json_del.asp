<!--#include file="class/API.asp"-->
<% 
Session.Codepage=65001

CMD=request("cmd")

if cmd = "del" then

	Shop_ID=request("Shop_ID")

	Set API = New Yiten_API
	ParaTemp = Array()
	ParaTemp=ADD_Array(ParaTemp,"method","DMYC_SHOP_DEL")

	ParaTemp=ADD_Array(ParaTemp,"Shop_ID",Shop_ID)	
end if

if cmd = "unenable" then
	Shop_ID=request("Shop_ID")

	'建立API对象
	Set API = New Yiten_API
	ParaTemp = Array()
	ParaTemp=ADD_Array(ParaTemp,"method","DMYC_SHOP_UNENABLE")

	ParaTemp=ADD_Array(ParaTemp,"Shop_ID",Shop_ID)
end if

if cmd = "enable" then
	Shop_ID=request("Shop_ID")

	'建立API对象
	Set API = New Yiten_API
	ParaTemp = Array()
	ParaTemp=ADD_Array(ParaTemp,"method","DMYC_SHOP_ENABLE")

	ParaTemp=ADD_Array(ParaTemp,"Shop_ID",Shop_ID)
	
end if
sHtml = API.Post(ParaTemp)
set API = nothing

response.Write sHtml
%>