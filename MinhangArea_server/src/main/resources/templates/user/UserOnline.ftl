<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>用户在线统计</title>
		<link rel="stylesheet" type="text/css" href="/static/css/css.css" />
		<link rel="stylesheet" type="text/css" href="/static/css/page.css" />
		<script src="/static/My97DatePicker/WdatePicker.js"></script>
		<script src="/static/plugins/jQuery/jquery-2.1.1.min.js"></script>
		<script src="/static/plugins/vue/vue-2.6.10.min.js"></script>
		<script src="/static/js/custom/vue-pagination.js"></script>
		<script src="/static/plugins/highcharts/highcharts.js"></script>
	</head>
	<body>
		<div style="width:99%;height:50%">
			<table>
			<tr>
				<td>
				渠&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;道：
					<select id='channel' name="channel">
						<option value="">--请选择--</option>
						<#list channels! as channel>
              				<option value="${channel?c!}">${channel?c!}</option>
            			</#list>
					</select>
				</td>
				<td>
				语&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;言：
					<select id='lang' name="lang">
						<option value="">--请选择--</option>
						<#list langs! as lang>
              				<option value="${lang!}">${lang!}</option>
            			</#list>
					</select>
				</td>
			</tr>
		<tr>
			<td colspan="2">
				<input type="button" value="查询" onclick="queryUserOnline()" />
			</td>
		</tr>
	</table>
	<!-- showData :vue数据展示标签ID-->
		<div id='showData'>
			<table>
				<thead>
					<tr>
						<th colspan="22">用户列表</th>
					</tr>
					<tr>
						<th style="height:10%">登陆账号</th>
						<th style="height:20%">角色</th>
							<th style="height:20%">管理商圈</th>
						<th style="height:10%">创建时间</th>
						<th style="height:10%">操作</th>
					</tr>
				</thead>
				<tbody>
    			 	<tr v-for="user in users">
    			 		<td>{{user.loginname}}</td>
						<td>{{user.role}}</td>
						<td>{{user.active_user}}</td>
						<td>{{data.top_online}}</td>
						<td>{{data.per_game_time}}</td>
						<td>{{data.log_date}}</td>
    			 	</tr>
				</tbody>
			</table>
		</div>
		<#include "../pagination.ftl"/>
		
		<script type="text/javascript">
			// 初始化table vue，传入table的id
			var showData = createShowData('showData');
			// 初始化分页vue
			var pagination = createPagination(showData,'../ReportForms/userOnlineData');
			pagination.pageSize = 8;
			// 加载数据
			showDataFun(showData,pagination,'../ReportForms/userOnlineData');
			function queryUserOnline(){
				var langVal = $('#lang').val();
				var channelVal = $('#channel').val();
				showDataFun(showData,pagination,'..//sys/user/?channel='+channelVal+'&lang='+langVal);
			}
		</script>
	</div>
	<div style="position:fixed; top:46%; left:0%;">
		<span>
			<lable>类型选择：</lable>
			<select id='dataType' name="dataType">
				<option value="">--请选择--</option>
              	<option value="1">平均时长</option>
            	<option value="2">最高人数</option>
            	<option value="3">活跃人数</option>	
			</select>
		</span>
	</div>
	<div style="position:fixed; top:50%;width:100%;height:40%" id="container"></div>
	<script type="text/javascript">
		function initHighcharts() {
			var title = {
	      			text: '用户在线效果趋势'   
	   			};
	  			 var subtitle = {
	     			text: 'report_online_effect'
	  			 };
	   			var xAxis = {
	  			 };
	  			 var yAxis = {
	      			title: {
	         			text: '平均时长'
	      			},
	  			 };   
				// 折线点提示框内容
	   			var tooltip = {
	      			pointFormatter: function() {
	      				var name = this.series.name;
	      				var nameArr = name.split('_');
	      				var langName = nameArr[0];
	      				var channelName = nameArr[1];
	      				var text = this.series.chart.yAxis[0].userOptions.title.text;
    					return '<span style="color: '+ this.series.color + '">\u25CF</span>日期：<b>'+this.extra+'</b><br/>'
    							+'<span style="color: '+ this.series.color + '">\u25CF</span>语言： <b>'+ langName+'</b><br/>'
    							+'<span style="color: '+ this.series.color + '">\u25CF</span>渠道： <b>'+ channelName+'</b><br/>'
    							+'<span style="color: '+ this.series.color + '">\u25CF</span>'+text+'： <b>'+ this.y+'</b><br/>';
					}
	   			};

	   			var legend = {
	     			 layout: 'vertical',
	     			 align: 'right',
	      			 verticalAlign: 'middle',
	     			 borderWidth: 0
	   			};

	   			var series = new Array();
	   			
	   			var json = {};

				json.title = title;
				json.subtitle = subtitle;
				
				json.yAxis = yAxis;
				json.tooltip = tooltip;
				json.legend = legend;
	   			$.ajax({
	   				type:'GET',
	   				url:'../ReportForms/userOnlineDataLine?dataType=1',
	   				success:function(data){
	   					var jsonStr = JSON.stringify(data);
	   					var dataObj = eval("("+jsonStr+")");
	      				$.each(dataObj,function(i,dataIndex){
	      					if(dataIndex.date == null){
	      						series.push(dataIndex);
	      					}else{
	      						xAxis.categories=dataIndex.date;
	      					}
	      					json.xAxis = xAxis;
	      					json.series = series;
	      				});
	   				},
	   				dataType:'json',
	   				async:false
	  			}); 
	   		$('#container').highcharts(json);
	   		
	   		$('#dataType').change(function(){
	   			var dataType = $('#dataType').val();
	   			var text = $("#dataType").find("option:selected").text(); 
	   			yAxis.title={text:text};
	   			series = [];
	   			$.ajax({
	   				type:'GET',
	   				url:'../ReportForms/userOnlineDataLine?dataType='+dataType,
	   				success:function(data){
	   					var jsonStr = JSON.stringify(data);
	   					var dataObj = eval("("+jsonStr+")");
	      				$.each(dataObj,function(i,dataIndex){
	      					if(dataIndex.date == null){
	      						series.push(dataIndex);
	      					}else{
	      						xAxis.categories=dataIndex.date;
	      					}
	      					json.xAxis = xAxis;
	      					json.series = series;
	      					$('#container').highcharts(json);
	      				});
	   				},
	   				dataType:'json',
	   				async:false
	  			}); 
	   		});
		}
		$(document).ready(initHighcharts);
		</script>
	</body>
</html>