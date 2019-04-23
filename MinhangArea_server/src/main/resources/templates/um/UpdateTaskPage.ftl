<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script src="/static/plugins/jQuery/jquery-2.1.1.min.js"></script>
<script src="/static/My97DatePicker/WdatePicker.js"></script>
<script src="/static/My97DatePicker/calendar.js"></script>
</head>
<body>
<form id="task">
	<table>
		<tr>
			<th colspan="2">用户任务信息修改</th>
		</tr>
		<tr>
			<th>用户ID</th>
			<th>
				<input type="hidden" name="userid" value="${task.userid?c!}" />
				${task.userid?c!}
			</th>
		</tr>
		<tr>
			<th>任务ID</th>
			<th>
				<input type="hidden" name="taskid" value="${task.taskid?c!}" />
				${task.taskid?c!}
			</th>
		</tr>
		<tr>
			<th>进度</th>
			<th>
				<input type="text" name="progress" value="${task.progress!}" />
			</th>
		</tr>
		<tr>
			<th>总数量</th>
			<th>
				<input type="text" name="total" value="${task.total?c!}" />
			</th>
		</tr>
		<tr>
			<th>状态</th>
			<th>
				<select name="status">
					<option value="0">新任务</option>
					<option value="1">完成</option>
					<option value="2">领取奖励</option>
				</select>
			</th>
		</tr>
		<tr>
			<th>完成日期</th>
			<th>
				<input type="text" name="finishDate" value="${task.finishDate!}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
			</th>
		</tr>
		<tr>
			<th>领取日期</th>
			<th>
				<input type="text" name="receiveDate" value="${task.receiveDate!}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
			</th>
		</tr>
	<table>
<form>
	<script type="text/javascript">
		$(function(){
			$("option[value=${task.status!}]").attr("selected",true);
		});
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