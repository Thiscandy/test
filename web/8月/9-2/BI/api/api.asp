<!DOCTYPE HTML>
<html>
<head>
	<title>API接口</title>
	<!--#include file="class/headconfig.asp"-->
	<style>
		.divz{ min-width:800px; position:fixed; top:10px; left:10px; right:10px; bottom:10px; }
		#fm { margin:0; padding:30px 30px 0px; }
		.fitem { margin-bottom:15px; }
		.fitem input { width:200px; }
		.fitem label { display:inline-block;width:80px;text-align:left;margin-left: 5px; }
		.left { margin-left: 10px; }
		.left_api { margin-left: 10px;width: 70px; }
	</style>	
</head>
<body>
<!--divz-->
<div class="divz">
	<input type="hidden" id="hidbox_no">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center',border:false">
			<div id="dg"></div>
			<div id="toolbar">
				<div style="margin:10px;">
					<span>供应商服务:</span>
					<input id="mc" class="easyui-textbox" style="width:150px;">
					<span class="left"><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="doSearch_gys()" style="width:80px;">查询</a></span>
					<span class="left"><a href="#" class="easyui-linkbutton" iconCls="icon-reload" onclick="reload_gys()" style="width:80px;">刷新</a></span>
					<span class="left"><a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="zj_gys()" style="width:80px;">增加</a></span>
				</div>
			</div>
		</div>
		<div data-options="region:'south',border:false,split:false" style="height:50%;">
			<div id="tt" class="easyui-tabs" style="width:100%; height:100%;">
				<div title="API接口">
				<div id="dg_api"></div>
					<div id="toolbar_api_api">
						<div style="margin:10px;">
							<span>API接口：</span>
							<input id="mc_api" class="easyui-textbox" style="width:150px;">
							<a href="#" class="easyui-linkbutton left_api" iconCls="icon-search" onclick="doSearch_apijk()">查询</a>
							<a href="#" class="easyui-linkbutton left_api" iconCls="icon-reload" onclick="reload_apijk()">刷新</a>
							<a href="#" class="easyui-linkbutton left_api" iconCls="icon-add" onclick="zj_apijk()">增加</a>
						</div>
					</div>
				</div>
				<div title="操作日志"><div id="czrz"></div></div>
			</div>
		</div>
	</div>
</div>
<!--divz结束-->

<!-- 供应商增加框 -->
<div id="dlg_gys" class="easyui-dialog" style="width:320px; height:180px;" closed="true" modal="true" buttons="#dlg-buttons_gys">
	<form id="fm" method="post" novalidate>
		<div class="fitem">
			<label>供应商服务：</label>
			<input id="gys" class="easyui-textbox" required="true" style="width:150px;">
		</div>
		<div class="fitem">
			<label>说明：</label>
			<input id="gys_sm" class="easyui-textbox" style="width:150px;">
		</div>
	</form>
</div>
<div id="dlg-buttons_gys">
	<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="">确认</a>
	<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg_gys').dialog('close');">取消</a>
</div>
<!-- 结束 -->

<!-- API接口增加框 -->
<div id="dlg_apijk" class="easyui-dialog" style="width:320px; height:180px;" closed="true" modal="true" buttons="#dlg-buttons_apijk">
	<form id="fm" method="post" novalidate>
		<div class="fitem">
			<label>接口：</label>
			<input id="gys" class="easyui-textbox" required="true" style="width:150px;">
		</div>
		<div class="fitem">
			<label>说明：</label>
			<input id="gys_sm" class="easyui-textbox" style="width:150px;">
		</div>
	</form>
</div>
<div id="dlg-buttons_apijk">
	<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="">确认</a>
	<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg_apijk').dialog('close');">取消</a>
</div>
<!-- 结束 -->

<!-- 接口明细框 -->
<div id="dlg_apimx" class="easyui-dialog" style="width:880px; height:550px;" closed="true" modal="true" buttons="#dlg-buttons_apimx">
	<div id="apimx"></div>
	<div id="toolbar_api">
		<div style="margin:10px;">
			<span>参数名：</span>
			<input id="mc_apimx" class="easyui-textbox" style="width:150px;">
			<a href="#" class="easyui-linkbutton left_api" iconCls="icon-search" onclick="doSearch_apimx()">查询</a>
			<a href="#" class="easyui-linkbutton left_api" iconCls="icon-reload" onclick="reload_apimx()">刷新</a>
			<a href="#" class="easyui-linkbutton left_api" iconCls="icon-add" onclick="zj_addmx()">增加</a>
		</div>
	</div>
</div>
<div id="dlg-buttons_apimx">
	<!-- <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="savetype()">确认</a> -->
	<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg_apimx').dialog('close');$('#apimx').datagrid('reload');">取消</a>
