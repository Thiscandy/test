<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>一级类别售卖周期设置</title>
	<!--#include file="class/headconfig.asp"-->
	<style>
		.display { display:inline-block; width:80px; }
		#fm { margin:0; padding:20px 30px 0px; }
		.fitem { margin-bottom:15px; }
		.fitem input { width:120px; }
		.fitem label { display:inline-block;width:70px;text-align:left;margin-left: 5px; }
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
			<div id="dlg" class="easyui-dialog" style="width:705px; height:250px;" closed="true" modal="true" buttons="#dlg-buttons">
				<form id="fm" method="post" novalidate>
					<div class="fitem">
						<label>SPU类型：</label>
						<input id="SPU_Type" class="easyui-textbox">
					</div>
					<div class="fitem">
						<label>低值占比：</label>
				        <input id="L_Percent" class="easyui-textbox" required="true">
				        <label>售卖周数：</label>
				        <input id="Min_SoldWeeks" class="easyui-textbox" required="true">
				        <label>开始日期：</label>
				        <input id="B_Date" class="easyui-datebox" required="true" editable="false">
					</div>
					<div class="fitem">
				        <label>均值占比：</label>
				        <input id="E_Percent" class="easyui-textbox" required="true">
				        <label>中断周数：</label>
				        <input id="Min_BreakWeeks" class="easyui-textbox" required="true">
				        <label>结束日期：</label>
						<input id="E_Date" class="easyui-datebox" required="true" editable="false">
				    </div>
				    <div class="fitem">
				    	<label>高值占比：</label>
				        <input id="H_Percent" class="easyui-textbox" required="true">
				        <label>分析汇总：</label>
				        <select id="IS_Analysis" class="easyui-combobox" style="width:122px;">
				        	<option value="1">是</option>
				        	<option value="0">否</option>
				        </select>
				        <label>备注：</label>
				        <input id="SoldCydeSeting_BZ" class="easyui-textbox">
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
			title:'一级类别售卖周期设置',
			width:'100%',
			height:'100%',
			url:'yjlbsmzqsz_json_get.asp',
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
				{field:'SPU_Type',title:'SPU类型',width:100,align:'center'},
				{field:'B_Date',title:'开始日期',width:150,align:'center'},
				{field:'E_Date',title:'结束日期',width:150,align:'center'},
				{field:'SC_E_Value',title:'SPU搜索均值',width:200,align:'center'},
				{field:'L_Percent',title:'低值占比',width:100,align:'center'},
				{field:'E_Percent',title:'均值占比',width:100,align:'center'},
				{field:'H_Percent',title:'高值占比',width:100,align:'center'},
				{field:'Min_SoldWeeks',title:'最小售卖周数',width:100,align:'center'},
				{field:'Min_BreakWeeks',title:'最小中断周数',width:100,align:'center'},
				{field:'IS_Analysis',title:'是否分析汇总',width:100,align:'center'},
				{field:'SoldCydeSeting_BZ',title:'备注',width:100,align:'center'}
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
			$('#SPU_Type').textbox('readonly',true);
			$('#SPU_Type').textbox('setValue',row.SPU_Type);
			$('#B_Date').datebox('setValue',row.B_Date);
			$('#E_Date').datebox('setValue',row.E_Date);
			$('#L_Percent').textbox('setValue',row.L_Percent);
			$('#E_Percent').textbox('setValue',row.E_Percent);
			$('#H_Percent').textbox('setValue',row.H_Percent);
			$('#Min_SoldWeeks').textbox('setValue',row.Min_SoldWeeks);
			$('#Min_BreakWeeks').textbox('setValue',row.Min_BreakWeeks);
			$('#IS_Analysis').combobox('setValue',row.IS_Analysis);
			$('#SoldCydeSeting_BZ').textbox('setValue',row.SoldCydeSeting_BZ);
		}else {
			tsshow('请选择一条数据！');
		}
	}

	//提交按钮
	function updata(){
		var Type=$('#SPU_Type').textbox('getValue');
		var B_D=$('#B_Date').datebox('getValue');
		var E_D=$('#E_Date').datebox('getValue');
		var L_Per=$('#L_Percent').textbox('getValue');
		var E_Per=$('#E_Percent').textbox('getValue');
		var H_Per=$('#H_Percent').textbox('getValue');
		var SoldWeeks=$('#Min_SoldWeeks').textbox('getValue');
		var BreakWeeks=$('#Min_BreakWeeks').textbox('getValue');
		var Analysis=$('#IS_Analysis').combobox('getValue');
		var BZ=$('#SoldCydeSeting_BZ').textbox('getValue');
		if (Type&&B_D&&E_D&&L_Per&&E_Per&&H_Per&&SoldWeeks&&BreakWeeks&&Analysis) {
			$.post('yjlbsmzqsz_json_edit.asp',{ 
				SPU_Type:Type,
				B_Date:B_D,
				E_Date:E_D,
				B_Date:B_D,
				L_Percent:L_Per,
				E_Percent:E_Per,
				H_Percent:H_Per,
				Min_SoldWeeks:SoldWeeks,
				Min_BreakWeeks:BreakWeeks,
				IS_Analysis:Analysis,
				SoldCydeSeting_BZ:BZ
				},function(res){
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