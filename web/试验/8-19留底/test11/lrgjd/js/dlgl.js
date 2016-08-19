// JavaScript Document
function tsshow(na,ti)
{
	if(ti)
	{
		$.messager.show({ title:ti, msg:na, showType:'fade', style:{ right:'', bottom:'' } });
	}
	else
	{
		$.messager.show({ title:'错误提示', msg:na, showType:'fade', style:{ right:'', bottom:'' } });
	}
}