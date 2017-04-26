<!DOCTYPE HTML>
<html>
<head>
	<title>API接口</title>
	<!--#include file="class/headconfig.asp"-->
	<style>
		.divz{ min-width:800px; position:fixed; top:10px; left:10px; right:10px; bottom:10px; }
		#fm { margin:0; padding:30px 30px 0px; }
		.fitem { margin-bottom:10px; }
		.fitem label { display:inline-block;width:50px;text-align:left;margin-left: 5px; }
		.qrfh_left { float: left;width: 180px;margin-top: 45px;margin-left: 35px; }
		.qrfh_right { margin-top: 30px;font-family: 微软雅黑; }
		.qrfh_item { font-size: 18px; }
		.qrfh_biem { font-size: 30px;color: red;margin: 10px 0; }
		.left { margin-left: 10px; }
		.left_api { margin-left: 10px;width: 70px; }
		.iemt { width: 135px;margin-left: 5px; }
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
					<span class="left"><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="doSearch()" style="width:80px;">查询</a></span>
					<span class="left"><a href="#" class="easyui-linkbutton" iconCls="icon-reload" onclick="reload()" style="width:80px;">刷新</a></span>
				</div>
			</div>
		</div>
		<div data-options="region:'south',border:false,split:false" style="height:50%;">
			<div id="tt" class="easyui-tabs" style="width:100%; height:100%;">
				<div title="API接口"><div id="dgmx"></div></div>
				<!-- <div title="装箱列表"><div id="dgzx"></div></div> -->
				<div title="操作日志"><div id="czrz"></div></div>
			</div>
		</div>
	</div>
</div>
<!--divz结束-->

<!-- 接口明细框 -->
<div id="dlg" class="easyui-dialog" style="width:880px; height:550px;" closed="true" modal="true" buttons="#dlg-buttons">
	<div id="apimx"></div>
	<div id="toolbar_api">
		<div style="margin:10px;">
			<span>API接口：</span>
			<input id="api_mc" class="easyui-textbox" style="width:150px;">
			<a href="#" class="easyui-linkbutton left_api" iconCls="icon-search" onclick="reload_api()">查询</a>
			<a href="#" class="easyui-linkbutton left_api" iconCls="icon-reload" onclick="reload_api()">刷新</a>
			<a href="#" class="easyui-linkbutton left_api" iconCls="icon-add" onclick="addjk()">增加</a>
		</div>
	</div>
</div>
<div id="dlg-buttons">
	<!-- <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="savetype()">确认</a> -->
	<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close');$('#apimx').datagrid('reload');">取消</a>
</div>
<!-- 接口明细结束 -->

<!-- 增加提示框 -->
<div id="dlg_zj" class="easyui-dialog" style="width:720px;height:450px;" closed="true" modal="true" buttons="#dlg-buttons_zj">
	<form id="fm" style="height:60px;background-color:#f4f4f4;padding:10px;border-bottom: 1px solid #ddd;">
		<div class="fitem">
			<label>参数名：</label>
			<input id="t_csmc" class="easyui-textbox" style="width:100px;">
			<label>类型：</label>
			<input id="t_lx" class="easyui-textbox" style="width:100px;">
			<label>别名：</label>
			<input id="t_bm" class="easyui-textbox" style="width:130px;">
			<label>必填：</label>
			<select class="easyui-combobox" name="state" style="width:80px;">
				<option value="1">是</option>
				<option value="0">否</option>
			</select>
		</div>
		<div class="fitem">
			<label>示例值：</label>
			<input id="t_slz" class="easyui-textbox" style="width:100px;">
			<label>默认值：</label>
			<input id="t_mrz" class="easyui-textbox" style="width:100px;">
			<label>描述：</label>
			<input id="t_ms" class="easyui-textbox" style="width:130px;">
			<a href="#" class="easyui-linkbutton iemt" iconCls="icon-add" onclick="">增加到提交表</a>
		</div>
	</form>
	<div style="background-color:#e2efd9;height:30px;border-bottom:1px dashed #a8d08d;">
		<span style="width:110px;height:30px;line-height:30px; display:inline-block; text-align: center;">参数名</span>
		<span style="width:110px;height:30px;line-height:30px; display:inline-block; text-align: center;">类型</span>
		<span style="width:110px;height:30px;line-height:30px; display:inline-block; text-align: center;">示例值</span>
		<span style="width:110px;height:30px;line-height:30px; display:inline-block; text-align: center;">默认值</span>
		<span style="width:150px;height:30px;line-height:30px; display:inline-block; text-align: center;">描述</span>
		<span style="width: 80px;height:30px;line-height:30px; display:inline-block; text-align: center;">删除</span>
	</div>
	<div style="background-color:#fff;height:30px;border-bottom:1px dashed #a8d08d;"></div>
</div>
<div id="dlg-buttons_zj">
	<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="savetype_fh()">提交</a>
	<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg_zj').dialog('close');$('#fm').form('clear');">取消</a>
</div>
<!-- 增加结束 -->

<!-- 装箱打印框 -->
<!-- <div id="dlg_dy" class="easyui-dialog" style="width:650px; height:310px;" closed="true" modal="true" buttons="#dlg-buttons_dy">
	<div class="qrfh_left">
		<div style="background-image: url(images/dy.png);background-repeat: no-repeat;width:150px;height:150px;"></div>
	</div>
	<div class="qrfh_right">
		<p class="qrfh_item">打印装箱清单</p>
		<p id="xh" class="qrfh_biem"></p>
		<p id="ddh" class="qrfh_biem"></p>
		<p class="qrfh_item">请确认是否打印？</p>
	</div>
