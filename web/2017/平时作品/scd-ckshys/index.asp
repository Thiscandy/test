<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE HTML>
<html>
<head>
<title>仓库收货验收</title>
<!--#include file="class/headconfig.asp"-->
<style>
.main{ height:80px; font-size:30px; }
</style>
</head>

<body>

<!--顶部header-->
<div class="hd">
    <h1 class="page_title">仓库收货验收</h1>
</div>
<!--顶部header结束-->

<!--主体-->
<div class="weui_cells weui_cells_access">
	<div class="weui_cell main" onclick="doLink('xh.asp')">
		<div class="weui_cell_bd weui_cell_primary">
			<p>开始验收</p>
		</div>
		<div class="weui_cell_ft">
		</div>
	</div>
</div>
<!--主体结束-->

<script>
<% 
fh=request("fh")
if fh="cjkh" then
%>
	layer.msg('新建客户成功');
<%
end if
if fh="cjqp" then
%>
	layer.msg('新建气瓶成功');
<%
end if
if fh="xgqp" then
%>
	layer.msg('修改气瓶成功');
<%
end if
if fh="kcpdxjqp" then
session("hidtm")=session("hidtm")+","+session("zhtm")
%>
	layer.msg('新建气瓶成功');
<%
end if
if fh="kcpd" then
session("hidtm")=""
session("zhtm")=""
%>
	layer.msg('库存盘点提交成功');
<% end if %>
</script>
</body>
</html>