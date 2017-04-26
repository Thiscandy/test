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
		.qrfh_left { float: left;width: 180px;margin-top: 45px;margin-left: 35px; }
		.qrfh_right { margin-top: 30px;font-family: 微软雅黑; }
		.qrfh_item { font-size: 18px; }
		.qrfh_biem { font-size: 30px;color: red;margin: 10px 0; }
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
					<span>发货单号:</span>
					<input id="mc" class="easyui-textbox" style="width:150px;">
					<span style="padding-left:10px;"><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="doSearch()" style="width:80px;">查询</a></span>
					<span style="padding-left:10px;"><a href="#" class="easyui-linkbutton" iconCls="icon-reload" onclick="reload()" style="width:80px;">刷新</a></span>
					<span style="padding-left:40px;"><a href="#" class="easyui-linkbutton" onclick="cjfhd()" style="width:100px;">创建发货单</a></span>
					<span style="padding-left:10px;"><a href="#" class="easyui-linkbutton" onclick="hpzx()" style="width:100px;">装箱</a></span>
					<span style="padding-left:10px;"><a href="#" class="easyui-linkbutton" onclick="qrfh()" style="width:90px;">确认发货</a></span>
					<span style="padding-left:10px;"><a href="#" class="easyui-linkbutton" onclick="dlgdyk()" style="width:90px;">打印</a></span>
				</div>
			</div>
		</div>
		<div data-options="region:'south',border:false,split:false" style="height:70%;">
			<div id="tt" class="easyui-tabs" style="width:99.9%; height:100%;">
				<div title="发货单明细"><div id="dgmx"></div></div>
				<div title="装箱列表"><div id="dgzx"></div></div>
				<!--<div title="发货单明细"><div id="fhdmx"></div></div>-->
			</div>
		</div>
	</div>
</div>
<!--divz结束-->

<!-- 创建发货单提示框 -->
<div id="dlg" class="easyui-dialog" style="width:325px; height:150px;" closed="true" modal="true" buttons="#dlg-buttons">
	<form id="fm" method="post" novalidate>
		<div class="fitem">
			<label>收货方：</label>
			<select id="state" class="easyui-combobox" name="state" style="width:150px;">
				<option value="000">品检仓</option>
				<option value="999">湃沃中央仓</option>
			</select>
		</div>
	</form>
</div>
<div id="dlg-buttons">
	<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="savetype()">确认</a>
	<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close');$('#fm').form('clear')">取消</a>
</div>
<!-- 提示框结束 -->

<!-- 确认发货提示框 -->
<div id="dlg_fh" class="easyui-dialog" style="width:550px;height:310px;" closed="true" modal="true" buttons="#dlg-buttons_fh">
	<input id="O_ID" type="hidden" value="0">
	<div class="qrfh_left">
		<div style="background-image: url(images/sigh2.png);background-repeat: no-repeat;width:150px;height:150px;"></div>
	</div>
	<div class="qrfh_right">
		<p class="qrfh_item">请确认本批次是否已全部装箱完毕！</p>
		<p id="zxs" class="qrfh_biem"></p>
		<p id="spzs" class="qrfh_biem"></p>
		<p class="qrfh_item">请确认是否发货！</p>
	</div>
</div>
<div id="dlg-buttons_fh">
	<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="savetype_fh()">确认发货</a>
	<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg_fh').dialog('close');">取消</a>
</div>
<!-- 确认结束 -->

<!-- 装箱打印框 -->
<div id="dlg_dy" class="easyui-dialog" style="width:550px;height:310px;" closed="true" modal="true" buttons="#dlg-buttons_dy">
	<div class="qrfh_left">
		<div style="background-image: url(images/dy.png);background-repeat: no-repeat;width:150px;height:150px;"></div>
	</div>
	<div class="qrfh_right">
		<p class="qrfh_item">请确认本批次是否已全部装箱完毕！</p>
		<p id="xh" class="qrfh_biem"></p>
		<p id="ddh" class="qrfh_biem"></p>
		<p class="qrfh_item">请确认是否打印？</p>
	</div>
</div>
<div id="dlg-buttons_dy">
	<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="savetype_fh()">确认打印</a>
	<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg_dy').dialog('close');">取消</a>
</div>
<!-- 打印框结束 -->
<!--#include file="dlgtm.asp"-->

