<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>发货单管理</title>
	<!--#include file="class/headconfig.asp"-->
	<style>
		.divz{ min-width:800px; position:fixed; top:10px; left:10px; right:10px; bottom:10px; }
		#fm { margin:0; padding:30px 30px 0px; }
		.fitem { margin-bottom:15px; }
		.fitem input { width:150px; }
		.fitem label { display:inline-block;width:80px;text-align:left;margin-left: 5px; }
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
					<span style="padding-left:20px;">发货单号:</span>
					<input id="mc" class="easyui-textbox" style="width:150px;">
					<span style="padding-left:10px;"><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="doSearch()" style="width:80px;">查询</a></span>
					<span style="padding-left:10px;"><a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="newadd()" style="width:100px;">创建发货单</a></span>
					<span style="padding-left:10px;"><a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="zxnewadd()" style="width:100px;">装箱</a></span>
					<span style="padding-left:10px;"><a href="#" class="easyui-linkbutton" iconCls="icon-reload" onclick="remove()" style="width:90px;">确认发货</a></span>
				</div>
			</div>
			<div id="dlg" class="easyui-dialog" style="width:350px; height:150px;" closed="true" modal="true" buttons="#dlg-buttons">
				<form id="fm" method="post" novalidate>
					<!--< div class="fitem">
						<label>收货方：</label>
						<input id="LX" class="easyui-combobox" editable="false">
					</div> -->
				</form>
			</div>
			<div id="dlg-buttons">
			    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="updata()">确认</a>
			    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close');$('#fm').form('clear')">取消</a>
			</div>
			<!-- 装箱提示框 -->
			<div id="zxdlg" class="easyui-dialog" style="width:350px;height:150px;" closed="true" modal="true" buttons="#zxdlg-buttons">
				<!-- 内容 -->
			</div>
			<div id="zxdlg-buttons">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="savetype()">确认</a>
				<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#zxdlg').dialog('close');">取消</a>
			</div>
			<!-- 装箱结束 -->
		</div>
		<div data-options="region:'south',border:false,split:false" style="height:70%;">
			<div id="tt" class="easyui-tabs" style="width:99.9%; height:100%;">
				<div title="发货单明细"><div id="fhdmx"></div></div>
			</div>
		</div>
	</div>
</div>
<!--divz结束-->
<script>
	$(document).ready(function(){ dg(); });

	var czlx;
	function dg() {
		$('#dg').datagrid({
			title:'发货单管理',
			width:'99.9%',
			height:'100%',
			url:'fhdgljm_json.asp',
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
				fhdmx();
  			},
			frozenColumns:[[
				{field:'创建时间',title:'制单时间',width:150,align:'center'},
				{field:'order_id',title:'发货单号',width:100,align:'center'},
				{field:'发货方名称',title:'发货方名称',width:200,align:'center'},
				{field:'接收方名称',title:'收货方名称',width:200,align:'center'},
				{field:'总箱数',title:'装箱数',width:200,align:'center'},
				{field:'发货时间',title:'发货时间',width:200,align:'center'},
				{field:'接收时间',title:'收货时间',width:200,align:'center'}
			]]
		});
	}

	function fhdmx() {
		$('#fhdmx').datagrid({
			width:'100%',
			height:'100%',
			fitColumns:'true',
			url:'fhdgljm_json.asp',
			queryParams:{ czlx:mx },
			toolbar:'#toolbarjs',
			singleSelect:'true',
			method:'post',
			rownumbers:'true',
			autoRowHeight:'true',
			pagination:'true',
			pageSize:20,
			pageNumber:1,
			pageList:[20,50,100],
			frozenColumns:[[
				{field:'aa',title:'箱号',width:150,align:'center'},
				{field:'aa',title:'商品条码',width:100,align:'center'},
				{field:'aa',title:'数量',width:200,align:'center'}
			]]
		});
	}

	//查找按钮事件
	function doSearch(){
		$('#dg').datagrid('load',{
			mc: $("#mc").textbox('getValue')
		});
	}

	//创建发货单
	function newadd(){
		$('#dlg').dialog('open').dialog('setTitle','创建发货单');
		$('#fm').form('clear');
		$('#czlx').val('add');
		czlx='add';
	}

	//装箱
	function zxnewadd(){
		$('#zxdlg').dialog('open').dialog('setTitle','装箱');
		$('#fm').form('clear');
		$('#czlx').val( 'edit' );
		czlx= 'edit'/*内容*/ ;
	}

	//确认发货按钮
	function remove(){
		var row = $('#dg').datagrid('getSelected');
		if (row) {
			$.messager.confirm('系统提示','确定发货？',function(r){
				if (r){
					$.post('fhdgljm_json.asp',{ /*内容*/ czlx:'add' },function(res){
						/*内容*/
					},'json');
				}
			});
		}else {
			tsshow('请选择要发货的记录！');
		}
	}

	//创建确认按钮
	function updata(){
		var g = $('#shf').combogrid('grid');	// 获取表格控件对象
		var r = g.datagrid('getSelected');	//获取表格当前选中行
		if (r) {
			var date=r.name;
			$.post('fhdgljm_json.asp',{ /*内容*/ },function(res){
				/*内容*/
				if(res.code!=1){ tsshow(res.msg) };
			},'json');
		} else {
			tsshow('请选择收件人！');
		}
	}

	//装箱确认
	function savetype()
	{
		// 确认的内容
	}

	function msgshow(lx,cod,msg)
	{
		switch(cod)
		{
			case 1:
				if(lx=='add'){ $('#dlg').dialog('close');  /*内容*/ };
				if(lx==''){ $('#zxdlg').dialog('close');  /*内容*/ };
				if(lx==''){ $('#dg').datagrid('reload');  /*内容*/ };
				break;
			default:
				tsshow(msg);
				break;				
		}
	}
</script>
</body>
</html>