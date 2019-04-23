<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>玩家信息详情</title>
<script src="/static/plugins/jQuery/jquery-2.1.1.min.js"></script>
</head>
<body>
	<form action="../PlayerManage/save" method="post">
		<table>
			<tr>
				<th>
				基本信息：
				</th>
				<th colspan="2">
				</th>
				<th>
					<input type="button" value="修改"  onclick="PlayIfmUpdate()" />
				</th>
			</tr>
			
			
			<tr>
				<th>ID</th>				<td>${playIfm.userId?c!}</td>
				<th>金币</th>			<td>${playIfm.score!}</td>	
			</tr>
			<tr>
				<th>昵称</th>			<td>${playIfm.nickName!}</td>
				<th>钻石</th>			<td>${playIfm.diamond!}</td>
			</tr>
			<tr>
				<th>账号</th>			<td>${playIfm.account!}</td>	
				<th>经验</th>		<td>${playIfm.experience!}</td>
			</tr>
			<tr>
				<th>微信</th>			<td>${playIfm.weiXinId!}</td>
				<th>VIP等级</th>		<td>${playIfm.vip!}</td>
			</tr>
			<tr>
				<th>FaceBook</th>		<td>${playIfm.facebookId!}</td>
				<th>弹头</th>			<td>${playIfm.dantou!}</td>
			</tr>
			<tr>
				<th>手机</th>			<td>${playIfm.mobileNum!}</td>	
				<th>解锁炮倍</th>			<td>${playIfm.lockCannon!}</td>
			</tr>
			<tr>
				<th>二级密码</th>			<td>${playIfm.protectPassword!}</td>
				<th>总充值</th>			<td>${playIfm.infullAmount!}</td>
			</tr>
			<tr>
				<th>国籍</th>			<td>${playIfm.country!}</td>	
				<th>总玩分</th>			<td>${playIfm.playScore!}</td>
			</tr>
			<tr>
				<th>语言</th>			<td>${playIfm.lang!}</td>		
				<th>总赢分</th>			<td>${playIfm.winScore!}</td>
			</tr>
			<tr>
				<th>性别</th>			<td>${playIfm.sex!}</td>		
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
		function PlayIfmUpdate(){
			var userid = $('[name="userid"]').val();
			if(userid == ''){
				alert("未输入用户ID,请输入后重试");
				$('#page').load('../PlayerManage/PlayerIfmQuery?userid='+userid);
			}else{
				$('#page').load('../PlayerManage/toPlayerIfmUpdate?userid='+userid);
			}
		}
	</script>
</body>
</html>
<style>
    table,table tr th, table tr td { border:1px solid #0094ff;width: 25%; }
    table { width: 100%; min-height: 25px; line-height: 25px; text-align: center; border-collapse: collapse;}  
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
</style>