<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>玩家信息修改</title>
<script src="/static/plugins/jQuery/jquery-2.1.1.min.js"></script>
</head>
<body>
	<form>
		<table>
			<tr>
				<th>
				基本信息：
				</th>
				<th colspan="2">
				</th>
				<th>
					<input type="button" value="保存"  onclick="save()" />
					<input type="button" value="取消"  onclick="back()" />
				</th>
			</tr>
			<tr>
				<input type="hidden" name="userId" value="${playIfm.userId?c!}" />
				<th>ID</th>			<td>${playIfm.userId?c!}</td>
				<th>金币</th>			<td><input type="text" name="score" value="${playIfm.score?c!}" /></td>	
			</tr>
			<tr>
				<th>昵称</th>			<td><input type="text" name="nickName" value="${playIfm.nickName!}" /></td>
				<th>钻石</th>			<td><input type="text" name="diamond" value="${playIfm.diamond?c!}" /></td>
			</tr>
			<tr>
				<th>账号</th>			<td><input type="text" name="account" value="${playIfm.account!}" /></td>	
				<th>经验</th>		<td><input type="text" name="experience" value="${playIfm.experience?c!}" /></td>
			</tr>
			<tr>
				<th>微信</th>			<td><input type="text" name="weiXinId" value="${playIfm.weiXinId!}" /></td>
				<th>VIP积分</th>		<td><input type="text" name="vipIntegral" value="${playIfm.vipIntegral?c!}" /></td>
			</tr>
			<tr>
				<th>FaceBook</th>		<td><input type="text" name="facebookId" value="${playIfm.facebookId!}" /></td>
				<th>弹头</th>			<td><input type="text" name="dantou" value="${playIfm.dantou?c!}" /></td>
			</tr>
			<tr>
				<th>手机</th>			<td><input type="text" name="mobileNum" value="${playIfm.mobileNum!}" /></td>	
				<th>解锁炮倍</th>			<td>
											<select name="lockCannon">
												<option value="1">炮倍倍数-1</option>
												<option value="2">炮倍倍数-2</option>
												<option value="3">炮倍倍数-3</option>
												<option value="4">炮倍倍数-4</option>
												<option value="6">炮倍倍数-6</option>
												<option value="8">炮倍倍数-8</option>
												<option value="10">炮倍倍数-10</option>
												<option value="15">炮倍倍数-15</option>
												<option value="20">炮倍倍数-20</option>
												<option value="25">炮倍倍数-25</option>
												<option value="30">炮倍倍数-30</option>
												<option value="35">炮倍倍数-35</option>
												<option value="40">炮倍倍数-40</option>
												<option value="45">炮倍倍数-45</option>
												<option value="50">炮倍倍数-50</option>
												<option value="60">炮倍倍数-60</option>
												<option value="70">炮倍倍数-70</option>
												<option value="80">炮倍倍数-80</option>
												<option value="90">炮倍倍数-90</option>
												<option value="100">炮倍倍数-100</option>
												<option value="120">炮倍倍数-120</option>
												<option value="140">炮倍倍数-140</option>
												<option value="160">炮倍倍数-160</option>
												<option value="180">炮倍倍数-180</option>
												<option value="200">炮倍倍数-200</option>
												<option value="250">炮倍倍数-250</option>
												<option value="300">炮倍倍数-300</option>
												<option value="350">炮倍倍数-350</option>
												<option value="400">炮倍倍数-400</option>
												<option value="450">炮倍倍数-450</option>
												<option value="500">炮倍倍数-500</option>
												<option value="550">炮倍倍数-550</option>
												<option value="600">炮倍倍数-600</option>
												<option value="650">炮倍倍数-650</option>
												<option value="700">炮倍倍数-700</option>
												<option value="750">炮倍倍数-750</option>
												<option value="800">炮倍倍数-800</option>
												<option value="850">炮倍倍数-850</option>
												<option value="900">炮倍倍数-900</option>
												<option value="950">炮倍倍数-950</option>
												<option value="1000">炮倍倍数-1000</option>
												<option value="1100">炮倍倍数-1100</option>
												<option value="1200">炮倍倍数-1200</option>
												<option value="1300">炮倍倍数-1300</option>
												<option value="1400">炮倍倍数-1400</option>
												<option value="1500">炮倍倍数-1500</option>
												<option value="1600">炮倍倍数-1600</option>
												<option value="1700">炮倍倍数-1700</option>
												<option value="1800">炮倍倍数-1800</option>
												<option value="1900">炮倍倍数-1900</option>
												<option value="2000">炮倍倍数-2000</option>
											</select>
										</td>
			</tr>
			<tr>
				<th>二级密码</th>			<td><input type="text" name="protectPassword" value="${playIfm.protectPassword!}" /></td>
				<th>总充值</th>			<td>${playIfm.infullAmount!}</td>
			</tr>
			<tr>
				<th>国籍</th>			<td><input type="text" name="country" value="${playIfm.country!}" /></td>	
				<th>总玩分</th>			<td>${playIfm.playScore!}</td>
			</tr>
			<tr>
				<th>语言</th>			<td><input type="text" name="lang" value="${playIfm.lang!}" /></td>		
				<th>总赢分</th>			<td>${playIfm.winScore!}</td>
			</tr>
			<tr>
				<th>性别</th>			<td><input type="text" name="sex" value="${playIfm.sex!}" /></td>		
				<th>总玩时长</th>			<td>${playIfm.playTime!}</td>	
			</tr>
			<tr>
				<th>代理平台</th>			<td>${playIfm.platform!}</td>	
				<th>注册IP</th>			<td>${playIfm.registerIp!}</td>	
			</tr>
			<tr>
				<th>渠道</th>			<td>${playIfm.channel!}</td>	
				<th>注册时间</th>			<td>${playIfm.registerTime!}</td>
			</tr>
			<tr>
				<th>手机ID</th>			<td>${playIfm.mobileId!}</td>	
				<th>注册版本</th>			<td>${playIfm.version!}</td>
			</tr>
		</table>
	</form>
	
	<script type="text/javascript">
		$(function(){
			$("option[value=${playIfm.lockCannon?c!}]").attr("selected",true);
		});
		function back(){
			var userid = $('[name="userid"]').val();
			$('#page').load('../PlayerManage/PlayerIfmQuery?userid='+userid);
		}
		function save(){
			var userid = $('[name="userid"]').val();
			if(confirm("您已经对信息做了修改，是否保存?")){
				$.ajax({
				url:"../PlayerManage/save",
				data:$("form").serialize(),
				type:"post",
				success:function(obj){
					if(obj == "ok")
					alert("修改成功");
					$('#page').load('../PlayerManage/PlayerIfmQuery?userid='+userid);
				},
				dataType:"text",
				});
			}
		}
		
	</script>
</body>
</html>
<style>
    table,table tr th, table tr td { border:1px solid #0094ff;width: 25%; }
    table { width: 80%; min-height: 25px; line-height: 25px; text-align: center; border-collapse: collapse;}  
    #title { padding-left:20px} 
    input[type="text"],input[type="password"] {
	width:250px;
	border: solid #ccc 2px;
	-webkit-border-radius: 6px;
	border-radius: 6px;
	-webkit-box-shadow: 0 1px 1px #ccc;
	box-shadow: 0 1px 1px #ccc;
	background: #efefef;
	margin: 0 2px 0;
	text-indent: 5px;
	}
	select {
	width:250px;
	border: solid #ccc 2px;
	-webkit-border-radius: 6px;
	border-radius: 6px;
	-webkit-box-shadow: 0 1px 1px #ccc;
	background: #efefef;
	margin: 0 2px 0;
	text-indent: 5px;
	}
</style>