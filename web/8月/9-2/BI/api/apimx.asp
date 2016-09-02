<!DOCTYPE html>
<html>
<head>
	<title>API接口明细</title>
	<meta charset="utf-8">
	<!--#include file="class/headconfig.asp"-->
	<style>
		* { font-family: Consolas,Arial; }
		.divz { min-width:800px; position:fixed; top:10px; left:10px; right:10px; bottom:10px; }
		.bottom { margin-bottom: 20px; }
	</style>
</head>
<body>
<!--divz-->
<div class="divz">
	<input type="hidden" id="hidbox_no">
	<div class="easyui-layout" data-options="fit:true">
		<div data-options="region:'center',border:false">
			<div class="bottom">
				<div id="apimx"></div>
				<div id="toolbar_api">
					<div style="margin:10px;">
						<span>参数名：</span>
						<input id="mc_apimx" class="easyui-textbox" style="width:150px;">
						<a href="#" class="easyui-linkbutton left_api" iconCls="icon-search" onclick="">查询</a>
						<a href="#" class="easyui-linkbutton left_api" iconCls="icon-reload" onclick="">刷新</a>
						<a href="#" class="easyui-linkbutton left_api" iconCls="icon-add" onclick="">增加</a>
					</div>
				</div>
			</div>

			<div class="bottom">
				<div id="apimx_yyj"></div>
				<div id="toolbar_api_yyj">
					<div style="margin:10px;">
						<span>参数名：</span>
						<input id="mc_apimx" class="easyui-textbox" style="width:150px;">
						<a href="#" class="easyui-linkbutton left_api" iconCls="icon-search" onclick="">查询</a>
						<a href="#" class="easyui-linkbutton left_api" iconCls="icon-reload" onclick="">刷新</a>
						<a href="#" class="easyui-linkbutton left_api" iconCls="icon-add" onclick="">增加</a>
					</div>
				</div>
			</div>

			<div class="bottom">
				<div class="easyui-panel" title="返回值演示" style="width:98%;height:auto;" 
					data-options="
						href:'fhdgl_json.asp?czlx=apimx_ys',
						footer:'#ft'"></div>
				<div id="ft" style="padding:5px;">
				    演示结束
				</div>
			</div>

			<div class="bottom">
				<div id="apimx_jg"></div>
				<div id="toolbar_api_jg">
					<div style="margin:10px;">
						<span>参数名：</span>
						<input id="mc_apimx" class="easyui-textbox" style="width:150px;">
						<a href="#" class="easyui-linkbutton left_api" iconCls="icon-search" onclick="">查询</a>
						<a href="#" class="easyui-linkbutton left_api" iconCls="icon-reload" onclick="">刷新</a>
						<a href="#" class="easyui-linkbutton left_api" iconCls="icon-add" onclick="">增加</a>
					</div>
				</div>
			</div>

			<div class="bottom">
				<div class="easyui-panel" title="返回值演示" style="width:98%;height:auto;" 
					data-options="
						href:'fhdgl_json.asp?czlx=apimx_ys',
						footer:'#ft_2'"></div>
				<div id="ft_2" style="padding:5px;">
				    演示结束
				</div>
			</div>

			<!-- 增加提示框 -->
			<!-- <div id="dlg_addmx" class="easyui-dialog" style="width:770px;height:450px;" closed="true" modal="true" buttons="#dlg-buttons_addmx">
				<table id="dg_tb" class="easyui-datagrid" style="width:100%;height:100%;"
							data-options="
								iconCls: 'icon-edit',
								singleSelect: true,
								toolbar: '#tb',
								method: 'get',
								onClickRow: onClickRow
							">
					<thead>
						<tr>
							<th data-options="field:'attr1',width:100,align:'center',editor:'textbox'">参数名</th>
							<th data-options="field:'attr2',width:90,align:'center',editor:'textbox'">别名</th>
							<th data-options="field:'attr3',width:100,align:'center',editor:'textbox'">类型</th>
							<th data-options="field:'attr4',width:70,align:'center',editor:{type:'checkbox',options:{on:'是',off:'否'}}">必填</th>
							<th data-options="field:'attr5',width:80,align:'center',editor:'textbox'">示例值</th>
							<th data-options="field:'attr6',width:80,align:'center',editor:'textbox'">默认值</th>
							<th data-options="field:'attr7',width:235,align:'left',editor:'textbox'">描述</th>
						</tr>
					</thead>
				</table>
				<div id="tb">
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">增加</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit()">删除</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">保存</a>
				</div>
			</div>
			<div id="dlg-buttons_addmx">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="savetype()">确认</a>
				<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg_addmx').dialog('close');">取消</a>
			</div> -->
			<!-- 增加结束 -->

		</div>
	</div>
</div>
<!--divz结束-->
<script>
	$(document).ready(function(){ apimx(); apimx_yyj(); apimx_jg(); });

	function apimx()
	{
		$('#apimx').datagrid({
			title:'系统级参数',
			width:'98%',
			// height:'300px',
			url:'fhdgl_json.asp',
			queryParams:{ czlx:'apimx' },
			//fitColumns:'true',
			toolbar:'#toolbar_api',
			singleSelect:'true',
			method:'post',
			rownumbers:'true',
			autoRowHeight:'true',
			//pagination:'true',
			// pageSize:20,
			// pageNumber:1,
			// pageList:[20,50,100],
			columns:[[
				{field:'csmc',title:'参数名',width:110,align:'center'},
				{field:'bm',title:'别名',width:100,align:'center'},
				{field:'lx',title:'类型',width:110,align:'center'},
				{field:'sfbx',title:'必填',width:53,align:'center'},
				{field:'ms',title:'描述',width:260,align:'left'}
			]]
		});
	}

	function apimx_yyj()
	{
		$('#apimx_yyj').datagrid({
			title:'应用级参数',
			width:'98%',
			// height:'300px',
			url:'fhdgl_json.asp',
			queryParams:{ czlx:'apimx' },
			//fitColumns:'true',
			toolbar:'#toolbar_api_yyj',
			singleSelect:'true',
			method:'post',
			rownumbers:'true',
			autoRowHeight:'true',
			//pagination:'true',
			// pageSize:20,
			// pageNumber:1,
			// pageList:[20,50,100],
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

	function apimx_jg()
	{
		$('#apimx_jg').datagrid({
			title:'返回结果',
			width:'98%',
			url:'fhdgl_json.asp',
			queryParams:{ czlx:'apimx' },
			toolbar:'#toolbar_api_jg',
			singleSelect:'true',
			method:'post',
			rownumbers:'true',
			autoRowHeight:'true',
			columns:[[
				{field:'csmc',title:'参数名',width:110,align:'center'},
				{field:'lx',title:'类型',width:110,align:'center'},
				{field:'ms',title:'描述',width:260,align:'left'}
			]]
		});
	}
</script>
</body>
</html>