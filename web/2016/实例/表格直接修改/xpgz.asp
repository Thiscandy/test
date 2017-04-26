<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>新品跟踪</title>
	<!--#include file="class/headconfig.asp"-->
</head>
<style>
	#fm { margin:0; padding:15px 30px; }
	.fitem { margin-bottom:15px; }
	#fxkz { display:inline-block }
	.fitem input { width:200px; }
</style>
<body>
<!--divz-->
<div class="divz">
	<div id="dg"></div>
	<div id="toolbar"> 
		<div style="margin:10px;">
			<span style="padding-left:10px;">
				<span>查询条件:</span>
				<input id="mc" class="easyui-textbox">
				<span style="margin-left:10px;"><a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="doSearch()">查找</a></span>
				<span style="margin-left:20px;"><a href="#" class="easyui-linkbutton" iconCls="icon-reload" onclick="javascript:$('#dg').datagrid('reload');">刷新</a></span>
			</span>
		</div>
	</div>
</div>
<!--divz结束-->

<script>
	$(document).ready(function(){ dg(); });

	var combodata=[{va:'是',text:'是'},{va:'否',text:'否'}];
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
			//编辑之前、之后、关闭编辑触发，判断行的编辑状态，更新行
			onBeforeEdit:function(index,row){
				row.editing = true;
				updateActions(index);
			},
			onAfterEdit:function(index,row){
				row.editing = false;
				updateActions(index);
			},
			onCancelEdit:function(index,row){
				row.editing = false;
				updateActions(index);
			},
			frozenColumns:[[
				{field:'GZ_SPU',title:'商品代码',width:100,align:'center'},
				{field:'GZ_XQFQ',title:'需求发起',width:100,align:'center'},
				{field:'GZ_GC',title:'工厂',width:100,align:'center'},
				{field:'GZ_TP',title:'图片',width:100,align:'center'},
				{field:'GZ_ZT',title:'状态',width:100,align:'center'},
				{field:'action',title:'操作',width:100,align:'center',
					formatter:function(value,row,index){
					//格式化
						if (row.editing){
							var s = '<a href="#" onclick="saverow(this)">保存</a> ';
							var c = '<a href="#" onclick="cancelrow(this)">关闭</a>';
							return s+c;
						} else {
							var e = '<a href="#" onclick="editrow(this)">修改</a> ';
							var d = '<a href="#" onclick="deleterow(this)">删除</a>';
							return e;
						}
					}
				}
			]],
			columns:[[
				{field:'GZ_FQSJ',title:'发起时间',width:150,align:'center',editor:{type:'datebox',options:{editable:false}} },
				//editor编辑状态下的单元格样式
				{field:'GZ_KTXK',title:'看图选款',width:150,align:'center',editor:'text'},
				{field:'GZ_DYXK',title:'到样选款',width:150,align:'center',editor:'text'},
				{field:'GZ_YPSFXG',title:'样品是否修改',width:150,align:'center',editor:{ type:'combobox',options:{ valueField:'va',textField:'text',editable:false,data:combodata } }},
				//																															 复选框内容不能编辑只能选取，数据：数组
				{field:'GZ_PZYDY',title:'拍照样到样',width:150,align:'center',editor:'text'},
				{field:'GZ_QRXD',title:'确认下单',width:150,align:'center',editor:'text'},
				{field:'GZ_XD',title:'下单',width:150,align:'center',editor:'text'},
				{field:'GZ_TGCPXX',title:'提供产品信息',width:150,align:'center',editor:'text'},
				{field:'GZ_PBZT',title:'排版做图',width:150,align:'center',editor:'text'},
				{field:'GZ_WPSH',title:'唯品上货',width:150,align:'center',editor:'text'},
				{field:'GZ_TMSH',title:'天猫上货',width:150,align:'center',editor:'text'},
				{field:'GZ_DHTZSJ',title:'到货通知上架',width:150,align:'center',editor:'text'},
				{field:'GZ_TMSJ',title:'天猫上架',width:150,align:'center',editor:'text'},
				{field:'GZ_WPSJ',title:'唯品上架',width:150,align:'center',editor:'text'},
				{field:'GZ_FG',title:'风格',width:200,align:'center',editor:'text'},
				{field:'GZ_SXZT',title:'上新主题',width:200,align:'center',editor:'text'},
				{field:'GZ_SFFD',title:'是否翻单',width:100,align:'center',editor:{ type:'combobox',options:{ valueField:'va',textField:'text',editable:false,data:combodata } }},
				{field:'GZ_BZ',title:'备注',width:200,align:'center',editor:'text'}
			]]
		});
	}

	function doSearch()
	{
		$('#dg').datagrid('load',{
			mc: $("#mc").textbox('getValue')
		});
	}
	
	//更新这一行
	function updateActions(index)
	{
		$('#dg').datagrid('updateRow',{
			index: index,
			row:{}
		});
	}
	
	//获取该行的索引
	function getRowIndex(target)
	{
		var tr = $(target).closest('tr.datagrid-row');
		return parseInt(tr.attr('datagrid-row-index'));
	}
	
	//修改
	function editrow(target)
	{
		var ta=getRowIndex(target)
		$('#dg').datagrid('beginEdit', ta);
		$('#dg').datagrid('selectRow', ta);
	}
	
	function saverow(target)
	{
		$('#dg').datagrid('endEdit', getRowIndex(target));
		getChanges();
	}
	
	function cancelrow(target)
	{
		$('#dg').datagrid('cancelEdit', getRowIndex(target));
	}
	
	function getChanges()
	{
		var rows = $('#dg').datagrid('getChanges',"updated");
		//getChanges获取改变的行，updated更新状态的行
		if (rows.length > 0) 
		{
			$.post('xpgz_json_edit.asp',{
				GZ_SPU:rows[0].GZ_SPU,
				GZ_FQSJ:rows[0].GZ_FQSJ,
				GZ_KTXK:rows[0].GZ_KTXK,
				GZ_DYXK:rows[0].GZ_DYXK,
				GZ_YPSFXG:rows[0].GZ_YPSFXG,
				GZ_PZYDY:rows[0].GZ_PZYDY,
				GZ_QRXD:rows[0].GZ_QRXD,
				GZ_XD:rows[0].GZ_XD,
				GZ_TGCPXX:rows[0].GZ_TGCPXX,
				GZ_PBZT:rows[0].GZ_PBZT,
				GZ_WPSH:rows[0].GZ_WPSH,
				GZ_TMSH:rows[0].GZ_TMSH,
				GZ_DHTZSJ:rows[0].GZ_DHTZSJ,
				GZ_TMSJ:rows[0].GZ_TMSJ,
				GZ_WPSJ:rows[0].GZ_WPSJ,
				GZ_FG:rows[0].GZ_FG,
				GZ_SXZT:rows[0].GZ_SXZT,
				GZ_SFFD:rows[0].GZ_SFFD,
				GZ_BZ:rows[0].GZ_BZ
			},function(res){ 
				if(res.code!=1){ tsshow(res.msg); }
			},'json');
		}
	}

</script>
</body>
</html>