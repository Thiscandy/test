// JavaScript Document
/*新建气瓶页判断气瓶编号*/
function pdbh()
{
	var qpbh=document.getElementById("QP_QPBH").value;
	if(qpbh.length==12)
	{
		$.post('xjqp_qp_json_get.asp',{ srk:qpbh },function(result){
			if(result.total=='0')
			{
				var str1=qpbh.substring(0,2);
				var str2=qpbh.substring(2,4);
				var str3=qpbh.substring(4,6);
				var str5=qpbh.substring(6,7);
				if(str1&&str2&&str3)
				{
					var str4=Number(str2)-4;
					if(str1=='07')
					{
						document.getElementById("QP_SCDW").value='同气';
					}
					else
					{
						document.getElementById("QP_SCDW").value='外来瓶';
					}
					document.getElementById("QP_SCRQ").value='20'+str4+'-'+str3+'-01';
					document.getElementById("QP_YXRQ").value='20'+str2+'-'+str3+'-01';
				}
				if(str5)
				{
					if(str5=='4')
					{
						document.getElementById("QP_QPFL").value='PT_1';
					}
					if(str5=='3')
					{
						document.getElementById("QP_QPFL").value='PT_2';
					}
				}
			}
			else
			{
				window.location.href='xjqp.asp?fh=qpcz'
			}
		},'json');
	}
	else
	{
		if(qpbh.length>23)
		{
			document.getElementById("QP_QPBH").value='';
			document.getElementById("QP_SCRQ").value='';
			document.getElementById("QP_YXRQ").value='';
			document.getElementById("QP_SCDW").value='';
			document.getElementById("QP_GQZL").value='';
			document.getElementById("QP_FLID").value='';
			document.getElementById("QP_YZLX").value='';
			//document.getElementById("QP_ZT").value='';
		}
		else
		{
			document.getElementById("QP_SCRQ").value='';
			document.getElementById("QP_YXRQ").value='';
			document.getElementById("QP_SCDW").value='外来瓶';
			document.getElementById("QP_GQZL").value='';
			document.getElementById("QP_FLID").value='';
			document.getElementById("QP_YZLX").value='';
			//document.getElementById("QP_ZT").value='';
		}
		document.getElementById("QP_QPBH").select();
		layer.msg('气瓶编号位数不正确');
	}
}

//点击时获取焦点
function foinp(n)
{
	switch(n)
	{
		case 1:
			document.getElementById("QP_QPBH").select();
			break;
		case 2:
			document.getElementById("QP_SCDW").select();
			break;
	}
}