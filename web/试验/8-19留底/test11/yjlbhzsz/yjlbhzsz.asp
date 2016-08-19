<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>一级类别汇总设置</title>
	<!--#include file="class/headconfig.asp"-->
	<style>
		.display { display:inline-block; width:80px; }
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
					<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="javascript:$('#dg').datagrid('reload');" >刷新</a>
				</div>
				<div style="padding:0px 10px 10px;">
					<span>查找条件：</span>
					<input id="mc" class="easyui-textbox">
					<span style="margin-left:10px;"><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="doSearch()">查找</a></span>
				</div>
				</div>
			</div>
			<!--dlg-->
			<div id="dlg" class="easyui-dialog" style="width:345px; height:225px;" closed="true" modal="true" buttons="#dlg-buttons">
				<form id="fm" method="post" novalidate>
					<div class="fitem">
						<label>SPU类型：</label>
						<input id="Type" class="easyui-textbox input">
					</div>
					<div class="fitem">
				        <label>汇总主体：</label>
				        <input id="MB" class="easyui-textbox input">
				    </div>
				    <div class="fitem">
						<label>是否分析汇总：</label>
						<select id="Analysis" class="easyui-combobox input">
				        	<option value="1">是</option>
				        	<option value="0">否</option>
				        </select>
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
			title:'一级类别汇总设置',
			width:'100%',
			height:'100%',
			url:'yjlbhzsz_json_get.asp',
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
				{field:'SPU_Type',title:'SPU类型',width:200,align:'center'},
				{field:'Pool_MB',title:'汇总主体',width:100,align:'center'},
				{field:'IS_Analysis',title:'是否分析汇总',width:200,align:'center'}
			]]
		});
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
			$('#Type').textbox('readonly',true);
			$('#Type').textbox('setValue',row.SPU_Type);
			$('#Analysis').combobox('setValue',row.IS_Analysis);
		}else {
			tsshow('请选择一条数据！');
		}
	}

	//提交按钮
	function updata(){
		var MB=$('#MB').textbox('getValue');
		var Type=$('#Type').textbox('getValue');
		var Analysis=$('#Analysis').combobox('getValue');
		if (MB&&Type&&Analysis) {
			$.post('yjlbhzsz_json_edit.asp',{ SPU_Type:Type,Pool_MB:MB,IS_Analysis:Analysis },function(res){
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