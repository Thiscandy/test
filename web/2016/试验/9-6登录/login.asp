<!DOCTYPE html>
<html>
<head>
	<title>登 录</title>
	<meta charset="utf-8">
	<link rel="stylesheet" type="text/css" href="css/login.css">
	<!--#include file="class/headconfig.asp"-->
	<style>
		body { margin: 0;padding: 0;font-family: Tahoma, Helvetica, "Microsoft Yahei", 微软雅黑, Arial, STHeiti; }
		.wrapper { background: #fff;height:auto;height: 100%;line-height: 100%;width: 920px;margin: 0 auto; }
		.header { padding-top: 40px; }
		.main { margin-top: 50px;width: 920px;padding-bottom: 40px;background: url(images/login.jpg) no-repeat 0 center;height: 400px; }
		#form1 { border:1px solid #dedede;box-shadow: 0 0 5px rgba(0,0,0,0.3); }
		.form_header {
		  text-align: center;
		  height: 46px;
		  line-height: 46px;
		  background-color: #eff4f8;
		  border-bottom: 1px solid #c1d4da;
		}
		.form_header span {
		  font-family: 微软雅黑;
		  font-size: 19px;
		  color: #000;
		}
		#form1 p {
		  margin-top: 22px;
		}
		.form_body_up {
		  padding: 1px 25px;
		  height: 230px;
		  border-bottom: 1px solid #c1d4da;
		}
		.form_body_off {
		  padding: 15px 25px;
		  border-top: 1px solid #fff;
		  background-color: #eff4f8;
		  height: 40px;
		}
		.login_item {
		  padding:6px;
		  background-color: #fff;
		  border: 1px solid #d1d9db;
		  border-radius: 2px;
		  box-shadow: 1px 2px 2px rgba(0,0,0,0.1)
		}
		.form_body_off input {
		  float: left;
		  margin: 12px 0 -18px;
		  width: 13px;
		  height: 13px;
		}
		.form_body_off label {
		  float: left;
		  font-size: 14px;
		  margin-left: 12px;
		  margin-top: 9px;
		}
		input {
		  font-family: 'Lucida Grande', Tahoma, Verdana, sans-serif;
		  font-size: 14px;
		}

		input[type=text], input[type=password] {
		  margin: 5px;
		  padding: 0 10px;
		  width: 200px;
		  height: 34px;
		  color: #404040;
		  background: white;
		  border: 1px solid;
		  border-color: #c4c4c4 #d1d1d1 #d4d4d4;
		  border-radius: 2px;
		  box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.12);
		}
		input[type=text]:focus, input[type=password]:focus {
		  border-color: #7dc9e2;
		  outline-color: #dceefc;
		  outline-offset: 0;
		}

		input[type=submit] {
		  margin-top: 5px;
		  float: right;
		  width: 120px;
		  height: 29px;
		  font-size: 12px;
		  font-weight: bold;
		  color: #527881;
		  text-shadow: 0 1px #e3f1f1;
		  background: #cde5ef;
		  border: 1px solid;
		  border-color: #b4ccce #b3c0c8 #9eb9c2;
		  border-radius: 16px;
		  outline: 0;
		  -webkit-box-sizing: content-box;
		  -moz-box-sizing: content-box;
		  box-sizing: content-box;
		  background-image: -webkit-linear-gradient(top, #edf5f8, #cde5ef);
		  background-image: -moz-linear-gradient(top, #edf5f8, #cde5ef);
		  background-image: -o-linear-gradient(top, #edf5f8, #cde5ef);
		  background-image: linear-gradient(to bottom, #edf5f8, #cde5ef);
		  -webkit-box-shadow: inset 0 1px white, 0 1px 2px rgba(0, 0, 0, 0.15);
		  box-shadow: inset 0 1px white, 0 1px 2px rgba(0, 0, 0, 0.15);
		}
		input[type=submit]:active {
		  background: #cde5ef;
		  border-color: #9eb9c2 #b3c0c8 #b4ccce;
		  -webkit-box-shadow: inset 0 0 3px rgba(0, 0, 0, 0.2);
		  box-shadow: inset 0 0 3px rgba(0, 0, 0, 0.2);
		}
		.right { float: right;width: 320px;margin-top: 40px; }
		.footer { position: absolute;bottom: 0;left: 50%;margin: 0;height: 40px;width: 120px;margin-left: -65px;line-height: 40px;color: #7a77c8;text-align: center;font-size: 14px; }

	</style>
</head>
<body>
	<div class="wrapper">
		<div class="header">
			<img src="images/logo2.png">
		</div>
		<div class="main">
			<div class="right">
				<form id="form1">
					<div class="form_header">
						<span>登 录 益 腾</span>
					</div>
					<div class="form_body_body">
						<div class="form_body_up">
								<p><span style="margin-right:10px;"></span><input type="text" id="name" name="name" value="<%=request.Cookies("useryt2016")%>" placeholder="请输入操作员帐号" autofocus required></p>
								<p><span style="margin-right:10px;"></span><input type="password" id="password" name="password" value="<%=request.Cookies("pwyt2016")%>" placeholder="请输入操作员密码" required></p>
						</div>
						<div class="form_body_off">
							<input type="checkbox" name="ckjzmm" value="jzmm" checked />
							<label>记住密码</label>
							<input type="submit" id="login" value="登 录" />
						</div>
					</div>
				</form>
			</div>
		</div>
		<div class="footer">
			<div class="box">2016&nbsp;©益腾软件</div>
		</div>
	</div>
</body>
</html>