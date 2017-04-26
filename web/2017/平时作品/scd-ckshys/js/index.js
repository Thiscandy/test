// JavaScript Document
/*点击链接跳转*/
function doLink(strURL)  
{  
	window.location = strURL;  
}

/*自动提交搜索框内容*/
function subform()
{
	if(document.getElementById("srk").value)
	{
		document.getElementById("form1").submit();
	}
}

/*提交创建框内容*/
function tjxj(n)
{
	if(n==1)
	{
		if(document.getElementById("KH_NAME").value)
		{
			document.getElementById("form1").submit();
		}
		else
		{
			layer.msg('客户姓名为必填项');
		}
	}
	if(n==2)
	{
		if(document.getElementById("QP_QPBH").value&&document.getElementById("QP_YXRQ").value&&document.getElementById("QP_SCDW").value)
		{
			document.getElementById("form1").submit();
		}
		else
		{
			layer.msg('气瓶编号、有效日期、生产单位均为必填项');
		}
	}
}

/*选择客户页点击跳转事件*/
function xzkh(khid,khxm,khbm,khsj,khdz)
{
	if(khid)
	{
		window.location.href='xzyw.asp?khid='+khid+'&khname='+khxm+'&khbm='+khbm+'&khsj='+khsj+'&khdz='+khdz;
	}
}

/*业务页面*/
function foqp()
{
	document.getElementById('qpbh').select();
}

function tjqpbh(lx)
{
	var qpbh=$('#qpbh').val();
	if(qpbh)
	{
		window.location.href='czqp_ck.asp?QP_QPBH='+qpbh+'&ywlx='+lx;
	}
}

function yw_del(id,ym)
{
	layer.msg('是否确认删除该明细', {
		time: 20000,
		btn: ['是', '否'],
		btn1: function(index, layero){
			$.post('yw_json_del.asp',{ IID:id },function(res){
					if(res.code=='1'){ window.location.href=ym; } else { layer.msg('删除失败'); }
			},'json');
		}
	});
}

function yw_clear()
{
	layer.msg('是否确认清空单据', {
		time: 20000,
		btn: ['是', '否'],
		btn1: function(index, layero){
			$.post('yw_json_clear.asp',function(res){
					if(res.code=='1'){ layer.msg('清空成功'); } else { layer.msg('清空失败'); }
			},'json');
		}
	});
}

function yw_cha(id,ym)
{
	try{
		var zl=$('#gqzl').val();
		var xj=$('#ywxj').val();
		var psjg=$('#psjg').val();
		var xz=$('#jcxz').val();
		var qpbh=$('#hidqpbh').val();
		$.post('yw_json_cha.asp',{ IID:id,QP_BH:qpbh,YW_ZL:zl,YW_JG:xj,QP_PSJG:psjg,IS_BRHQ:xz },function(res){
			if(res.code=='1'){ window.location.href=ym; }else{ window.location.href=ym+'?fh=xgsb'; }
		},'json');
	}catch(e){}
}

function lx_cha(id,ym)
{
	var zl=$('#gqzl').val();
	$.post('yw_lx_json_get.asp',{ gqzl:zl },function(res){
		$('#ywxj').val(res.rows[0].Q_ZJG);
	},'json');
}

/*业务-提示客户及气瓶所属页面*/
function ts_qx(ym)
{
	window.location.href=ym;
}