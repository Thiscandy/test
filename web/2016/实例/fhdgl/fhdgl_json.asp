<!--#include file="class/API.asp"-->
<% 
Session.Codepage=65001
 
czlx=request("czlx")
order_id=request("order_id")
fhlx=request("fhlx")
shf_code=request("shf_code")
items=request("items")

rsort=request("sort")
find_info=request("mc")
 

Set API = New Yiten_API
ParaTemp = Array()
if czlx="" then
	ParaTemp=ADD_Array(ParaTemp,"method","GetApp_Get_fahuodan_list")
end if

if czlx="mx" then
	ParaTemp=ADD_Array(ParaTemp,"method","GetApp_Get_fahuodan_MX")
	ParaTemp=ADD_Array(ParaTemp,"order_id",order_id)
end if

if czlx="zx" then
	ParaTemp=ADD_Array(ParaTemp,"method","GetApp_Get_fahuodan_zhuangxian_mx")
	ParaTemp=ADD_Array(ParaTemp,"order_id",order_id)
	ParaTemp=ADD_Array(ParaTemp,"box_no",box_no)
end if

if czlx="cjfhd" then
	ParaTemp=ADD_Array(ParaTemp,"method","GetApp_ADD_fahuodan")
	ParaTemp=ADD_Array(ParaTemp,"fhlx",fhlx) 
	ParaTemp=ADD_Array(ParaTemp,"shf_code",shf_code)
end if

if czlx="mx" then
	ParaTemp=ADD_Array(ParaTemp,"method","GetApp_Get_fahuodan_MX")
	ParaTemp=ADD_Array(ParaTemp,"order_id",order_id)
end if

if czlx="hpzx" then
	ParaTemp=ADD_Array(ParaTemp,"method","GetApp_ADD_fahuodan_box")
	ParaTemp=ADD_Array(ParaTemp,"order_id",order_id)
	ParaTemp=ADD_Array(ParaTemp,"items",items)
end if

if czlx="qrfh" then
	ParaTemp=ADD_Array(ParaTemp,"method","GetApp_Set_fahuodan_ck")
	ParaTemp=ADD_Array(ParaTemp,"order_id",order_id)
end if

ParaTemp=ADD_Array(ParaTemp,"page_no",request("page"))
ParaTemp=ADD_Array(ParaTemp,"page_size",request("rows"))
ParaTemp=ADD_Array(ParaTemp,"fhf_code",session("fhf_code"))
ParaTemp=ADD_Array(ParaTemp,"fhf_czy",session("fhf_czy"))
ParaTemp=ADD_Array(ParaTemp,"fhf_pass",session("fhf_pass"))
sHtml = API.Post(ParaTemp)
set API = nothing

response.Write sHtml
%>