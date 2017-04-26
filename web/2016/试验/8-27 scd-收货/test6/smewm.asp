<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="class/API.asp"-->
<!--#include file="class/config.asp"-->
<!DOCTYPE html>
<html>
<head>
	<title>仓库收货验收</title>
	<!--#include file="class/headconfig.asp"-->
	<style>
		body { margin: 0px;padding: 0px;background-color: #efefec; }
		.header { width: 100%; background-color: #fff; position: fixed; top:0; left:0; right:0; }
		.hd_h1 { color:#225fba; font-size:24px; text-align:left; font-weight:400; margin:0 15%;margin: 15px 25px; }

		.hd_xh { /*箱号字体样式*/ }

		.hd_input { margin: 0px 25px;margin-bottom: 20px; }
		.hd_input input { margin: 5px;padding: 0 10px;width:90%;height: 34px;color: #404040;background: white;border:1px solid;border-color: #c2dce5 #cbe8f2 #d6f5ff;border-radius: 2px;box-shadow: inset 0 1px 3px rgba(0,0,0,0.12); }
		.hd_input input:focus { border-color: #7dc9e2;outline-color: #dceefc;outline-offset: 0; }
		.main { margin-top: 165px;width: 100%;margin-bottom: 110px; }
		.main_table { width: 85%;margin: 0 auto;border:1px solid;background-color: #fff; }
		.main_left { float: left;width: 20%;text-align: center; }
		.main_right { float: right;width: 80%;text-align: left;overflow: hidden; }
		.main_hd { height: 50px;line-height: 50px;border-bottom: 1px solid; }
		.main_tb { height: 50px;line-height: 50px;border-bottom: 1px dashed #849E9E; }

		#img { /*图片样式*/  }

		.footer { width: 100%;background-color: #fff;position: fixed;bottom:0;left: 0;right: 0; }
		.ft_h1 { color: #225fba;font-size:24px; text-align:left; font-weight:400; margin:0 15%;margin: 25px; }

		.ft_h2 { /*总数字体样式*/ }

		.ft_btn { float: right;margin-right: 10px;width: 100px;height: 50px;background: white;border:1px solid;border-color: #c2dce5 #cbe8f2 #d6f5ff;border-radius: 2px;box-shadow: inset 0 1px 3px rgba(0,0,0,0.12); }
		input[type=submit] {
		  float: right;
		  width: 120px;
		  height: 40px;
		  font-size: 16px;
		  font-weight: bold;
		  color: #527881;
		  text-shadow: 0 1px #e3f1f1;
		  background: #cde5ef;
		  border: 1px solid;
		  border-color: #b4ccce #b3c0c8 #9eb9c2;
		  border-radius: 16px;
		  outline: 0;
		  -webkit-box-sizing: content-box;
		  -moz-box-sizing: content-box;
		  box-sizing: content-box;
		  background-image: -webkit-linear-gradient(top, #edf5f8, #cde5ef);
		  background-image: -moz-linear-gradient(top, #edf5f8, #cde5ef);
		  background-image: -o-linear-gradient(top, #edf5f8, #cde5ef);
		  background-image: linear-gradient(to bottom, #edf5f8, #cde5ef);
		  -webkit-box-shadow: inset 0 1px white, 0 1px 2px rgba(0, 0, 0, 0.15);
		  box-shadow: inset 0 1px white, 0 1px 2px rgba(0, 0, 0, 0.15);
		}
		input[type=submit]:active {
		  background: #cde5ef;
		  border-color: #9eb9c2 #b3c0c8 #b4ccce;
		  -webkit-box-shadow: inset 0 0 3px rgba(0, 0, 0, 0.2);
		  box-shadow: inset 0 0 3px rgba(0, 0, 0, 0.2);
		}
	</style>
</head>
<%
box_no=request("box_no")
if box_no="" then
response.Redirect("smxh.asp")
response.End()
end if

Set API = New Yiten_API
ParaTemp = Array()
ParaTemp=ADD_Array(ParaTemp,"method","GetApp_Get_fahuodan_box_mx")
ParaTemp=ADD_Array(ParaTemp,"order_id",order_id)
ParaTemp=ADD_Array(ParaTemp,"box_no",box_no)
sHtml = API.Post(ParaTemp)
set API = nothing

set obj=parseJSON(sHtml)
%>
<body>
	<div class="header">
		<div class="hd_h1">箱号：<span id="hd_h2"></span></div>
		<div class="hd_input">
			<input id="inperm" name="inperm" type="text" placeholder="请扫描货品二维码" onChange="inpcha()">
		</div>
	</div>
	<div class="main">
		<div class="main_table">
			<div class="main_hd">
				<div class="main_left">状态</div>
				<div class="main_right">二维码</div>
			</div>
<%
if obj.total<>"0" then
	for i=0 to UBound(Split(obj.rows,","))
	tm=obj.rows.get(i).tm
%>			
			<div class="main_tb">
				<div class="main_left"><img id="img<%=i%>"></div>
				<div id="ewm<%=i%>" name="ewms" class="main_right"><%=tm%></div>
			</div>
<% 
	next
end if
set obj=nothing
%>
			<div style="clear:both;"></div>
		</div>
	</div>
	<div class="footer">
		<div class="ft_h1">
			总收货: 
			<span id="hd_h2"></span>
			<input id="btntj" type="submit" onClick="" value="确 认 收 货">
		</div>
	</div>

<script>
	document.getElementById('inperm').focus();

function inpcha()
{
	var inperm=$('#inperm').val();
	var ewms=$("div[name='ewms']");
	for(i=0;i<ewms.length;i++)
	{
		if(ewms[i].innerHTML==inperm)
		{
			var src = $("#img"+i).attr("src");
			if (src=='images/ok.png') {
				alert("已确认！");
			}
			else{
				$('#img'+i).attr('src','images/ok.png');
			}
			num++;
			break;
		}
	}
	if (num==0) 
	{
		alert("二维码错误！");
	}
}
</script>
</body>
</html>