<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>新品跟踪</title>
	<!--#include file="class/headconfig.asp"-->
	<style>
		.display { display:inline-block; width:80px; }
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
						<a href="#" class="easyui-linkbutton" onclick="" style="width:50px;margin-left:10px;">新增</a>
						<a href="#" class="easyui-linkbutton" onclick="" style="width:50px;margin-left:10px;">删除</a>
						<a href="#" class="easyui-linkbutton" onclick="" style="width:50px;margin-left:10px;">修改</a>
					</span>
				</div>
			</div>
			<!--dlg-->
			<div id="dlg" class="easyui-dialog" style="display: none; width:370px; height:200px; padding-top:20px;padding-left:25px;" closed="true" modal="true" buttons="#dlg-buttons">
				<form id="fm" method="post" novalidate>
					<div class="fitem">
						<label style="display:inline-block; width:80px;">主体类型:</label>
						<select class="easyui-combobox" editable="false" id="state" style="width:150px;">
							<option value="SPU">SPU</option>
							<option value="SKC">SKC</option>
							<option value="SKU">SKU</option>
						</select>
					</div>
					<div class="fitem">
				        <label class="display">主体编号:</label>
				        <input id="roleID" class="easyui-textbox" required="true" style="width:150px;">
				    </div>
				    <div class="fitem">
						<label style="display:inline-block; width:80px;">价格类型:</label>
						<select class="easyui-combobox" editable="false" id="state" style="width:150px;">
							<option value="1">进价</option>
							<option value="2">售价</option>
						</select>
					</div>
					<div class="fitem">
				        <label style="display:inline-block; width:80px;">价格主体:</label>
				        <input id="roleID" class="easyui-textbox" required="true" style="width:150px;">
				    </div>
				    <div class="fitem">
				        <label style="display:inline-block; width:80px;">单价:</label>
				        <input id="roleID" class="easyui-textbox" required="true" style="width:150px;">
				    </div>
				</form>
			</div>

			<div id="dlg-buttons">
			    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="savetype()">提交</a>
			    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close');$('#fm').form('clear')">取消</a>
			</div>
			<!--dlg结束-->
			<!--xzdlg-->
			<div id="xzdlg" class="easyui-dialog" style="width:340px;height:280px;padding-top:20px;padding-left:25px;" closed="true" modal="true" buttons="#xzdlg-buttons">
				<form id="xzfm" method="post" novalidate>
					<div class="fitem">
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
					</div>
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
			title:'新品跟踪',
			width:'99.9%',
			height:'100%',
			url:'xpgz_json.asp',
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
				{field:'value_MB',title:'主体类型',width:200,align:'center'},
				{field:'value_MB',title:'价格主体',width:200,align:'center'},
				{field:'Price_MB',title:'供价主体',width:100,align:'center'},
				{field:'Price_Type',title:'价格类型',width:150,align:'center'},
				{field:'Price',title:'单价',width:200,align:'center'}
			]]
		});
	}

	//新增按钮
	var url;
	function newadd(){
		$('#dlg').dialog('open').dialog('setTitle','新增角色信息');
		//打开dig对话窗口，标题为新增角色信息
		$('#fm').form('clear');
		//清除fm表单
		url = 'dpxx_json_add.asp';
		//指定url
	}
</script>
</body>
</html>