<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>实时在线查询</title>
<link rel="stylesheet" type="text/css" href="/static/css/css.css" />
<script src="/static/js/jquery-1.8.2.min.js"></script>
<script src="/static/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	function poolDetails(table){
		$('#poolDetails').load('../ReportForms/PoolDetails?table='+table);
	}
</script>
</head>
<body>
	<table>
		<tr>
			<th>桌子</th>
			<th>分段</th>
			<th>总玩</th>
			<th>总赢</th>
			<th>抽水</th>
			<th>初始化总库存</th>
			<th>总库存</th>
			<th>库存误差</th>
			<th>查看奖池</th>
		</tr>
		<#list tableDetailsList as td>
			<tr>
				<td>${td.tableid?c!}</td>
				<td>${td.section?c!}</td>
				<td>${td.totalplay?c!}</td>
				<td>${td.totalwin?c!}</td>
				<td>${td.totalsyspump?c!}</td>
				<td>${td.totalinitpool?c!}</td>
				<td>${td.totalpool?c!}</td>
				<td>${td.kcwc?c!}</td>
				<td>
					<input type="button" value="查看详情" onclick="poolDetails(${td.tableid?c!})" />
				</td>
			</tr>
		</#list>
	</table>
	<div id="poolDetails"></div>
</body>
</html>