<script>
	$(document).ready(function(){ dg(); dgmx(); });

	//打印函数
	function dlgdyk()
	{
		var row = $('#dg').datagrid('getSelected');
		$('#dlg_dy').dialog('open').dialog('setTitle','打印');
		$('#xh').html('箱号：'+row.箱号);
		$('#ddh').html('订单号：'+row.订单号);
	}

	var czlx;
	function dg() 
	{
		$('#dg').datagrid({
			title:'发货单管理',
			width:'99.9%',
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
				dgmx(row.order_id);
				dgzx(row.order_id);
	 		},
			frozenColumns:[[
				//{field:'ZT',title:'ZT',width:150,align:'center'},
				{field:'创建时间',title:'制单时间',width:150,align:'center'},
				{field:'order_id',title:'发货单号',width:100,align:'center'},
				{field:'发货方名称',title:'发货方名称',width:200,align:'center'},
				{field:'接收方名称',title:'收货方名称',width:200,align:'center'},
				{field:'总箱数',title:'装箱数',width:200,align:'center'},
				{field:'总数量',title:'装箱数量',width:200,align:'center'},
				{field:'发货时间',title:'发货时间',width:200,align:'center'},
				{field:'发货状态',title:'发货状态',width:200,align:'center'},
				{field:'接收时间',title:'收货时间',width:200,align:'center'}
			]]
		});
	}

	function dgmx(pmc) 
	{
		if(pmc)
		{
			$('#dgmx').datagrid({ url:'fhdgl_json.asp',queryParams:{ czlx:'mx',order_id:pmc } });
		}
		else
		{
			$('#dgmx').datagrid({
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
					{field:'箱号',title:'箱号',width:100,align:'center'},
					{field:'二维码',title:'条码',width:200,align:'center'},
					{field:'条码',title:'数量',width:200,align:'center'}
				]]
			});
		}
	}
	
	function dgzx(pmc) 
	{
		$('#dgzx').datagrid({
			width:'100%',
			height:'100%',
			//fitColumns:'true',
			url:'fhdgl_json.asp',
			queryParams:{ czlx:'zx',order_id:pmc },
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
	function doSearch()
	{
		$('#dg').datagrid('load',{
			mc: $("#mc").textbox('getValue')
		});
	}

	function reload()
	{
		$('#dg').datagrid('reload');
		$('#dgmx').datagrid('loadData',{total:0,rows:[]});
		$('#dgzx').datagrid('loadData',{total:0,rows:[]});
		
	}
	
	//创建发货单
	function cjfhd()
	{
		$('#dlg').dialog('open').dialog('setTitle','创建发货单');
		$('#fm').form('clear');
		$('#czlx').val('add');
		czlx='cjfhd';
	}

	//装箱
	function hpzx()
	{
		var row=$('#dg').datagrid('getSelected');
		if(row)
		{
			openDlg('装箱扫描  发货单号:'+row.order_id);
		}
	}

	//确认发货
	function qrfh()
	{
		var row = $('#dg').datagrid('getSelected');
		if (row) 
		{
			$('#dlg_fh').dialog('open').dialog('setTitle','确认发货');
			$('#zxs').html('装箱数：'+row.总箱数+' 箱');
			$('#spzs').html('商品总数：'+row.总数量);
			$('#O_ID').val(row.order_id);
		}
		else 
		{
			tsshow('请选择要发货的记录！');
		}
	}

	//创建发货单确认按钮
	function savetype()
	{
		var state=$('#state').combobox('getValue');
		var row = $('#dg').datagrid('getSelected');
		$.post('fhdgl_json.asp',{ fhlx:'厂家发货',czlx:'cjfhd',shf_code:state },function(res){
			if(res.code!=1){ tsshow(res.msg) };
		},'json');
	}
	
	//装箱确认按钮
	function savetype_tm()
	{
		$.messager.confirm('系统提示','确定提交装箱？提交后不可更改',function(r){
			if (r){
				var row=$('#dg').datagrid('getSelected');
				var items=$('#hidtms').val();
				$.post('fhdgl_json.asp',{ order_id:row.order_id,items:items,czlx:'hpzx' },function(res){ msgshow('hpzx',res.code,res.msg); },'json');
			}
		});
	}
	
	//确认发货确认按钮
	function savetype_fh()
	{
		var O_ID=$('O_ID').val();
		$.post('fhdgl_json.asp',{ order_id:O_ID,czlx:'qrfh' },function(res){
			msgshow('qrfh',res.code,res.msg);
		},'json');
	}

	function msgshow(lx,code,msg)
	{
		switch(code)
		{
			case 1:
				if(lx=='add'){ $('#dlg').dialog('close'); };
				if(lx=='hpzx'){ $('#dlg_tm').dialog('close');reload(); };
				if(lx=='qrfh'){ $('#dlg_fh').dialog('close');reload(); };
				break;
			default:
				tsshow(msg);
				break;				
		}
	}
</script>
</body>
</html>