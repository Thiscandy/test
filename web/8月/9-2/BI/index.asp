<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE HTML>
<html>
<head>
<title>BI系统</title>
<!--#include file="class/headconfig.asp"-->
</head>

<body class="easyui-layout">

<!--顶部-->
<div data-options="region:'north',border:false" style="height:60px; background-image:url(images/bj.jpg);">
</div>
<!--顶部结束-->

<!--左侧-->
<div data-options="region:'west',title:'导航栏',border:false" class="divle">

<div id="aa" class="easyui-accordion" style="width:100%;">
    <div title="BI系统" data-options="iconCls:'icon-more',selected:true" class="xl">
		<div class="easyui-linkbutton" onclick="addTab('API接口','api/api.asp')">API接口</div>
		<!-- <div class="easyui-linkbutton" onclick="addTab('行业搜索记录表','hyssjlb/hyssjlb.asp')">行业搜索记录表</div> -->
    </div>
    
</div>

</div>
<!--左侧结束-->

<!--主体-->
<div data-options="region:'center',border:false">

<div id="tt" class="easyui-tabs" style="width:100%; height:100%;"> <div title="主页"></div> </div>

</div>
<!--主体结束-->


<script>
function addTab(title, url)
{
	if ($('#tt').tabs('exists', title))
	{
		$('#tt').tabs('select', title);
	} 
	else 
	{
		var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'"></iframe>';
		$('#tt').tabs('add',{ title:title, content:content, closable:true });
	}
}

function retab(ti)
{
	var currTab=$('#tt').tabs('getTab',ti);
	var src=$(currTab.panel('options').content).attr('src');
	$('#tt').tabs('update',{ tab:currTab, options:{ content:'<iframe scrolling="auto" frameborder="0"  src="'+src+'"></iframe>' } });
}

function iftoinclo(na)
{
	$('#tt').tabs('close', na);
}
</script>
</body>
</html>
