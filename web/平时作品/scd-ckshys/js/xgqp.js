// JavaScript Document
/*新建气瓶页判断气瓶编号*/
function pdbh()
{
	var qpbh=document.getElementById("QP_QPBH").value;
	if(qpbh.length==12)
	{
		$.post('xjqp_qp_json_get.asp',{ srk:qpbh },function(res){
			if(res.total=='0')
			{
				layer.msg('气瓶未创建');
			}
			else
			{
				document.getElementById('QP_QPBH').value=res.rows[0].QP_QPBH;
				document.getElementById('QP_SCRQ').value=res.rows[0].QP_SCRQ;
				document.getElementById('QP_YXRQ').value=res.rows[0].QP_YXRQ;
				document.getElementById('QP_SCDW').value=res.rows[0].QP_SCDW;
				document.getElementById('QP_GQZL').value=res.rows[0].QP_GQZL;
				document.getElementById('QP_FLID').value=res.rows[0].QP_FLID;
				document.getElementById('QP_YZLX').value=res.rows[0].QP_YZLX;
				//document.getElementById('QP_ZT').value=res.rows[0].QP_ZT;
			}
		},'json');
	}
	else
	{
		layer.msg('气瓶编号位数不正确');
		document.getElementById("QP_QPBH").select();
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