<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>玩家信息情况查询</title>
<link rel="stylesheet" type="text/css" href="/static/css/css.css" />
<link rel="stylesheet" type="text/css" href="/static/css/page.css" />
<link rel="stylesheet" href="/static/plugins/bootstrap/css/bootstrap.min.css">
<script src="/static/plugins/jQuery/jquery-2.1.1.min.js"></script>
<script src="/static/My97DatePicker/WdatePicker.js"></script>
<script src="/static/plugins/vue/vue-2.6.10.min.js"></script>
<script src="/static/js/custom/vue-pagination.js"></script>
<script src="/static/plugins/bootstrap/js/bootstrap.min.js"></script>
<script src="/static/js/highcharts.js"></script>
</head>
<body>
	<table>
		<tr>
			<td>
				请输入玩家ID:<input type="text" name="userid" />
				<input type="button" value="点击查询"  onclick="PlayerIfmQuery()" />
			</td>
		</tr>
	</table>
	<div id="page"></div>
	<div id="MorePlayIfm"></div>
	<div id="Ifm"></div>
	
	<script type="text/javascript">
		function PlayerIfmQuery(){
			var userid = $('[name="userid"]').val();
			$('#page').load('../PlayerManage/PlayerIfmQuery?userid='+userid);
			$('#MorePlayIfm').load('../PlayerManage/toMorePlayIfm');
			$('#Ifm').load('../PlayerManage/WritePage');
		}
	</script>
</body>
</html>
<style>
    table,table tr th, table tr td { border:1px solid #0094ff; height:30px;}
    table { width: 100%; min-height: 25px; line-height: 25px; text-align: center; border-collapse: collapse;}  
    #title { padding-left:20px} 
    #page{margin:0 auto;border:0px solid #000;width:80%;height:80%} 
    #MorePlayIfm{margin:0 auto;border:0px solid #000;width:80%;} 
    #Ifm{margin:0 auto;border:0px solid #000;width:80%;} 
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
</style>