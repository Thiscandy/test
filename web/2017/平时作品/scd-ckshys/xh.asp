<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE HTML>
<html>
<head>
<title>仓库收货验收</title>
<!--#include file="class/headconfig.asp"-->
</head>

<body>

<!--顶部header-->
<div class="hd">
	<span class="top_le" onClick="doLink('index.asp')"><</span>
    <h1 class="page_title" onClick="doLink('index.asp')">箱号</h1>
</div>
<!--顶部header结束-->

<!--主体-->
<form id="form1" name="form1" action="ys.asp">

<div class="weui_cells weui_cells_form">
	<div class="weui_cell">
		<div class="weui_cell_hd"><label class="weui_label">箱号：</label></div>
		<div class="weui_cell_bd weui_cell_primary">
			<input id="srk" name="srk" class="weui_input cz_inp" type="text" placeholder="请输入箱号" onChange="subform()">
		</div>
	</div>
</div>

</form>
<!--主体结束-->

<script>
	document.getElementById("srk").focus();
<% if request("fh")="bcz" then %>
	layer.msg('查无该客户');
<% end if %>
</script>
</body>
</html>