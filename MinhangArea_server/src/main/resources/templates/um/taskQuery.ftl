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
			<th>任务ID</th>
			<th>进度</th>
			<th>总数量</th>
			<th>状态</th>
			<th>完成日期</th>
			<th>领取日期</th>
			<th></th>
		</tr>
		<#list taskList as t>
			<tr>
				<td>${t.userId?c!}</td>
				<td>${t.taskid?c!}</td>
				<td>${t.progress!}%</td>
				<td>${t.total!}</td>
				<td>${t.status!}</td>
				<td>${t.finishDate!}</td>
				<td>${t.receiveDate!}</td>
				<td>
					<input type="button" value="修改" title="updateTask" data-target="#updateTask"  data-toggle="modal"  onclick="UpdateTaskPage(${t.taskid?c!})" />
				</td>
			</tr>
		</#list>
	</table>
	</form>
	<div class="modal fade"  id="updateTask" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="width:40%">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				</div>
				<div class="modal-body" >
					<div id="updateTaskPage"></div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-success" data-dismiss="modal" aria-hidden="true" onclick="updateTask()">保存</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function UpdateTaskPage(taskid){
			var userid = $('[name="userid"]').val();
			$('#updateTaskPage').load('../PlayerManage/UpdateTaskPage?userid='+userid+'&taskid='+taskid);
		}
		function updateTask(){
			var userid = $('[name="userid"]').val();
			if(confirm("您已经对信息做了修改，确认保存?")){
				$.ajax({
					url:"../PlayerManage/updateTask",
					data:$("#task").serialize(),
					type:"post",
					success:function(obj){
						if(obj == "ok")
						alert("修改成功");
						$('#Ifm').load('../PlayerManage/taskQuery?userid='+userid);
					},
					dataType:"text",
				});
			}
		}
	</script>
</body>
</html>
<style>
    table,table tr th, table tr td { border:1px solid #0094ff;width: 14%; }
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