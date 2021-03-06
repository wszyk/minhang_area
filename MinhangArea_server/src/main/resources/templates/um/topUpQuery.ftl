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
			<th>计费点名称</th>
			<th>购买次数</th>
			<th>购买日期</th>
			<th>领取日期</th>
		</tr>
		<#list topUpList as t>
			<tr>
				<td>${t.userId?c!}</td>
				<td>${t.pointName!}</td>
				<td>${t.buyCount!}</td>
				<td>${t.buyDate!}</td>
				<td>${t.receiveDate!}</td>
			</tr>
		</#list>
	</table>
	</form>
	
	<script type="text/javascript">
		
	</script>
</body>
</html>
<style>
    table,table tr th, table tr td { border:1px solid #0094ff;width: 20%; }
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