<!--#include file="class/API.asp"-->
<% 
Session.Codepage=65001

Session("")

 
order_id=request("order")
fhlx=request("fhlx")
shf_code=request("shf_code")
 

rsort=request("sort")
find_info=request("mc")
 

Set API = New Yiten_API
ParaTemp = Array()
if czlx="" then
	ParaTemp=ADD_Array(ParaTemp,"method","getapp_Get_fahuodan_list")
end if

if czlx="mx" then
	ParaTemp=ADD_Array(ParaTemp,"method","getapp_Get_fahuodan_MX")
	ParaTemp=ADD_Array(ParaTemp,"order_id",order_id)
end if

if czlx="add" then
	ParaTemp=ADD_Array(ParaTemp,"method","getapp_ADD_fahuodan")
	ParaTemp=ADD_Array(ParaTemp,"fhlx",fhlx) 
	ParaTemp=ADD_Array(ParaTemp,"shf_code",shf_code)
end if

ParaTemp=ADD_Array(ParaTemp,"page_no",request("page"))
ParaTemp=ADD_Array(ParaTemp,"page_size",request("rows"))
ParaTemp=ADD_Array(ParaTemp,"fhf_code",Session("fhf_code"))
ParaTemp=ADD_Array(ParaTemp,"fhf_czy",Session("fhf_czy"))
ParaTemp=ADD_Array(ParaTemp,"fhf_pass",Session("fhf_pass"))
sHtml = API.Post(ParaTemp)
set API = nothing

response.Write sHtml
%>