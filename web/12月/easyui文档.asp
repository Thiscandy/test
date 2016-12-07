
<!-- 声明 -->

<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="class/API.asp"-->

<!-- 数据交互 -->
<% 
Session.Codepage=65001

czlx=request("czlx")
page_no=request("page")
page_size=request("rows")
rsort=request("sort")
order=request("order")
BDATE=request("BDATE")
EDATE=request("EDATE")


if czlx<>"" then

	'建立API对象
	Set API = New Yiten_API
	ParaTemp = Array()
	
	if czlx = "get" then
		ParaTemp=ADD_Array(ParaTemp,"method","GET")
		ParaTemp=ADD_Array(ParaTemp,"BDATE",BDATE)
		ParaTemp=ADD_Array(ParaTemp,"EDATE",EDATE)
	end if

	if czlx = "add" then
		ParaTemp=ADD_Array(ParaTemp,"method","ADD")
	end if
	
	ParaTemp=ADD_Array(ParaTemp,"page_no",page_no)
	ParaTemp=ADD_Array(ParaTemp,"page_size",page_size)
	ParaTemp=ADD_Array(ParaTemp,"sort",rsort)
	ParaTemp=ADD_Array(ParaTemp,"order",order)
	sHtml = API.Post(ParaTemp)
	set API = nothing
	
	response.Write sHtml
	response.end
end if
%>




<!-- css样式 -->

<style>
	.fitem_div label { display: inline-block;width: 80px;text-align: left;margin-left: 10px; }
	.fitem_div { margin: 5px 0px;display: inline-block; }
	.width { width: 90px; }
	.left { margin-left: 10px; }
	.fm{ margin:0;padding-top: 25px;padding-left: 15px; }
	.fitem{ margin-bottom:15px;display: inline-block;margin-left: 10px; }
	.fitem label{ display:inline-block; width:75px; }
	.fitem input{ width:150px; }
	a { text-decoration:none; }
</style>

<!-- 
	north     北
	south     南
	center    中
	east      东
	west      西
-->

<!-- 上中下布局 -->

<div class="easyui-layout" data-options="fit:true">

	<div data-options="region:'north',border:false" title="工作日志-登记" style="height:115px;width:100%;overflow:hidden;">
		<div id="p" class="easyui-panel" style="width:100%; height:100%; min-width:910px;padding:5px;">
			<div style="margin:5px 0;">
				<a href="#" class="easyui-linkbutton width left" iconCls="icon-search" onclick="searchc()">搜索</a></span>
				<a href="#" class="easyui-linkbutton width left" iconCls="icon-tip" onclick="javascript:$('#form').form('clear')">重置</a></span>
			</div>
			<form id="form" style="margin-top:10px;width:900px;height:35px;margin-left:10px;">

				<!-- 
					required="true"      必填
					editable="false"     锁住
				-->

				<!-- 文本框 -->
				<div class="fitem_div">
					<label>文本框</label>
					<input id="" class="easyui-textbox" style="width:120px;">
				</div>

				<!-- 日期区间 -->
				<div class="fitem_div">
					<label>日期</label>
					<input id="bdate" class="easyui-datebox" style="width:120px;" editable="false">
					-
					<input id="edate" class="easyui-datebox" style="width:120px;" editable="false">
				</div>

				<!-- 自定义下拉框 -->
				<div class="fitem_div">
					<label>日志类型</label>
					<select id="ss_rzlx" class="easyui-combobox" style="width:120px;" editable="false">
							<option value="日报">日报</option>
							<option value="周报">周报</option>
					</select>
				</div>

				<!-- 后台数据下拉框 -->
				<div class="fitem_div">
					<label>用户名</label>
					<select id="yhm" class="easyui-combobox" style="width:120px;"></select>
				</div>
				<script>
					$(document).ready(function(){ getsel(); });
					function getsel()
					{
						$.post(url:url,{ czlx:'yhm' },function(res){
							$('#yhm').combobox({ valueField:'UserID',textField:'UserName',data:res.rows });
						},'json');
					}

					//锁住
					$('#id').combobox('readonly',true);
					$('#id').datebox('readonly',true);
					$('#id').textbox('readonly',true);

					//赋值
					$('#id').combobox('setValue',row.LogType);
					$('#id').datebox('setValue',row.LogType);
					$('#id').textbox('setValue',row.LogType);

					//取值
					var id = $('#id').textbox('getValue');
				</script>

			</form>
		</div>
	</div>

	<div data-options="region:'center',border:false" style="height: 42%;overflow:hidden;">
		<div id="dg"></div>
	</div>

	<div data-options="region:'south',border:false" style="height: 40%;overflow:hidden;">
		<div id="tt" class="easyui-tabs" style="width:100%; height:100%;overflow:hidden;">
			<div title="计划" style="overflow:hidden;"><div id="jh" class="easyui-datagrid" data-options="collapsible:true"></div></div>
			<div title="完成" style="overflow:hidden;"><div id="wc" class="easyui-datagrid" data-options="collapsible:true"></div></div>
			<div title="挂起" style="overflow:hidden;"><div id="gq" class="easyui-datagrid" data-options="collapsible:true"></div></div>
		</div>
	</div>

