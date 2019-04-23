<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="/static/plugins/jQuery/jquery-2.1.1.min.js"></script>
</head>
<body>
	<table border="0" >
		<tr>
			<th>
			更多查询：
			</th>
			<th colspan="4">
			</th>
		</tr>
		<tr>
			<th>道具<input type="button" value="查询"  onclick="propQuery()" /></th>
			<th>充值<input type="button" value="查询"  onclick="topUpQuery()" /></th>
			<th>邮件信息<input type="button" value="查询"  onclick="emailQuery()" /></th>
			<th>任务信息<input type="button" value="查询"  onclick="taskQuery()" /></th>
			<th>好友<input type="button" value="查询"  onclick="friendQuery()" /></th>
		</tr>
	</table>
	<script type="text/javascript">
		function propQuery(){
			var userid = $('[name="userid"]').val();
			$('#Ifm').load('../PlayerManage/propQuery?userid='+userid);
		}
		function topUpQuery(){
			var userid = $('[name="userid"]').val();
			$('#Ifm').load('../PlayerManage/topUpQuery?userid='+userid);
		}
		function emailQuery(){
			var userid = $('[name="userid"]').val();
			$('#Ifm').load('../PlayerManage/emailQuery?userid='+userid);
		}
		function taskQuery(){
			var userid = $('[name="userid"]').val();
			$('#Ifm').load('../PlayerManage/taskQuery?userid='+userid);
		}
		function friendQuery(){
			var userid = $('[name="userid"]').val();
			$('#Ifm').load('../PlayerManage/friendQuery?userid='+userid);
		}
		
	</script>
</body>
</html>
<style>
    table,table tr th, table tr td { border:0px solid #0094ff;width: 20%;height:40px; }
    table { width: 80%; min-height: 25px; line-height: 25px; text-align: center; border-collapse: collapse;}  
    #title { padding-left:20px} 
</style>