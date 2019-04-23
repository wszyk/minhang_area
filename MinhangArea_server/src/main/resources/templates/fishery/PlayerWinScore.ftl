<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>玩家分数查询</title>
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
				开始日期：<input type="text" name="beginDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				结束日期：<input type="text" name="endDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="查询" onclick="playerWinScoreList()" />
			</td>
		</tr>
		
	</table>
	<div id='showData'>
		<table>
			<thead>
				<tr>
					<th colspan="22">玩家赢分信息详情</th>
				</tr>
				<tr>
					<th width="20%">玩家ID</th>
					<th width="20%">总玩分</th>
					<th width="20%">总赢分</th>
					<th width="20%">累计净赢分</th>
					<th width="20%">查看玩家分数曲线</th>
			</tr>
			</thead>
			<tbody>
			 	<tr v-for="(value, index)  in dataList">
			 		<td>{{value.userid}}</td>
			 		<td>{{value.totalplayscore}}</td>
					<td>{{value.totalwinscore}}</td>
					<td>{{value.addup}}</td>
					<td>
						<input type="button" value="点击查看曲线图" title="qxt" data-target="#qxt"  data-toggle="modal"   @click="playerWinScoreReportForms(value.userid)"  />
					</td>
			 	</tr>
			</tbody>
		</table>
	</div>
	<#include "../pagination.ftl"/>
	<div class="modal fade"  id="qxt" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" style="width:80%">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					</div>
					<div class="modal-body" >
						<div id="container" style="width: 100%; height: 100%; margin: 0 auto"></div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-success" data-dismiss="modal" aria-hidden="true">确定</button>
					</div>
				</div>
			</div>
		</div>
	
	
	<script type="text/javascript">
		var showData = createShowData('showData');
		var pagination = createPagination(showData,'../ReportForms/playerWinScoreList');
		pagination.pageSize = 19;
		showDataFun(showData,pagination,'../ReportForms/playerWinScoreList');
		function playerWinScoreList(){
			var beginDate = $('[name="beginDate"]').val();
			var endDate = $('[name="endDate"]').val();
			showDataFun(showData,pagination,'../ReportForms/playerWinScoreList?beginDate='+beginDate+"&endDate="+endDate);
		}
        function playerWinScoreReportForms(id) {
			var beginDate = $('[name="beginDate"]').val();
			var endDate = $('[name="endDate"]').val();
	 		var title = {
	      		text: '玩家累计净赢分情况统计'   
	  		};
	  		var subtitle = {
	     		text: 'From_Tb:game_score_log'
	   		};
	   		var xAxis;
	      		
	      	$.ajax({
				url:"../ReportForms/playerWinScoreXAxisList",
				data:{beginDate:beginDate,endDate:endDate,id:id},
				type:"post",
				success:function(obj){
					xAxis = obj;
				},
				dataType:"json",
				async:false
			});
	   		var yAxis = {
	     		title: {
	         	text: ' 累计净赢分Score(分)'
	      		},
	      	plotLines: [{
	         	value: 0,
	         	width: 1,
	         	color: '#808080'
	      		}]
	   		};   
	   		var tooltip = {
	      		valueSuffix: '分'
	  		}
	   		var legend = {
	      		layout: 'vertical',
	     		 align: 'right',
	      		verticalAlign: 'middle',
	      		borderWidth: 0
	   		};
	   		
			var series;
			
			var language = "";
			$(".language:checked").each(function(){
				language+= ","+$(this).val();
			});
			language = language.substring(1);
			
			var channel = "";
			$(".channel:checked").each(function(){
				channel+= ","+$(this).val();
			});
			channel = channel.substring(1);
			
			$.ajax({
				url:"../ReportForms/playerWinScoreDataList",
				data:{beginDate:beginDate,endDate:endDate,id:id},
				type:"post",
				success:function(obj){
					series = obj;
				},
				dataType:"json",
				async:false
			});
	   		var json = {};
	   		json.title = title;
	   		json.subtitle = subtitle;
	   		json.xAxis = xAxis;
	   		json.yAxis = yAxis;
	   		json.tooltip = tooltip;
	   		json.legend = legend;
	   		json.series = series;
	   		$('#container').highcharts(json);
        }
	</script>
</body>
</html>
<style>
	.page { 
    font-weight: 900; 
    height: 40px; 
    text-align: center; 
    color: #888; 
    margin: 20px auto 0; 
    background: white; 
    position:fixed; top:78%; left:25%;
  	} 
  	 table,table tr th, table tr td { height:29px; }
</style>