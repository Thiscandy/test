<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>利润关键点</title>
	<!--#include file="class/headconfig.asp"-->
	<style>
		.display { display:inline-block; width:80px; }
		#fm { margin:0; padding:30px 30px 0px; }
		.fitem { margin-bottom:15px; }
		.fitem input { width:150px; }
		.fitem label { display:inline-block;width:80px;text-align:left;margin-left: 5px; }
		.input { width: 150px; }
	</style>
</head>
<body>
<!--divz-->
<div class="divz">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center',border:false">
			<div id="dg"></div>
			<div id="toolbar"> 
				<div style="margin:10px;">
					<span style="padding-left:10px;">
						<span>查找条件：</span>
						<input id="mc" class="easyui-textbox">
						<span style="margin-left:10px;"><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="doSearch()">查找</a></span>
					</span>
				</div>
			</div>
		</div>
	</div>
</div>
<!--divz结束-->
<script>
	$(document).ready(function(){ dg(); });

	function dg() {
		$('#dg').datagrid({
			title:'利润关键点',
			width:'99.9%',
			height:'100%',
			url:'xszbgjd_json_get.asp',
			toolbar:'#toolbar',
			singleSelect:'true',
			method:'post',
			rownumbers:'true',
			autoRowHeight:'true',
			pagination:'true',
			pageSize:20,
			pageNumber:1,
			pageList:[20,50,100],
			frozenColumns:[[
				{field:'Pool_MB',title:'汇总主体',width:200,align:'center'},
				{field:'SPU_Type',title:'SPU类别',width:100,align:'center'},
				{field:'Material_Tpye',title:'材质分类',width:200,align:'center'},
				{field:'E_ALL',title:'所有日均平均值',width:200,align:'center'},
				{field:'E_HIGH',title:'高于E_MALL的日均平均值',width:200,align:'center'},
				{field:'E_LESS',title:'低于E_MALL的日均平均值',width:150,align:'center'},
				{field:'SalePercent_BZ',title:'备注',width:150,align:'center'}
			]]
		});
	}

	//查找按钮事件
	function doSearch(){
		$('#dg').datagrid('load',{
			mc: $("#mc").textbox('getValue')
		});
	}
</script>
</body>
</html>