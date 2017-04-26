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
    <h1 class="page_title" onClick="doLink('index.asp')">扫描箱号</h1>
</div>
<!--顶部header结束-->

<!--主体-->
<div class="weui_cells weui_cells_form">
	<div class="weui_cell">
		<div class="weui_cell_hd"><label class="weui_label">箱号：</label></div>
		<div class="weui_cell_bd weui_cell_primary">
			<input id="srk" name="srk" class="weui_input cz_inp" type="text" placeholder="请扫描箱号" onChange="subform()">
		</div>
	</div>
</div>
<!--主体结束-->

<script>
	document.getElementById("srk").focus();
function subform()
{
	var srk=$('#srk').val();
	if(srk)
	{
		$.post('smxh_json.asp',{ srk:srk },function(res){ 
			if(res.code=='1'){ window.location.href='smewm.asp?box_no='+srk; }else{ layer.msg(res.msg); }; 
		},'json');
	}
}
</script>
</body>
</html>