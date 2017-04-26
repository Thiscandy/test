<!--#include file="class/API.asp"-->
<% 
Session.Codepage=65001

GZ_SPU=request("SPU")
GZ_XQFQ=request("GZ_XQFQ")
GZ_GC=request("GC")
GZ_ZT=request("ZT")
GZ_TP=request("TP")

'建立API对象
Set API = New Yiten_API
ParaTemp = Array()
ParaTemp=ADD_Array(ParaTemp,"method","SPUGZ_XPGZ_ADD")
ParaTemp=ADD_Array(ParaTemp,"GZ_SPU",GZ_SPU)
ParaTemp=ADD_Array(ParaTemp,"GZ_XQFQ",GZ_XQFQ)
ParaTemp=ADD_Array(ParaTemp,"GZ_GC",GZ_GC)
ParaTemp=ADD_Array(ParaTemp,"GZ_TP",GZ_TP)
ParaTemp=ADD_Array(ParaTemp,"GZ_ZT",GZ_ZT)
sHtml = API.Post(ParaTemp)
set API = nothing

response.Write sHtml		
%>