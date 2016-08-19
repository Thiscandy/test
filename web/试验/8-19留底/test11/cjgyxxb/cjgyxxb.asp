<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>厂家供应信息表</title>
	<!--#include file="class/headconfig.asp"-->
	<style>
		.button { width:50px;margin-left:10px; }
		.display { display:inline-block; width:80px; }
		#fm { margin:0; padding:30px 30px 0px; }
		.fitem { margin-bottom:15px; }
		.fitem input { width:150px; }
		.fitem label { display:inline-block;width:90px;text-align:left;margin-left: 5px; }
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
						<input id="mc" class="easyui-textbox">
						<span style="margin-left:10px;"><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="doSearch()">查找</a></span>
						<a href="#" class="easyui-linkbutton button" onclick="newadd()">新增</a>
						<a href="#" class="easyui-linkbutton button" onclick="edit()">修改</a>
						<a href="#" class="easyui-linkbutton button" onclick="remove()">删除</a>
						<a href="#" class="easyui-linkbutton button" onclick="javascript:$('#dg').datagrid('reload');">刷新</a>
					</span>
				</div>
			</div>
			<!--dlg-->
			<div id="dlg" class="easyui-dialog" style="width:370px;height:450px;" closed="true" modal="true" buttons="#dlg-buttons">
				<form id="fm" method="post" novalidate>
					<div class="fitem">
						<label>厂家ID：</label>
						<input id="GC" class="easyui-textbox" required="true">
						<a class="easyui-linkbutton" onclick="xzdlg()">选择</a>
					</div>
					<div class="fitem">
						<label>SPU：</label>
						<input id="GC" class="easyui-textbox" required="true">
						<a class="easyui-linkbutton" onclick="xzdlg()">选择</a>
					</div>
					<div class="fitem">
						<label>最低起订量：</label>
						<input id="GC" class="easyui-textbox" required="true">
					</div>
					<div class="fitem">
						<label>厂家供应单价：</label>
						<input id="ZT" class="easyui-textbox" required="true">
					</div>
					<div class="fitem">
						<label>厂家生产周期：</label>
						<input id="ZT" class="easyui-textbox" required="true">
					</div>
					<div class="fitem">
						<label>厂家日均产能：</label>
						<input id="ZT" class="easyui-textbox" required="true">
					</div>
					<div class="fitem">
						<label>操作员ID：</label>
						<input id="ZT" class="easyui-textbox" required="true">
					</div>
					<div class="fitem">
						<label>最后修改时间：</label>
						<input id="ZT" class="easyui-textbox" required="true">
					</div>
					<div class="fitem">
						<label>厂家备注：</label>
						<input id="ZT" class="easyui-textbox" required="true">
					</div>
				</form>
			</div>
			<div id="dlg-buttons">
			    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="updata()">提交</a>
			    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close');$('#fm').form('clear')">取消</a>
			</div>
			<!--dlg结束-->
			<!--xzdlg-->
			<div id="xzdlg" class="easyui-dialog" style="width:340px;height:280px;padding-top:20px;padding-left:25px;" closed="true" modal="true" buttons="#xzdlg-buttons">
				<form id="xzfm" method="post" novalidate>
					<div id="dgg"></div>
					<div id="toolbar"> 
						<div style="margin:10px;">
							<span style="padding-left:10px;">
								<input id="mc" class="easyui-textbox">
								<span style="margin-left:10px;"><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="doSearch()">查找</a></span>
							</span>
						</div>
					</div>
					<!-- <div class="fitem">
						<label style="display:inline-block;width:80px;">商品代码：</label>
						<input id="SPU" class="easyui-textbox" required="true" style="width:150px;">
					</div>
					<div class="fitem">
						<label style="display:inline-block;width:80px;">需求发起：</label>
						<input id="XQFQ" class="easyui-textbox" required="true" style="width:150px;">
					</div>
					<div class="fitem">
						<label style="display:inline-block;width:80px;">工厂：</label>
						<input id="GC" class="easyui-textbox" required="true" style="width:150px;">
					</div>
					<div class="fitem">
						<label style="display:inline-block;width:80px;">状态：</label>
						<input id="ZT" class="easyui-textbox" required="true" style="width:150px;">
					</div> -->
				</form>
			</div>
			<div id="xzdlg-buttons">
			    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="updata()">提交</a>
			    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#xzdlg').dialog('close');$('#xzfm').form('clear')">取消</a>
			</div>
			<!--xzdlg结束-->
		</div>
	</div>
</div>
<!--divz结束-->
<script>
	$(document).ready(function(){ dg(); });

	function dg() {
		$('#dg').datagrid({
			title:'厂家供应信息表',
			width:'99.9%',
			height:'100%',
			url:'cjgyxxb_json.asp',
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
				{field:'CJ_ID',title:'厂家ID',width:200,align:'center'},
				{field:'SPU',title:'SPU',width:200,align:'center'},
				{field:'CP_QDL',title:'最低起订量',width:100,align:'center'},
				{field:'GY_GYDJ',title:'厂家供应单价',width:150,align:'center'},
				{field:'GY_SCZQ',title:'厂家生产周期',width:200,align:'center'},
				{field:'GY_RJCN',title:'厂家日均产能',width:200,align:'center'},
				{field:'CZY_ID',title:'操作员ID',width:200,align:'center'},
				{field:'MODIFY_TIME',title:'最后修改时间',width:200,align:'center'},
				{field:'GY_BZ',title:'厂家备注',width:200,align:'center'}
			]]
		});
	}

	function dgg() {
		$('#dgg').datagrid({
			width:'100%',
			height:'100%',
			url:'cjgyxxb_json.asp',
			toolbar:'#toolbarr',
			singleSelect:'true',
			method:'post',
			rownumbers:'true',
			autoRowHeight:'true',
			pagination:'true',
			pageSize:10,
			pageNumber:1,
			pageList:[10,20,50],
			frozenColumns:[[
				{field:'CJ_ID',title:'厂家ID',width:200,align:'center'},
				{field:'SPU',title:'SPU',width:200,align:'center'},
				{field:'CP_QDL',title:'最低起订量',width:100,align:'center'},
				{field:'GY_GYDJ',title:'厂家供应单价',width:150,align:'center'},
			]]
		})
	}

	//查找按钮事件
	function doSearch(){
		$('#dg').datagrid('load',{
			mc: $("#mc").textbox('getValue')
		});
	}

	//新增按钮
	var url;
	function newadd(){
		$('#dlg').dialog('open').dialog('setTitle','新增');
		//打开dig对话窗口，标题为新增角色信息
		$('#fm').form('clear');
		//清除fm表单
		url = 'dpxx_json_add.asp';
		//指定url
	}

	//修改按钮
	function edit(){
		var row = $('#dg').datagrid('getSelected');
		if (row) {
			$('#dlg').dialog('open').dialog('setTitle','修改');

		}else {
			alert('请选择一条数据！');
		}
	}

	//删除按钮
	function remove(){
		var row = $('#dg').datagrid('getSelected');
		if (row) {
			
		}else {
			alert('请选择一条数据！');
		}
	}

	//选择按钮
	function xzdlg(){
		$('#xzdlg').dialog('open').dialog('setTitle','选择');
		$('#xzfm').form('clear');
	}
</script>
</body>
</html>