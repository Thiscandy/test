<!--#include file="class/API.asp"-->
<% 
Session.Codepage=65001

'切换页数的四个值
find_info=request("mc")
page_no=request("page")
page_size=request("rows")
rsort=request("sort")
order=request("order")

'建立API对象
Set API = New Yiten_API
ParaTemp = Array()
ParaTemp=ADD_Array(ParaTemp,"method","DMYC_SalePercent_GET")

ParaTemp=ADD_Array(ParaTemp,"find_info",find_info)
ParaTemp=ADD_Array(ParaTemp,"page_no",page_no)
ParaTemp=ADD_Array(ParaTemp,"page_size",page_size)
ParaTemp=ADD_Array(ParaTemp,"sort",rsort)
ParaTemp=ADD_Array(ParaTemp,"order",order)

sHtml = API.Post(ParaTemp)
set API = nothing

response.Write sHtml		
%>