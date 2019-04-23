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
			<th colspan="22">下分情况比例信息统计</th>
		</tr>
		<tr>
			<th>总人数</th>
			<th>总上分</th>
			<th>总下分</th>
			<th>下分占比</th>
			<th>上分次数</th>
			<th>下分次数</th>
			<th>下分次数比例</th>
		</tr>
		<#list downScoreList as ds>
			<tr>
				<td>${ds.headCount!}</td>
				<td>${ds.totalUpScore!}</td>
				<td>${ds.totalDownScore!}</td>
				<td>${ds.totalDownScoreRatio!}</td>
				<td>${ds.countUpScore!}</td>
				<td>${ds.countDownScore!}</td>
				<td>${ds.countDownScoreRatio!}</td>
			</tr>
		</#list>
	</table>
</body>
</html>