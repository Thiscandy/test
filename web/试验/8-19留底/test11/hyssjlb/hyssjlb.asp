<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>行业收索记录表</title>
	<!--#include file="class/headconfig.asp"-->
	<style>
		.display { display:inline-block; width:80px; }
		#fm { margin:0; padding:30px 30px 0px; }
		.fitem { margin-bottom:15px; }
		.fitem input { width:150px; }
		.fitem label { display:inline-block;width:80px;text-align:left;margin-left: 5px; }
		.item { width: 130px; }
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
					<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newadd()">新增</a>
					<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="edit()">修改</a>
					<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="rows()">刷新</a>
				</div>
				<div style="padding:0px 10px 10px;">
					<span>日期：</span>
					<input id="mc" class="easyui-datebox item" editable="false">
					<span>至</span>
					<input id="sc" class="easyui-datebox item" editable="false">
					<span style="margin-left:10px;"><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="doSearch()">查找</a></span>
					<span>一级列别查找：</span>
					<input id="bc" class="easyui-combobox item" editable="false">
				</div>
			</div>
			<!--dlg-->
			<div id="dlg" class="easyui-dialog" style="width:320px; height:220px;" closed="true" modal="true" buttons="#dlg-buttons">
				<form id="fm" method="post" novalidate>
					<div class="fitem">
						<label style="display:inline-block; width:80px;">日期:</label>
						<input id="Date" class="easyui-datebox" required="true">
					</div>
					<div class="fitem">
				        <label class="display">一级类别:</label>
				        <input id="Type" class="easyui-combobox" required="true">
				    </div>
				    <div class="fitem">
						<label style="display:inline-block; width:80px;">搜索量:</label>
						<input id="Value" class="easyui-textbox" required="true">
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
			title:'行业收索记录表',
			width:'99.9%',
			height:'100%',
			url:'hyssjlb_json_get.asp',
			toolbar:'#toolbar',
			singleSelect:'true',
			method:'post',
			rownumbers:'true',
			autoRowHeight:'true',
			pagination:'true',
			pageSize:50,
			pageNumber:1,
			pageList:[50,100,150],
			frozenColumns:[[
				{field:'Refer_Date',title:'日期',width:200,align:'center'},
				{field:'SPU_Type',title:'一级类别',width:200,align:'center'},
				{field:'A_Value',title:'搜索量',width:100,align:'center'}
			]]
		});
	}

	function rows(){
		var rowsl= 0 ;
		$('#dg').datagrid({ url:'hyssjlb_json_get.asp',queryParams:{ rows:rowsl } });
	}

	//查找按钮事件
	function doSearch(){
		var mcc = $("#mc").datebox('getValue');
		var scc = $('#sc').datebox('getValue');
		$('#dg').datagrid({ url:'hyssjlb_json_get.asp',queryParams:{ mc:mcc,sc:scc } });
	}

	//新增按钮
	var url;
	function newadd(){
		$('#dlg').dialog('open').dialog('setTitle','新增');
		$('#Date').textbox('readonly',false);
		$('#Type').textbox('readonly',false);
		$('#fm').form('clear');
		url = 'hyssjlb_json_add.asp';
		//指定url
	}

	//修改按钮
	function edit(){
		var row = $('#dg').datagrid('getSelected');
		if (row) {
			$('#dlg').dialog('open').dialog('setTitle','修改');
			$('#Date').textbox('readonly',true);
			$('#Date').textbox('setValue',row.Refer_Date);
			$('#Type').textbox('readonly',true);
			$('#Type').textbox('setValue',row.SPU_Type);
			$('#Value').textbox('setValue',row.A_Value);
			url = 'hyssjlb_json_edit.asp';
		}else {
			tsshow('请选择一条数据！');
		}
	}

	//提交按钮
	function updata(){
		var date=$('#Date').textbox('getValue');
		var type=$('#Type').textbox('getValue');
		var value=$('#Value').textbox('getValue');
		if (date&&type&&value) {
			$.post(url,{ Date:date,Type:type,Value:value },function(res){
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