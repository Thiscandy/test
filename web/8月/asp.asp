<!DOCTYPE html>
<html lang="en">
<head>
	<title>asp</title>
	<meta charset="utf-8">
	<link rel="stylesheet" type="text/css" href="css/index.css">
</head>
<body>
	<div class="header">
	<pre style="color:#060;">
		<%
		'↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

		'应用ID
		api_appkey=""


		'商户标识
		api_session=""

		'连接密钥
		api_secret=""

		'API服务器地址
		api_url=""
		   
		   
		'↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
		'
		'
		'使用方法
		'建立API对象
		'Set API = New Yiten_API
		'ParaTemp = Array()
		'ParaTemp=ADD_Array(ParaTemp,"method","yit_vip_add")
		'ParaTemp=ADD_Array(ParaTemp,"test","ok")
		'sHtml = API.Post(ParaTemp)
		'set API = nothing
		'response.Write sHtml
		'
		'
		'
		'       以下为过程代码，请勿修改！！！！！！！
		'
		'
		'
		'
		'
		'
		'把参数加入到数组里面
		 Function ADD_Array(sPara,itemName,itemValue)
		 '（指定数组，方法，值）
			nCount = ubound(sPara)
			Redim Preserve sPara(nCount+1)
			sPara(nCount+1) = itemName & "=" &itemValue
			ADD_Array = sPara
		end function


		'json包装
		Function json_str(acanshu,Adata)
			json_str=""""& acanshu&""":"""&adata&""""	
		end function
		 

		Class Yiten_API
		 
		%>
		<!--#include file="API_md5.asp"-->
		<%'把MD5文件引入到 Yiten_API 类里，防止和外界MD5函数冲突
		 
		 
		 
		' 对数组排序
		' param sPara 排序前的数组
		' return 排序后的数组
		Function SortPara(sPara)

			Dim nCount
			nCount = ubound(sPara)
			For i = nCount To 0 Step -1
				minmax = sPara( 0 )
		    	minmaxSlot = 0
		    	For j = 1 To i
		            mark = (sPara( j ) > minmax)
		        	If mark Then 
		            	minmax = sPara( j )
		            	minmaxSlot = j
		        	End If
		    	Next
				If minmaxSlot <> i Then 
					temp = sPara( minmaxSlot )
					sPara( minmaxSlot ) = sPara( i )
					sPara( i ) = temp
				End If
			Next
			SortPara = sPara
		end function

		''
		' 除去数组中的空值和签名参数
		' param sPara 签名参数组
		' return 去掉空值与签名参数后的新签名参数组
		Function FilterPara(sPara)
			Dim sParaFilter(),nCount,j
			nCount = ubound(sPara)
			j = 0
			For i = 0 To nCount
				'把sPara的数组里的元素格式：变量名=值，分割开来
				pos = Instr(sPara(i),"=")			'获得=字符的位置
				nLen = Len(sPara(i))				'获得字符串长度
				itemName = left(sPara(i),pos-1)	'获得变量名
				itemValue = right(sPara(i),nLen-pos)'获得变量的值
				
				If itemName <> "sign" And itemName <> "sign_type" and isnull(itemValue) = false Then' And itemValue <> ""
					Redim Preserve sParaFilter(j)
					sParaFilter(j) = sPara(i)
					j = j + 1
			End If
			Next
			
			FilterPara = sParaFilter
		End Function

		''
		' 获取当前时间
		' 格式：年[4位]-月[2位]-日[2位] 小时[2位 24小时制]:分[2位]:秒[2位]，如：2007-10-01 13:13:13
		' return 时间格式化结果
		Function GetDateTimeFormat()
			sTime=now()
			sResult	= year(sTime)&"-"&right("0" & month(sTime),2)&"-"&right("0" & day(sTime),2)&" "&right("0" & hour(sTime),2)&":"&right("0" & minute(sTime),2)&":"&right("0" & second(sTime),2)
			GetDateTimeFormat = sResult
		End Function


		 


		''
		' 把数组所有元素，按照"参数=参数值"的模式用"&"字符拼接成字符串，并且做urlencode编码
		' param sPara 需要拼接的数组
		' return 拼接完成以后的字符串
		function CreateLinkStringUrlEncode(sPara)
			nCount = ubound(sPara)
			dim prestr
			for i = 0 to nCount
				'把sPara的数组里的元素格式：变量名=值，分割开来
				pos = Instr(sPara(i),"=")			'获得=字符的位置
				nLen = Len(sPara(i))				'获得字符串长度
				itemName = left(sPara(i),pos-1)	'获得变量名
				itemValue = right(sPara(i),nLen-pos)'获得变量的值	
					
				If i = nCount Then
				prestr = prestr & itemName &"=" & server.URLEncode(itemValue) 
				Else
				prestr = prestr & itemName &"=" &  server.URLEncode(itemValue)  & "&"
				End if 	
				
			next
			
			CreateLinkStringUrlEncode = prestr
		end function

		''
		' 把数组所有元素，按照"参数+参数值"拼接成字符串
		' param sPara 需要拼接的数组
		' return 拼接完成以后的字符串
		Function CreateLinkstring(sPara)
		nCount = ubound(sPara)
			dim prestr
			for i = 0 to nCount
				'把sPara的数组里的元素格式：变量名=值，分割开来
				pos = Instr(sPara(i),"=")			'获得=字符的位置
				nLen = Len(sPara(i))				'获得字符串长度
				itemName = left(sPara(i),pos-1)	'获得变量名
				itemValue = right(sPara(i),nLen-pos)'获得变量的值			
			
				prestr = prestr & itemName & itemValue
			
			next
			
			CreateLinkstring = prestr
		End Function


		''
		' MD5签名
		' param prestr 需要签名的字符串
		' param key 私钥
		' param input_charset 编码格式
		' return 签名结果
		Function Md5Sign(prestr, key, input_charset)
			Dim mysign
			
			'把拼接后的字符串再与安全校验码直接连接起来
			prestr = key& prestr & key
			
			mysign = md5(prestr,input_charset)
		 
			Md5Sign = mysign
		End Function
		 

			''
			' 生成签名结果
			' param sParaSort 待签名的数组
			' return 签名结果字符串
			Private Function BuildRequestMysign(sParaSort)
					
				'把数组所有元素，按照"参数+参数值"的模式拼接成字符串
				prestr = CreateLinkstring(sParaSort)
				
				'获得签名结果
		 
				BuildRequestMysign = Md5Sign(prestr,api_secret,"UTF-8")
			
		 
			End Function
			


		 
		 	' 生成要请求给平台的参数数组
			' param sParaTemp 请求前的参数数组
			' return 要请求的参数数组 
		 Private Function BuildRequestPara(sParaTemp)
				Dim mysign
				'过滤签名参数数组
				sPara = FilterPara(sParaTemp)
				
				'对请求参数数组排序
				sParaSort = SortPara(sPara)
				
				'获得签名结果
				mysign = BuildRequestMysign(sParaSort)
				
				'签名结果与签名方式加入请求提交参数组中
				nCount = ubound(sParaSort)
				Redim Preserve sParaSort(nCount+1)
				sParaSort(nCount+1) = "sign="&mysign 	

				BuildRequestPara = sParaSort
			End Function
			

			''
			' 生成要请求给平台的参数数组字符串
			' param sParaTemp 请求前的参数数组
			' return 要请求的参数数组字符串
			Private Function BuildRequestParaToString(sParaTemp)
				Dim sRequestData		
			
				sParaTemp=ADD_Array(sParaTemp,"timestamp",GetDateTimeFormat)
				sParaTemp=ADD_Array(sParaTemp,"appkey",api_appkey)
				sParaTemp=ADD_Array(sParaTemp,"session",api_session)		

				'待签名请求参数数组
				sPara = BuildRequestPara(sParaTemp)
				'把参数组中所有元素，按照"参数=参数值"的模式用"&"字符拼接成字符串，并且对其做urlencode编码处理
				sRequestData = CreateLinkStringUrlEncode(sPara)
					
				BuildRequestParaToString = sRequestData
			End Function
			
			
			
			
		Function Post(Adata)


			dim Https 
			set Https=server.createobject("MSXML2.XMLHTTP")
			Https.open "POST",api_url,false
			Https.setRequestHeader "Content-Type","application/x-www-form-urlencoded"
			Https.send  BuildRequestParaToString(adata)'将数组转换成参数
			if Https.readystate=4 then
				dim objstream 
				set objstream = Server.CreateObject("adodb.stream")
				objstream.Type = 1
				objstream.Mode =3
				objstream.Open
				objstream.Write Https.responseBody
				objstream.Position = 0
				objstream.Type = 2
				objstream.Charset = "utf-8"
				Post = objstream.ReadText
				objstream.Close
				set objstream = nothing
				set https=nothing
			end if
		End Function


		 

		End Class

		%>
	</pre>
	</div>
</body>
</html>