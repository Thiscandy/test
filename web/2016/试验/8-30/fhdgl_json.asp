<% 
Session.Codepage=65001
Response.Charset="UTF-8"

CZLX=request("czlx")
GYSJKFW=request("gysjkfw")

if czlx="" then
	a="[{ ""gysjkfw"": ""dizhikufuwu"",""sm"":""tisdfaf"" },{ ""gysjkfw"":""dingdanjiekoufuwu"",""sm"":""dingdan"" }]"
end if

if czlx="mx" then
	if gysjkfw="dizhikufuwu" then
		a="[{""fwm"":""get_ADD"",""sm"":""xinzhen"" },{""fwm"":""get_EDIT"",""sm"":""xiugai""},{""fwm"":""get_DLE"",""sm"":""shanchu""}]"
	end if
	if gysjkfw="dingdanjiekoufuwu" then
		a="[{""fwm"":""get_ADD1"",""sm"":""xinzhen"" },{""fwm"":""get_EDIT1"",""sm"":""xiugai""},{""fwm"":""get_DLE1"",""sm"":""shanchu""}]"
	end if
end if

if czlx="czy" then
	if gysjkfw="dizhikufuwu" then
		a="[{""czsj"":""2016-8-30"",""czr"":""cs"",""czlx"":""ADD"",""bz"":""cs"" },{""czsj"":""2016-8-30"",""czr"":""cs"",""czlx"":""EDIT"",""bz"":""cs"" }]"
	end if
	if gysjkfw="dingdanjiekoufuwu" then
		a="[{""czsj"":""2016-8-30"",""czr"":""cs"",""czlx"":""ADD"",""bz"":""cs"" },{""czsj"":""2016-8-30"",""czr"":""cs"",""czlx"":""EDIT"",""bz"":""cs"" },{""czsj"":""2016-8-30"",""czr"":""cs"",""czlx"":""DEl"",""bz"":""cs"" }]"
	end if
end if

if czlx="apimx" then
	a="[{""csmc"":""id"",""bm"":""ID"",""lx"":""Integer"",""sfbx"":""1"",""slz"":""false"",""mrz"":""false"",""ms"":""分类ID""},{""csmc"":""appKey"",""bm"":""Key"",""lx"":""String"",""sfbx"":""1"",""slz"":""true"",""mrz"":""true"",""ms"":""yingyongKey""},{""csmc"":""code"",""bm"":""CODE"",""lx"":""String"",""sfbx"":""1"",""slz"":""true"",""mrz"":""true"",""ms"":""zhuangtai""},{""csmc"":""msg"",""bm"":""tishi"",""lx"":""String"",""sfbx"":""1"",""slz"":""true"",""mrz"":""true"",""ms"":""tishi""},{""csmc"":""ms"",""bm"":""miss"",""lx"":""String"",""sfbx"":""0"",""slz"":""true"",""mrz"":""true"",""ms"":""miaoshu""}]"
end if
'
'if czlx="hpzx" then
'	ParaTemp=ADD_Array(ParaTemp,"method","GetApp_ADD_fahuodan_box")
'	ParaTemp=ADD_Array(ParaTemp,"order_id",order_id)
'	ParaTemp=ADD_Array(ParaTemp,"items",items)
'end if
'
'if czlx="qrfh" then
'	ParaTemp=ADD_Array(ParaTemp,"method","GetApp_Set_fahuodan_ck")
'	ParaTemp=ADD_Array(ParaTemp,"order_id",order_id)
'end if
response.Write a
%>