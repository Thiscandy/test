<!--#include file="class/API.asp"-->
<% 
Session.Codepage=65001


GZ_XQFQ=request("GZ_XQFQ")
GZ_GC=request("GZ_GC")
GZ_TP=request("GZ_TP")
GZ_SPU=request("GZ_SPU")
GZ_ZT=request("GZ_ZT")
GZ_FQSJ=request("GZ_FQSJ")
GZ_KTXK=request("GZ_KTXK")
GZ_DYXK=request("GZ_DYXK")
GZ_YPSFXG=request("GZ_YPSFXG")
GZ_PZYDYV=request("GZ_PZYDYV")
GZ_QRXD=request("GZ_QRXD")
GZ_XD=request("GZ_XD")
GZ_TGSPXX=request("GZ_TGSPXX")
GZ_PBZT=request("GZ_PBZT")
GZ_WPSH=request("GZ_WPSH")
GZ_TMSH=request("GZ_TMSH")
GZ_DHTZSJ=request("GZ_DHTZSJ")
GZ_TMSJ=request("GZ_TMSJ")
GZ_WPSJ=request("GZ_WPSJ")
GZ_FG=request("GZ_FG")
GZ_SXZT=request("GZ_SXZT")
GZ_SFFD=request("GZ_SFFD")
GZ_BZ=request("GZ_BZ")

'切换页数的四个值
find_info=request("mc")
page_no=request("page")
page_size=request("rows")
rsort=request("sort")
order=request("order")

'建立API对象
Set API = New Yiten_API
ParaTemp = Array()
ParaTemp=ADD_Array(ParaTemp,"method","SPUGZ_XPGZ_GET")

ParaTemp=ADD_Array(ParaTemp,"GZ_XQFQ",GZ_XQFQ)
ParaTemp=ADD_Array(ParaTemp,"GZ_GC",GZ_GC)
ParaTemp=ADD_Array(ParaTemp,"GZ_TP",GZ_TP)
ParaTemp=ADD_Array(ParaTemp,"GZ_SPU",GZ_SPU)
ParaTemp=ADD_Array(ParaTemp,"GZ_ZT",GZ_ZT)
ParaTemp=ADD_Array(ParaTemp,"GZ_FQSJ",GZ_FQSJ)
ParaTemp=ADD_Array(ParaTemp,"GZ_KTXK",GZ_KTXK)
ParaTemp=ADD_Array(ParaTemp,"GZ_DYXK",GZ_DYXK)
ParaTemp=ADD_Array(ParaTemp,"GZ_YPSFXG",GZ_YPSFXG)
ParaTemp=ADD_Array(ParaTemp,"GZ_PZYDYV",GZ_PZYDYV)
ParaTemp=ADD_Array(ParaTemp,"GZ_QRXD",GZ_QRXD)
ParaTemp=ADD_Array(ParaTemp,"GZ_XD",GZ_XD)
ParaTemp=ADD_Array(ParaTemp,"GZ_TGSPXX",GZ_TGSPXX)
ParaTemp=ADD_Array(ParaTemp,"GZ_PBZT",GZ_PBZT)
ParaTemp=ADD_Array(ParaTemp,"GZ_WPSH",GZ_WPSH)
ParaTemp=ADD_Array(ParaTemp,"GZ_TMSH",GZ_TMSH)
ParaTemp=ADD_Array(ParaTemp,"GZ_DHTZSJ",GZ_DHTZSJ)
ParaTemp=ADD_Array(ParaTemp,"GZ_TMSJ",GZ_TMSJ)
ParaTemp=ADD_Array(ParaTemp,"GZ_WPSJ",GZ_WPSJ)
ParaTemp=ADD_Array(ParaTemp,"GZ_FG",GZ_FG)
ParaTemp=ADD_Array(ParaTemp,"GZ_SXZT",GZ_SXZT)
ParaTemp=ADD_Array(ParaTemp,"GZ_SFFD",GZ_SFFD)
ParaTemp=ADD_Array(ParaTemp,"GZ_BZ",GZ_BZ)
ParaTemp=ADD_Array(ParaTemp,"find_info",find_info)
ParaTemp=ADD_Array(ParaTemp,"page_no",page_no)
ParaTemp=ADD_Array(ParaTemp,"page_size",page_size)
ParaTemp=ADD_Array(ParaTemp,"sort",rsort)
ParaTemp=ADD_Array(ParaTemp,"order",order)
sHtml = API.Post(ParaTemp)
set API = nothing

response.Write sHtml		
%>