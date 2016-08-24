<style>
.dlgfm{ margin:0; padding:10px 30px; padding-bottom:0; }
.dlgfm .divewm{ float:left; margin-left:10px; margin-right:10px; margin-top:10px; font-size:20px; }
.dlgfm .divtms{ margin-top:10px; width:100%; height:210px; border:1px solid #ddd; overflow:auto; }
.dlgfm .divfoot{ margin-top:10px; height:70px; color:red; font-weight:bold; }
.dlgfm .divfoot .le{ float:left; line-height:70px; font-size:100px; }
.dlgfm .divfoot .ri{ float:right; margin-top:15px; }
.dlgfm .divfoot .ri .errts{ height:40px; text-align:right; line-height:40px; font-size:30px; }
.dlgfm .divfoot .ri .zhtm{ width:180px; color:black; text-align:right; font-size:14px; overflow:hidden; }
</style>
<!--dlg-->
<div id="dlg_tm" class="easyui-dialog" style="width:400px; height:450px; padding:10px 10px;" closed="true" modal="true" buttons="#dlg-buttons_tm">
<form id="fm_tm" method="post" novalidate class="dlgfm" style="margin:0; padding:10px 30px; padding-bottom:0;">

	<input type="hidden" id="hidtms">
	<div>
        <div class="divewm">二维码:</div>
        <input id="inptm" name="inptm" class="easyui-textbox" style="height:40px; line-height:40px; width:200px;">
    </div>
	<div id="divtms" class="divtms">
		<div id="divhead"></div>
	</div>
	<div class="divfoot">
		<div id="xssl" class="le">0</div>
		<div class="ri">
			<div id="errts" class="errts"></div>
			<div id="zhtm" class="zhtm"></div>
		</div>
	</div>
    
</form>
</div>
<div id="dlg-buttons_tm">
    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="savetype_tm()">装箱</a>
    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg_tm').dialog('close')">取消</a>
</div>
<!--dlg结束-->
<script>
$(document).ready(function(){ setInpCha(); });

function openDlg(tit)
{
	$('#dlg_tm').dialog('open').dialog('setTitle',tit);
	$('#fm_tm').form('clear');
	$('#inptm').textbox('textbox').focus();
	$('#xssl').html(0);
	$('.re').remove();
}

function setInpCha()
{
	$('#inptm').textbox({
		onChange: function () {
			var tm=$('#inptm').textbox('getValue');
			if(tm)
			{
				var sz=tm.split('_');
				if(sz.length==3)
				{
					var tms=$('#hidtms').val();
					var tmssz=tms.split(',');
					var tmsszzt;
					for(i=0;i<tmssz.length;i++)
					{
						if(tm==tmssz[i]){ tmsszzt=0;break; }else{ tmsszzt=1; }
					}
					if(tmsszzt==0)
					{
						$('#errts').after('<embed src="sound/err.wav"/>');
						$('embed').css('display', 'none');
						$('#errts').html('重复扫描');
						$('#inptm').textbox('setValue','');
						$('#inptm').textbox('textbox').focus();
					}
					else
					{
						var sl=Number($('#xssl').html());
						if(tms)
						{
							xtms=tms+','+tm;
							$('#hidtms').val(xtms);
						}
						else
						{
							$('#hidtms').val(tm);
						}
						$('#errts').after('<embed src="sound/ok.wav"/>');
						$('embed').css('display','none');
						$('#errts').html('');
						$('#inptm').textbox('setValue','');
						$('#inptm').textbox('textbox').focus();
						$('#divhead').append('<div class="re">'+tm+'</div>');
						$('#divtms').scrollTop( $('#divtms')[0].scrollHeight );
						$('#xssl').html(sl+1);
					}
				}
				else
				{
					$('#errts').after('<embed src="sound/err.wav"/>');
					$('embed').css('display','none');
					$('#errts').html('二维码有误');
					$('#inptm').textbox('setValue','');
					$('#inptm').textbox('textbox').focus();
				}
				$('#zhtm').html(tm);
				setTimeout(function(){ $('embed').remove(); },500);
			}			
		}
	});
}
</script>