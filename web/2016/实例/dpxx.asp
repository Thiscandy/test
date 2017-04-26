<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>店铺信息</title>
	<!--#include file="class/headconfig.asp"-->
	<style>
		.divl { width:280px;height:100%;margin-top:20px;margin-left:20px; }
		.divl_padding { width:220px;height:94.4%;padding:10px;border:1px solid #95b8e7;overflow:hidden;overflow-y:auto; }
		.adddel { font-size:20px; }
		.adddel > a { margin:10px; }
		.button { width:50px;margin-left:10px; }
		.div2 { margin-top: 20px; }
		#fm { margin:0; padding:30px 30px 0px; }
		.fitem { margin-bottom:15px; }
		.fitem input { width:150px; }
		.fitem label { display:inline-block;width:80px;text-align:left;margin-left: 5px; }
	</style>
</head>
<body class="easyui-layout">
<!-- 左侧 -->
    <div data-options="region:'west',border:false" class="divl">
    	<div class="divl_padding">
        	<ul id="tree_ys"></ul>
        </div>
    </div>
<!-- 结束 -->
<!-- 主体 -->
<div data-options="region:'center',border:false" class="div2">
	<div id="dg"></div>
	<div id="toolbar"> 
		<div style="margin:10px;">
			<div style="margin:5px">
			    <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newadd()">新增</a>
			    <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="edit()">修改</a>
			    <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="remove()">删除</a>
			    <a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="javascript:$('#dg').datagrid('reload');">刷新</a>
			</div>
			<span style="padding-left:10px;">
				<span>查找条件:</span>
				<input id="mc" class="easyui-textbox">
				<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="doSearch()">查找</a>
				<a href="#" class="easyui-linkbutton button" onclick="qiyong()">启用</a>
				<a href="#" class="easyui-linkbutton button" onclick="jingyong()">禁用</a>
			</span>
		</div>
	</div>
	<!--dlg-->
	<div id="dlg" class="easyui-dialog" style="width:320px;height:300px;" closed="true" modal="true" buttons="#dlg-buttons">
		<form id="fm" method="post" novalidate>
			<div class="fitem">
				<label>店铺代码：</label>
				<input id="ID" class="easyui-textbox" data-options="prompt:'不填则自动递增'">
			</div>
			<div class="fitem">
				<label>店铺名称：</label>
				<input id="MC" class="easyui-textbox" required="true">
			</div>
			<div class="fitem">
				<label>店铺别名：</label>
				<input id="ByName" class="easyui-textbox" required="true">
			</div>
			<div class="fitem">
				<label>店铺类型：</label>
				<input id="LX" class="easyui-combobox" required="true" editable="false">
			</div>
			<div class="fitem">
				<label>店铺备注：</label>
				<input id="BZ" class="easyui-textbox">
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
	    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="updata()">提交</a>
	    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close');$('#fm').form('clear')">取消</a>
	</div>
	<!--dlg结束-->
</div>
<!--divz结束-->
<script>
	$(document).ready(function(){ gettree();getbox();initTree();dg();rows() });

	//定义树
	function treeys(sj)
	{
		$('#tree_ys').tree({
			animate:'true',
			//当展开或折叠节点时定义动画效果
			lines:'true',
			//有线
			data:sj  
		});
	}

	//读取树的数据
	function gettree(js)
	{
		$.post('dpxx_json_tree_get.asp',function(result){
			treeys(result.商铺信息);
		},'json');
	}

	//点击树的事件
	function initTree(){
		$('#tree_ys').tree({
			onClick: function(node){
				var id=node.id;
				$('#dg').datagrid({ url:'dpxx_json_get.asp',queryParams:{ shop_id:id } });
			}
		});
	}

	function dg() {
		$('#dg').datagrid({
			title:'店铺信息',
			width:'99.9%',
			height:'97.999%',
			toolbar:'#toolbar',
			singleSelect:'true',
			method:'post',
			rownumbers:'true',
			autoRowHeight:'true',
			pagination:'true',
			pageSize:30,
			pageNumber:1,
			pageList:[30,50,100],
			frozenColumns:[[
				{field:'Shop_ID',title:'店铺代码',width:200,align:'center'}, 
				{field:'Shop_MC',title:'店铺名称',width:200,align:'center'},
				{field:'Shop_ByName',title:'店铺别名',width:200,align:'center'},
				{field:'Shop_LX_NAME',title:'店铺类型',width:100,align:'center'},
				{field:'Shop_BZ',title:'店铺备注',width:100,align:'center'},
				{field:'Shop_ZT_NAME',title:'店铺状态',width:150,align:'center'}
			]]
		});
	}

	function rows(){
		var rowsl= 0 ;
		$('#dg').datagrid({ url:'dpxx_json_get.asp',queryParams:{ rows:rowsl } });
	}

	//查找按钮事件
	function doSearch(){
		var mcc = $("#mc").textbox('getValue');
		$('#dg').datagrid({ url:'dpxx_json_get.asp',queryParams:{ mc:mcc } });
	}

	//新增按钮
	var url;
	function newadd(){
		$('#dlg').dialog('open').dialog('setTitle','新增');
		//打开dig对话窗口，标题为新增角色信息
		$('#fm').form('clear')
		url = 'dpxx_json_add.asp';
		//指定url
	}

	//修改按钮
	function edit(){
		var row = $('#dg').datagrid('getSelected');
		if (row) {
			$('#dlg').dialog('open').dialog('setTitle','修改');
			$('#ID').textbox('readonly',true);
			$('#ID').textbox('setValue',row.Shop_ID);
			$('#MC').textbox('setValue',row.Shop_MC);
			$('#ByName').textbox('setValue',row.Shop_ByName);
			$('#LX').combobox('setValue',row.Shop_LX);
			$('#BZ').textbox('setValue',row.Shop_BZ);
			url = 'dpxx_json_edit.asp';
		}else {
			tsshow('请选择一条数据！');
		}
	}
	fun

	//删除按钮
	function remove(){
		var row = $('#dg').datagrid('getSelected');
		if (row) {
			$.messager.confirm('系统提示','确定删除该角色信息？',function(r){
			//信息提示确认信息
				if (r){
					$.post('dpxx_json_del.asp',{Shop_ID:row.Shop_ID},function(res){
						$('#dg').datagrid('reload');
					},'json');
				//如果是r（确定）提交删除地址url，指定选中行的id，结果提示信息，传输方法为json
				}
			});
		}else {
			tsshow('请选择一条数据！');
		}
	}

	//启用按钮
	function qiyong(){
		var row = $('#dg').datagrid('getSelected');
		if (row) {
			$.messager.confirm('系统提示','确定启用这条信息？',function(r){
			//信息提示确认信息
				if (r){
					$.post('dpxx_json_enable.asp',{Shop_ID:row.Shop_ID},function(res){
						$('#dg').datagrid('reload');
						if(res.code!=1){ tsshow(res.msg) };
					},'json');
				//如果是r（确定）提交删除地址url，指定选中行的id，结果提示信息，传输方法为json
				}
			});
		}else {
			tsshow('请选择一条数据！');
		}
	}

	//禁用按钮
	function jingyong() {
		var row = $('#dg').datagrid('getSelected');
		if (row) {
			$.messager.confirm('系统提示','确定禁用这条信息？',function(r){
			//信息提示确认信息
				if (r){
					$.post('dpxx_json_unenable.asp',{Shop_ID:row.Shop_ID},function(res){
						$('#dg').datagrid('reload');
						if(res.code!=1){ tsshow(res.msg) };
					},'json');
				//如果是r（确定）提交删除地址url，指定选中行的id，结果提示信息，传输方法为json
				}
			});
		}else {
			alert('请选择一条数据！');
		}
	}

	//提交按钮
	function updata(){
		var ID=$('#ID').textbox('getValue');
		var MC=$('#MC').textbox('getValue');
		var ByName=$('#ByName').textbox('getValue');
		var LX=$('#LX').combobox('getValue');
		var BZ=$('#BZ').textbox('getValue');
		$.post(url,{ Shop_ID:ID,Shop_MC:MC,Shop_ByName:ByName,Shop_LX:LX,Shop_BZ:BZ },function(res){
			$('#fm').form('clear');
			$('#dlg').dialog('close');
			$('#dg').datagrid('reload');
			if(res.code!=1){ tsshow(res.msg) };
		},'json');
	}

	//下拉框
	function getbox(){
		$.post('dpxx_json_lx_get.asp',function(res){
			$('#LX').combobox({
			valueField:'Shop_ID',
    		textField:'Shop_MC',
    		data:res.rows
    		}) 
		},'json');
	}
</script>
</body>
</html>