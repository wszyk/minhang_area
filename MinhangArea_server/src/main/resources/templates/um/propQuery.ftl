<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="/static/plugins/bootstrap/css/bootstrap.min.css">
<script src="/static/plugins/jQuery/jquery-2.1.1.min.js"></script>
<script src="/static/plugins/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
	<table>
		<tr>
			<th>用户ID</th>
			<th>道具ID</th>
			<th>数量</th>
			<th>
				<input type="button" value="添加" title="addProp" data-target="#addProp"  data-toggle="modal"  onclick="addPropPage()" />
			</th>
		</tr>
		<#list propList as p>
			<tr>
				<td>${p.userId?c!}</td>
				<td>${p.propid?c!}</td>
				<td>${p.amount!}</td>
				<td>
					<input type="button" value="修改" title="updateProp" data-target="#updateProp"  data-toggle="modal"  onclick="UpdatePropPage(${p.propid?c!})" />
				</td>
			</tr>
		</#list>
	</table>
	</form>
	<div class="modal fade"  id="addProp" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="width:40%">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				</div>
				<div class="modal-body" >
					<div id="addPropPage"></div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-success" data-dismiss="modal" aria-hidden="true" onclick="saveProp()">保存</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade"  id="updateProp" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="width:40%">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				</div>
				<div class="modal-body" >
					<div id="updatePropPage"></div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-success" data-dismiss="modal" aria-hidden="true" onclick="updateProp()">保存</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function addPropPage(){
			var userid = $('[name="userid"]').val();
			$('#addPropPage').load('../PlayerManage/addPropPage?userid='+userid);
		}
		function UpdatePropPage(propid){
			var userid = $('[name="userid"]').val();
			$('#updatePropPage').load('../PlayerManage/UpdatePropPage?userid='+userid+'&propid='+propid);
		}
		function saveProp(){
			var userid = $('[name="userid"]').val();
			$.ajax({
				url:"../PlayerManage/saveProp",
				data:$("#add").serialize(),
				type:"post",
				success:function(obj){
					if(obj == "ok")
					alert("添加成功");
					$('#Ifm').load('../PlayerManage/propQuery?userid='+userid);
				},
				dataType:"text",
				});
		}
		function updateProp(){
			var userid = $('[name="userid"]').val();
			if(confirm("您已经对信息做了修改，确认保存?")){
				$.ajax({
					url:"../PlayerManage/updateProp",
					data:$("#update").serialize(),
					type:"post",
					success:function(obj){
						if(obj == "ok")
						alert("修改成功");
						$('#Ifm').load('../PlayerManage/propQuery?userid='+userid);
					},
					dataType:"text",
				});
			}
		}
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