</div>



<!-- 上下布局 -->
<div class="easyui-layout" data-options="fit:true">

	<div data-options="region:'north',border:false" style="height:120px;">
		<div id="p" class="easyui-panel" title="操作员管理" style="width:100%; height:100%; min-width:1100px; padding:5px;">
			<div style="margin:5px; margin-bottom:15px;">
				<a href="#" class="easyui-linkbutton width left" iconCls="icon-search" onclick="searchc()">搜索</a></span>
				<a href="#" class="easyui-linkbutton width left" iconCls="icon-tip" onclick="javascript:$('#form').form('clear')">重置</a></span>
			</div>
			<form id="form" style="margin-top:10px;width:900px;height:35px;margin-left:10px;">

			</form>
		</div>
	</div>

	<div data-options="region:'center',border:false">
		<div id="dg"></div>
	</div>

</div>

<script>

	// 日常新增
	function add()
	{
		$('#dlg').dialog('open').dialog('setTitle','新增');
		$('#id').textbox('setValue','<%=session("UserName")%>');  //赋值全局变量
		$('#id').combobox('readonly',false);
		var row = $('#dg').datagrid('getSelected');
		czlx='add';
	}

	// 日常修改
	function rz_edit()
	{
		var row = $('#dg').datagrid('getSelected');
		if (row) 
		{

			$('#dlg').dialog('open').dialog('setTitle','修改');
			$('#id').textbox('setValue','<%=session("UserName")%>');
			$('#id').datebox('readonly',true);
			$('#if').textbox('setValue',row.Note);
			czlx='edit';

		} else {
			tsshow('请选择一条数据！');
		}
	}

	//确定按钮
	function updata()
	{
		var id = $('#id').datebox('getValue');
		var id = $('#id').combobox('getValue');
		var id = $('#id').textbox('getValue');
		if (id&&id)
		{
			$.post(url,{ czlx:czlx,id:id },function(res){
				if(res.code!=1){ tsshow(res.msg); }
				else{ $('#dg').datagrid('reload');$('#fm').form('clear');$('#dlg').dialog('close'); }
			},'json');
		}
		else
		{
			tsshow('请按提示填写完整','系统提示');
		}
	}

	// 日常删除
	function remove(){
		var row = $('#dg').datagrid('getSelected');
		if (row) {
			$.messager.confirm('系统提示','确定删除？',function(r){
				if (r){
					$.post(url,{ LogID:row.LogID,czlx:'del' },function(res){
						if(res.code!=1){ tsshow(res.msg); }
						else{ $('#dg').datagrid('reload'); }
					},'json');
				}
			});
		}else {
			tsshow('请选择一条数据！');
		}
	}


	// 让提示框里的文字变成灰色
	$('#cgdh_yq').next('span').find('input').css('color','#808080');

	// 改变数据表格行的字体颜色
	rowStyler:function(index,row){
		if (row.Status=='未达标'){
		return 'color:#f40';
		};
		if (row.Status=='未分配'){
		return 'color:#F00';
		};
		if (row.Status=='执行中'){
		return 'color:#008000';
		};
	},

	// 单击选项卡事件
	function tabs_sx()
	{
	  $('#tt').tabs({
	        border:false,
	        onSelect:function(title,index){

			alert(title+' is selected');//这里写单击选项卡事件

	     }
	  });
	}

	// 数据表格双击无法选中数据行
	onDblClickRow:function(rowIndex){

	    $(this).datagrid('selectRow',rowIndex);//直接再次选中双击的这一行

	},

	// if嵌套
	if(true){
		return true;
	} else {
	  if(true){
	  	return true;
	  } else {
	    return false;
	  }
	}

	// 数据表格里某个字段的提示
	{field:'Note',title:'摘要',width:500,align:'left',sortable:true,
		formatter: function(value, row, index) {  
		    var abValue = value;  
		    if (value.length>=49) {  
		        abValue = value.substring(0,46) + "...";  
		    }  
		    var content = '<a href="#" title="' + value + '" class="note">' + abValue + '</a>';  
		    return content;  
		}
	}

	// 是否存在某个参数，否则退出
	var login = $('#login_user').val();
	if (login) {

	} else {
		window.parent.wqjtc();
	};

	// index文件tc事件
	function wqjtc()
	{
		window.location.href='../index_tc.asp';
	}

	// 1.当前页汇总、2.全部页汇总、3.两种都汇总
	$('#dg').datagrid({ showFooter:'true', });

	ParaTemp=ADD_Array(ParaTemp,"Collect","""CollectType=2"",""CollectField=第一个字段,YW_JG,YW_XJ""")


</script>