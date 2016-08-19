<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>利润关键点</title>
	<!--#include file="class/headconfig.asp"-->
	<style>
		#fm { margin:0; padding:30px 30px 0px; }
		.fitem { margin-bottom:15px; }
		.fitem input { width:150px; }
		.fitem label { display:inline-block;width:100px;text-align:left;margin-left: 5px; }
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
					<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="edit()">修改</a>
					<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="rows()" >刷新</a>
				</div>
				<div style="padding:0px 10px 10px;">
					<span>查找条件：</span>
					<input id="mc" class="easyui-textbox">
					<span style="margin-left:10px;"><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="doSearch()">查找</a></span>
					
				</div>
				</div>
			</div>
			<!--dlg-->
			<div id="dlg" class="easyui-dialog" style="width:340px; height:340px;" closed="true" modal="true" buttons="#dlg-buttons">
				<form id="fm" method="post" novalidate>
					<div class="fitem">
						<label>汇总主体：</label>
						<input id="MB" class="easyui-textbox input">
					</div>
					<div class="fitem">
				        <label>材质分类：</label>
				        <input id="Tpye" class="easyui-textbox input">
				    </div>
				    <div class="fitem">
						<label>无利润分割点：</label>
						<input id="zero" class="easyui-textbox input">
					</div>
					<div class="fitem">
				        <label>低利润分割点：</label>
				        <input id="light" class="easyui-textbox input" required="true">
				    </div>
				    <div class="fitem">
				        <label>高利润分割点：</label>
				        <input id="heavy" class="easyui-textbox input" required="true">
				    </div>
				    <div class="fitem">
				        <label>备注：</label>
				        <input id="BZ" class="easyui-textbox input">
				    </div>
				</form>
			</div>
			<div id="dlg-buttons">
			    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="updata()">提交</a>
			    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close');$('#fm').form('clear')">取消</a>
			</div>
			<!--dlg结束-->
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
			url:'lrgjd_json_get.asp',
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
				{field:'Material_Tpye',title:'材质分类',width:100,align:'center'},
				{field:'PR_0',title:'无利润分割点',width:200,align:'center'},
				{field:'PR_light',title:'低利润分割点',width:200,align:'center'},
				{field:'PR_heavy',title:'高利润分割点',width:200,align:'center'},
				{field:'Profit_BZ',title:'备注',width:150,align:'center'}
			]]
		});
	}

	function rows(){
		var rowsl= 0 ;
		$('#dg').datagrid({ url:'lrgjd_json_get.asp',queryParams:{ rows:rowsl } });
	}

	//查找按钮事件
	function doSearch(){
		$('#dg').datagrid('load',{
			mc: $("#mc").textbox('getValue')
		});
	}

	//修改按钮
	function edit(){
		var row = $('#dg').datagrid('getSelected');
		if (row) {
			$('#dlg').dialog('open').dialog('setTitle','修改');
			$('#MB').textbox('readonly',true);
			$('#MB').textbox('setValue',row.Pool_MB);
			$('#Tpye').textbox('readonly',true);
			$('#Tpye').textbox('setValue',row.Material_Tpye);
			$('#zero').textbox('setValue',row.PR_0);
			$('#light').textbox('setValue',row.PR_light);
			$('#heavy').textbox('setValue',row.PR_heavy);
			$('#BZ').textbox('setValue',row.Profit_BZ);
		}else {
			tsshow('请选择一条数据！');
		}
	}

	//提交按钮
	function updata(){
		var MB=$('#MB').textbox('getValue');
		var Tpye=$('#Tpye').textbox('getValue');
		var zero=$('#zero').textbox('getValue');
		var light=$('#light').textbox('getValue');
		var heavy=$('#heavy').textbox('getValue');
		var BZ=$('#BZ').textbox('getValue');
		if (zero&&light&&heavy) {
			$.post('lrgjd_json_edit.asp',{ Pool_MB:MB,Material_Tpye:Tpye,PR_0:zero,PR_light:light,PR_heavy:heavy,Profit_BZ:BZ },function(res){
				$('#fm').form('clear');
				$('#dlg').dialog('close');
				$('#dg').datagrid('reload');
				if(res.code!=1){ tsshow(res.msg) };
			},'json');
		} else {
			tsshow('请按提示正确输入！');
		}
	}
</script>
</body>
</html>