</div>
<div id="dlg-buttons_dy">
	<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="savetype_dy()">确认打印</a>
	<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg_dy').dialog('close');">取消</a>
</div> -->
<!-- 打印框结束 -->

<!-- 打印相关 -->
<!-- <div style="display:none;"><iframe id="dowif" name="dowif"></iframe></div> -->
<!-- 让表单提交到本页面 -->
<!-- <div style="display:none;">
	<form id="form_pr" action="http://127.0.0.1:18" target="dowif" method="post">
		<input name="cmd" value="print">
		<input id="print_type" name="print_type" value="4">
		<input name="print_id" value="单据打印:结算单">
		<input id="SQL_1" name="SQL_1">
		<input id="SQL_2" name="SQL_2">
		<input id="SQL_3" name="SQL_3">
		<input id="SQL_4" name="SQL_4">
	</form>
</div> -->
<!-- 打印相关结束 -->

<script>
	$(document).ready(function(){ dg(); dgmx(); dgzx();czrz();apimx();   });

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
				dgmx(row.gysjkfw);
				dgzx(row.gysjkfw);
				czrz(row.gysjkfw)
				$('#dgmx').datagrid('loadData',{total:0,rows:[]});
				$('#dgzx').datagrid('loadData',{total:0,rows:[]});
  			},
			frozenColumns:[[
				{field:'gysjkfw',title:'供应商服务',width:300,align:'center'},
				{field:'sm',title:'说明',width:400,align:'center'}
			]]
		});
	}

	function dgmx(pmc) 
	{
		if(pmc)
		{
			$('#dgmx').datagrid({ url:'fhdgl_json.asp',queryParams:{ czlx:'mx',gysjkfw:pmc } });
		}
		else
		{
			$('#dgmx').datagrid({
				width:'100%',
				height:'100%',
				url:'fhdgl_json.asp',
				queryParams:{ czlx:'mx' },
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
					$('#dlg').dialog('open').dialog('setTitle','API接口明细');
				},
				frozenColumns:[[
					{field:'fwm',title:'接口',width:300,align:'center'},
					{field:'sm',title:'说明',width:400,align:'center'}
				]]
			});
		}
	}
	
	function dgzx(pmc) 
	{
		if(pmc)
		{
			$('#dgzx').datagrid({ url:'fhdgl_json.asp',queryParams:{ czlx:'zx',order_id:pmc } });
		}
		else
		{
			$('#dgzx').datagrid({
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
					{field:'order_id',title:'发货单号',width:100,align:'center'},
					{field:'box_no',title:'箱号',width:200,align:'center'},
					{field:'数量',title:'数量',width:200,align:'center'}
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
		// if (pmc) {
		// 	$('#apimx').datagrid({  });
		// }
		// else
		// {
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
		// }
	}

	//查找按钮事件
	function doSearch()
	{
		$('#dg').datagrid('load',{
			mc: $("#mc").textbox('getValue')
		});
		$('#dgmx').datagrid('loadData',{total:0,rows:[]});
		$('#dgzx').datagrid('loadData',{total:0,rows:[]});
	}

	function reload()
	{
		$('#dg').datagrid('reload');
		$('#dgmx').datagrid('loadData',{total:0,rows:[]});
		$('#dgzx').datagrid('loadData',{total:0,rows:[]});
	}
	
	function reload_api()
	{
		$('#apimx').datagrid('reload');
	}

	function addjk()
	{
		$('#dlg_zj').dialog('open').dialog('setTitle','增加参数');
	}

	//创建发货单
	function cjfhd()
	{
		$('#dlg').dialog('open').dialog('setTitle','创建发货单');
		$('#fm').form('clear');
	}

	//装箱
	function hpzx()
	{
		var row=$('#dg').datagrid('getSelected');
		if (row) {
			if(row.发货状态=='未发货')
			{
				openDlg('装箱扫描  发货单号:'+row.order_id);
			}
			else 
			{
				tsshow('此货单号已发货，不能再次选择！');
			}
		}
		else
		{
			tsshow('请选择发货单！');
		}
	}

	//确认发货
	function qrfh()
	{
		var row = $('#dg').datagrid('getSelected');
		if (row) {
			if (row.发货状态=='未发货') 
			{
				$('#dlg_fh').dialog('open').dialog('setTitle','确认发货');
				$('#zxs').html('装箱数：'+row.总箱数+' 箱');
				$('#spzs').html('商品总数：'+row.总数量);
			}
			else 
			{
				tsshow('已发货单号不能再次选择发货！');
			}
		}
		else
		{
			tsshow('请选择发货单！');
		}
	}
	
	//打印函数
	function dlgdyk()
	{
		var row = $('#dg').datagrid('getSelected');
		var box_no=$('#hidbox_no').val();
		$('#dlg_dy').dialog('open').dialog('setTitle','打印');
		$('#xh').html('箱号：'+box_no);
		$('#ddh').html('订单号：'+row.order_id);
	}
	
	//创建发货单确认按钮
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
	}
</script>
</body>
</html>