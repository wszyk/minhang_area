<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>实时在线查询</title>
<link rel="stylesheet" type="text/css" href="/static/css/css.css" />
<script src="/static/js/jquery-1.8.2.min.js"></script>
<script src="/static/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	
</script>
</head>
<body>
	<table>
		<tr>
			<th>奖池</th>
			<th>总玩</th>
			<th>总赢</th>
			<th>抽水</th>
			<th>初始总库存</th>
			<th>总库存</th>
			<th>库存误差</th>
		</tr>
		<#list poolDetailsList as td>
			<tr>
				<td>${td.poolid!}</td>
				<td>${td.play!}</td>
				<td>${td.win!}</td>
				<td>${td.syspump!}</td>
				<td>${td.initpool!}</td>
				<td>${td.pool!}</td>
				<td>${td.kcwc!}</td>
			</tr>
		</#list>
	</table>
</body>
</html>