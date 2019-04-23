<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="/static/plugins/jQuery/jquery-2.1.1.min.js"></script>
</head>
<body>
<form id="add">
	<table>
		<tr>
			<th colspan="2">用户道具信息添加</th>
		</tr>
		<tr>
			<th>用户ID</th>
			<th>
				<input type="hidden" name="userid" value="${userid?c!}" />
				${userid?c!}
			</th>
		</tr>
		<tr>
			<th>道具ID</th>
			<th>
				<input type="text" name="propid" />
			</th>
		</tr>
		<tr>
			<th>道具数量</th>
			<th>
				<input type="text" name="amount" />
			</th>
		</tr>
	<table>
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