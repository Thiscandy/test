<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>新品跟踪</title>
	<!--#include file="class/headconfig.asp"-->
</head>
<style>
	#fm { margin:0; padding:15px 30px; }
	#xzfm { margin:0; padding:30px 30px 0px; }
	.fitem { margin-bottom:15px; }
	#fxkz { display:inline-block }
	.fitem input { width:200px; }
	.display { display:inline-block;width:60px;text-align:right;margin-left: 5px; }
</style>
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
						<a href="#" class="easyui-linkbutton" onclick="quedin()" style="width:50px;margin-left:10px;">登记</a>
						<a href="#" class="easyui-linkbutton" onclick="newtype()" style="width:50px;margin-left:10px;">新增</a>
					</span>
				</div>
			</div>
			<!--dlg-->
			<div id="dlg" class="easyui-dialog" style="width:370px; height:200px; padding-top:20px;padding-left:25px;" closed="true" modal="true" buttons="#dlg-buttons">
			<form id="fm" method="post" novalidate>
				<div class="fitem">
					<!-- <input id="" name="" type="hidden"> -->
					<label style="display:inline-block; width:80px;">登记项:</label>
					<select class="easyui-combobox" editable="false" id="state" style="width:150px;">
						<option value="GZ_FQSJ">发起时间</option>
						<option value="GZ_KTXK">看图选款</option>
						<option value="GZ_DYXK">到样选款</option>
						<option value="GZ_YPSFXG">样品是否修改</option>
						<option value="GZ_PZYDY">拍照样到样</option>
						<option value="GZ_QRXD">确认下单</option>
						<option value="GZ_XD">下单</option>
						<option value="GZ_TGCPXX">提供产品信息</option>
						<option value="GZ_PBZT">排版做图</option>
						<option value="GZ_WPSH">唯品上货</option>
						<option value="GZ_TMSH">天猫上货</option>
						<option value="GZ_DHTZSJ">到货通知上架</option>
						<option value="GZ_TMSJ">天猫上架</option>
						<option value="GZ_WPSJ">唯品上架</option>
						<option value="GZ_FG">风格</option>
						<option value="GZ_SXZT">上新主题</option>
						<option value="GZ_SFFD">是否翻单</option>
						<option value="GZ_BZ">备注</option>
					</select>
				</div>
				<div class="fitem"></div>
			        <label style="display:inline-block; width:80px;">登记值:</label>
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
			<div id="xzdlg" class="easyui-dialog" style="width:300px;height:300px;" closed="true" modal="true" buttons="#xzdlg-buttons">
				<form id="xzfm" method="post" novalidate>
					<div class="fitem">
						<label class="display">商品代码：</label>
						<input id="SPU" class="easyui-textbox" required="true" style="width:150px;">
					</div>
					<div class="fitem">
						<label class="display">需求发起：</label>
						<input id="XQFQ" class="easyui-textbox" required="true" style="width:150px;">
					</div>
					<div class="fitem">
						<label class="display">工厂：</label>
						<input id="GC" class="easyui-textbox" required="true" style="width:150px;">
					</div>
					<div class="fitem">
						<label class="display">图片：</label>
						<input id="TP" class="easyui-textbox" required="true" style="width:150px;">
					</div>
					<div class="fitem">
						<label class="display">状态：</label>
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
				{field:'GZ_SPU',title:'商品代码',width:200,align:'center'},
				{field:'GZ_XQFQ',title:'需求发起',width:100,align:'center'},
				{field:'GZ_GC',title:'工厂',width:150,align:'center'},
				{field:'GZ_TP',title:'图片',width:200,align:'center'},
				{field:'GZ_ZT',title:'状态',width:100,align:'center'},
			]],
			columns:[[
				{field:'GZ_FQSJ',title:'发起时间',width:150,align:'center'},
				{field:'GZ_KTXK',title:'看图选款',width:150,align:'center'},
				{field:'GZ_DYXK',title:'到样选款',width:150,align:'center'},
				{field:'GZ_YPSFXG',title:'样品是否修改',width:150,align:'center'},
				{field:'GZ_PZYDY',title:'拍照样到样',width:150,align:'center'},
				{field:'GZ_QRXD',title:'确认下单',width:150,align:'center'},
				{field:'GZ_XD',title:'下单',width:150,align:'center'},
				{field:'GZ_TGCPXX',title:'提供产品信息',width:150,align:'center'},
				{field:'GZ_PBZT',title:'排版做图',width:150,align:'center'},
				{field:'GZ_WPSH',title:'唯品上货',width:150,align:'center'},
				{field:'GZ_TMSH',title:'天猫上货',width:150,align:'center'},
				{field:'GZ_DHTZSJ',title:'到货通知上架',width:150,align:'center'},
				{field:'GZ_TMSJ',title:'天猫上架',width:150,align:'center'},
				{field:'GZ_WPSJ',title:'唯品上架',width:150,align:'center'},
				{field:'GZ_FG',title:'风格',width:200,align:'center'},
				{field:'GZ_SXZT',title:'上新主题',width:200,align:'center'},
				{field:'GZ_SFFD',title:'是否翻单',width:100,align:'center'},
				{field:'GZ_BZ',title:'备注',width:200,align:'center'}
			]]
		});
	}

	//登记按钮
	function quedin() {
		var row = $('#dg').datagrid('getSelected');
		if (row) {
			$('#dlg').dialog('open').dialog('setTitle','登记');
		}else {
			alert('请选择数据！');
		}
	}

	//提交按钮
	function savetype() {
		var row = $('#dg').datagrid('getSelected');//选中的行
		var va=$('#state').combobox('getValue');//登记项的值
		var zhi=$('#roleID').textbox('getValue');//登记值
		//alert(row.GZ_SPU+"  "+va+"  "+zhi)
		$.post('xpgz_json_edit.asp',{ SPU:row.GZ_SPU,key:va,value:zhi },function(res){ 
			$('#dlg').dialog('close');
			$('#dg').datagrid('reload');
			$('#fm').form('clear');
		},'json');
	}

	//查找按钮
	function doSearch() {
		$('#dg').datagrid('load',{
			mc: $("#mc").textbox('getValue')
		});
	}

	//新增按钮
	function newtype() {
		$('#xzdlg').dialog('open').dialog('setTitle','新增');
		//打开dig对话窗口，标题为新增角色信息
		$('#fm').form('clear');
		//清除fm表单
		url = 'xpgz_json_add.asp';
		//指定url
	}

	//新增的提交按钮
	function updata() {
		var SPU=$('#SPU').textbox('getValue');
		var XQFQ=$('#XQFQ').textbox('getValue');
		var GC=$('#GC').textbox('getValue');
		var ZT=$('#ZT').textbox('getValue');
		var TP=$('#TP').textbox('getValue');
		$.post('xpgz_json_add.asp',{ SPU:SPU,GZ_XQFQ:XQFQ,GC:GC,TP:TP,ZT:ZT },function(res){ 
			$('#xzdlg').dialog('close');
			$('#dg').datagrid('reload');
			$('#xzfm').form('clear');
		},'json');		
	}
</script>
</body>
</html>