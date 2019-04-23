<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="/static/plugins/jQuery/jquery-2.1.1.min.js"></script>
</head>
<body>
	<table>
		<tr>
			<th>用户ID</th>
			<th>类型</th>
			<th>发送用户ID</th>
			<th>发送用户名</th>
			<th>发送内容</th>
			<th>状态</th>
			<th>发邮件日期</th>
			<th>失效日期</th>
			<th>系统邮件ID</th>
			<th>比赛排行奖励日志ID</th>
		</tr>
		<#list emailList as e>
			<tr>
				<td>${e.userId?c!}</td>
				<td>${e.type!}</td>
				<td>${e.sendId!}</td>
				<td>${e.sendName!}</td>
				<td>${e.content!}</td>
				<td>${e.status!}</td>
				<td>${e.logDate!}</td>
				<td>${e.invalidDate!}</td>
				<td>${e.sysMailId!}</td>
				<td>${e.matchRankLogId!}</td>
			</tr>
		</#list>
	</table>
	</form>
	
	<script type="text/javascript">
		
	</script>
</body>
</html>
<style>
    table,table tr th, table tr td { border:1px solid #0094ff;width: 10%; }
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