</div>
<!-- 接口明细结束 -->

<script>
	$(document).ready(function(){ dg(); dg_api(); czrz(); apimx(); });

	var czlx;
	function dg() 
	{
		$('#dg').datagrid({
			title:'接口服务',
			width:'100%',
			height:'100%',
			url:'fhdgl_json.asp',
			toolbar:'#toolbar',
			singleSelect:'true',
			method:'post',
			rownumbers:'true',
			autoRowHeight:'true',
			pagination:'true',
			pageSize:5,
			pageNumber:1,
			pageList:[5,10,15],
			onClickRow:function(){
				var row=$('#dg').datagrid('getSelected');
				dg_api(row.gysjkfw);
				czrz(row.gysjkfw);
				$('#dg_api').datagrid('loadData',{total:0,rows:[]});
  			},
			frozenColumns:[[
				{field:'gysjkfw',title:'供应商服务',width:300,align:'center'},
				{field:'sm',title:'说明',width:400,align:'center'}
			]]
		});
	}

	function dg_api(pmc) 
	{
		if(pmc)
		{
			$('#dg_api').datagrid({ url:'fhdgl_json.asp',queryParams:{ czlx:'mx',gysjkfw:pmc } });
		}
		else
		{
			$('#dg_api').datagrid({
				width:'100%',
				height:'100%',
				url:'fhdgl_json.asp',
				queryParams:{ czlx:'mx' },
				toolbar:'#toolbar_api_api',
				//fitColumns:'true',
				singleSelect:'true',
				method:'post',
				rownumbers:'true',
				autoRowHeight:'true',
				pagination:'true',
				pageSize:20,
				pageNumber:1,
				pageList:[20,50,100],
				onClickRow:function(){
					// $('#dlg_apimx').dialog('open').dialog('setTitle','API接口明细');
					window.parent.addTab('API接口明细', 'api/apimx.asp');
				},
				frozenColumns:[[
					{field:'fwm',title:'接口',width:300,align:'center'},
					{field:'sm',title:'说明',width:400,align:'center'}
				]]
			});
		}
	}

	function czrz(pmc)
	{
		if (pmc) {
			$('#czrz').datagrid({ url:'fhdgl_json.asp',queryParams:{ czlx:'czy',gysjkfw:pmc } });
		}
		else
		{
			$('#czrz').datagrid({
				width:'100%',
				height:'100%',
				//fitColumns:'true',
				singleSelect:'true',
				method:'post',
				rownumbers:'true',
				autoRowHeight:'true',
				pagination:'true',
				pageSize:20,
				pageNumber:1,
				pageList:[20,50,100],
				frozenColumns:[[
					{field:'czsj',title:'操作时间',width:150,align:'center'},
					{field:'czr',title:'操作人',width:100,align:'center'},
					{field:'czlx',title:'操作类型',width:150,align:'center'},
					{field:'bz',title:'备注',width:200,align:'center'}
				]]
			});
		}
	}

	function apimx()
	{
		$('#apimx').datagrid({
			width:'100%',
			height:'100%',
			url:'fhdgl_json.asp',
			queryParams:{ czlx:'apimx' },
			//fitColumns:'true',
			toolbar:'#toolbar_api',
			singleSelect:'true',
			method:'post',
			rownumbers:'true',
			autoRowHeight:'true',
			pagination:'true',
			pageSize:20,
			pageNumber:1,
			pageList:[20,50,100],
			columns:[[
				{field:'csmc',title:'参数名',width:110,align:'center'},
				{field:'bm',title:'别名',width:100,align:'center'},
				{field:'lx',title:'类型',width:110,align:'center'},
				{field:'sfbx',title:'必填',width:53,align:'center'},
				{field:'slz',title:'示例值',width:100,align:'center'},
				{field:'mrz',title:'默认值',width:100,align:'center'},
				{field:'ms',title:'描述',width:260,align:'left'}
			]]
		});
	}

	var editIndex = undefined;
	function endEditing(){
		if (editIndex == undefined){return true}
		if ($('#dg_tb').datagrid('validateRow', editIndex)){
			$('#dg_tb').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRow(index){
		if (editIndex != index){
			if (endEditing()){
				$('#dg_tb').datagrid('selectRow', index)
						.datagrid('beginEdit', index);
				editIndex = index;
			} else {
				$('#dg_tb').datagrid('selectRow', editIndex);
			}
		}
	}
	function append(){
		if (endEditing()){
			$('#dg_tb').datagrid('appendRow',{status:'P'});
			editIndex = $('#dg_tb').datagrid('getRows').length-1;
			$('#dg_tb').datagrid('selectRow', editIndex)
					.datagrid('beginEdit', editIndex);
		}
	}
	function removeit(){
		if (editIndex == undefined){return}
		$('#dg_tb').datagrid('cancelEdit', editIndex)
				.datagrid('deleteRow', editIndex);
		editIndex = undefined;
	}
	function accept(){
		if (endEditing()){
			$('#dg_tb').datagrid('acceptChanges');
		}
	}
	function reject(){
		$('#dg_tb').datagrid('rejectChanges');
		editIndex = undefined;
	}
	function getChanges(){
		var rows = $('#dg_tb').datagrid('getChanges');
		alert(rows.length+' rows are changed!');
	}

	//查找按钮事件
	function doSearch_gys()
	{
		$('#dg').datagrid('load',{
			mc: $('#mc').textbox('getValue')
		});
		$('#dg_api').datagrid('loadData',{total:0,rows:[]});
		$('#czrz').datagrid('loadData',{total:0,rows:[]});
	}

	function doSearch_apijk()
	{
		$('#dg_api').datagrid('load',{
			mc:$('#mc_api').textbox('getValue'),
			czlx:'mx'
		});
	}

	function doSearch_apimx()
	{
		$('#apimx').datagrid('load',{
			mc:$('#mc_apimx').textbox('getValue'),
			czlx:'apimx'
		});
	}

	//刷新按钮
	function reload_gys()
	{
		$('#dg').datagrid('reload');
		$('#dg_api').datagrid('loadData',{total:0,rows:[]});
		$('#czrz').datagrid('loadData',{total:0,rows:[]});
	}

	function reload_apijk()
	{
		var row = $('#dg').datagrid('getSelected');
		if (row)
		{
			$('#dg_api').datagrid('reload');
		}
		else
		{
			tsshow('请先选择供应商服务！');
		}
	}

	function reload_apimx()
	{
		$('#apimx').datagrid('reload');
	}

	//增加按钮	
	function zj_gys()
	{
		$('#dlg_gys').dialog('open').dialog('setTitle','增加供应商服务');
	}
	
	function zj_apijk()
	{
		$('#dlg_apijk').dialog('open').dialog('setTitle','API接口增加');
	}

	function zj_addmx()
	{
		$('#dlg_addmx').dialog('open').dialog('setTitle','增加参数');
	}

/*	//创建发货单确认按钮
	function savetype()
	{
		var state=$('#state').combobox('getValue');
		var row = $('#dg').datagrid('getSelected');
		$.post('fhdgl_json.asp',{ fhlx:'厂家发货',czlx:'cjfhd',shf_code:state },function(res){
			msgshow('cjfhd',res.code,res.msg);
		},'json');
	}
	
	//装箱确认按钮
	function savetype_tm()
	{
		var items=$('#hidtms').val();
		if(items)
		{
			$.messager.confirm('系统提示','确定提交装箱？提交后不可更改',function(r){
				if (r){
					var row=$('#dg').datagrid('getSelected');
						$.post('fhdgl_json.asp',{ order_id:row.order_id,items:items,czlx:'hpzx' },function(res){
							$('#hidbox_no').val(res.box_no);
							msgshow('hpzx',res.code,res.msg);
						},'json');
				}
			});
		}
		else
		{
			tsshow('没有货品，不能装箱','系统提示')
		}
	}
	
	//确认发货确认按钮
	function savetype_fh()
	{
		var row=$('#dg').datagrid('getSelected');
		$.post('fhdgl_json.asp',{ order_id:row.order_id,czlx:'qrfh' },function(res){
			msgshow('qrfh',res.code,res.msg);
			if(res.code==1){ $('#dlg_fh').dialog('close');reload(); };
			tsshow(res.msg);
		},'json');
	}
	
	//打印确认按钮
	function savetype_dy()
	{
		$('#dlg_dy').dialog('close');
		var djid;
		$('#SQL_1').val("SELECT * FROM dbo.客户寄存表 WHERE  单据ID='"+djid+"'");
		$('#SQL_2').val("SELECT * FROM dbo.客户消费单 WHERE  单据ID='"+djid+"'");
		$('#SQL_3').val("SELECT * FROM dbo.客户消费单明细 WHERE  LEFT(业务类型, 1) = '收' AND 单据ID='"+djid+"'");
		$('#SQL_4').val("SELECT * FROM dbo.客户消费单明细 WHERE  LEFT(业务类型, 1) = '取' AND 单据ID='"+djid+"'");
		$('#form_pr').submit();
	}
	
	function msgshow(lx,code,msg)
	{
		switch(code)
		{
			case 1:
				if(lx=='cjfhd'){ $('#dlg').dialog('close');reload(); };
				if(lx=='hpzx'){ $('#dlg_tm').dialog('close');dlgdyk();reload(); };
				break;
			default:
				tsshow(msg);
				break;				
		}
	}*/
</script>
</body>
</html>