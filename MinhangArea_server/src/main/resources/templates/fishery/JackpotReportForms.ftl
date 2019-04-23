<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>实时在线查询</title>
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
				服务器：
				<select name="server">
						<#list serverList! as server>
							<option value="${server.serverid?c!}">${server.serverid?c!}</option>
						</#list>
				</select>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="查询" onclick="query()" />
				<input type="button" value="总库存曲线统计图" title="totalPool" data-target="#totalPool"  data-toggle="modal"  onclick="totalPool()" />
			</td>
		</tr>
	</table>
	<div id='showData'>
		<table>
			<thead>
				<tr>
					<th colspan="22">
						服务器库存情况
					</th>
				</tr>
				<tr>
					<th width="20%">时间</th>
					<th width="8%">总玩</th>
					<th width="8%">总赢</th>
					<th width="8%">总抽水</th>
					<th width="8%">初始总库存</th>
					<th width="8%">总库存</th>
					<th width="8%">库存误差</th>
					<th width="8%">抽水率</th>
					<th width="8%">抽水误差</th>
					<th width="10%">查看桌子</th>
				</tr>
			</thead>
			<tbody>
			 	<tr v-for="(value,index) in dataList">
			 		<td>{{value.logdate}}</td>
			 		<td>{{value.totalplay}}</td>
					<td>{{value.totalwin}}</td>
					<td>{{value.totalsyspump}}</td>
					<td>{{value.totalinitpool}}</td>
					<td>{{value.totalpool}}</td>
					<td v-if="value.kcwc >= 10 || value.kcwc <= -10">
						<span style="color:red;">{{value.kcwc}}</span>
					</td>
					<td v-else>{{value.kcwc}}</td>
					<td>{{value.syspumpradio}}%</td>
					<td v-if="value.cswc == null">暂无数据</td>
					<td v-else-if="value.cswc >= 5 || value.cswc <= -5">
						<span style="color:red;">{{value.cswc}}%</span>
					</td>
					<td v-else>{{value.cswc}}%</td>
					<td>
						<input type="button" value="查看详情" title="table" data-target="#table"  data-toggle="modal"  @click="tableDetails(value.number)" />
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<#include "../pagination.ftl"/>
	<script type="text/javascript">
		
		var showData = createShowData('showData');
		var pagination = createPagination(showData,'../ReportForms/ServerDetails');
		pagination.pageSize = 19;
		showDataFun(showData,pagination,'../ReportForms/ServerDetails');
		function query(){
			var beginDate = $('[name="beginDate"]').val();
			var endDate = $('[name="endDate"]').val();
			var server = $('[name="server"]').val();
			showDataFun(showData,pagination,'../ReportForms/ServerDetails?beginDate='+beginDate+"&endDate="+endDate+"&server="+server);
		}
		function totalPool(){
			var beginDate = $('[name="beginDate"]').val();
			var endDate = $('[name="endDate"]').val();
			var server = $('[name="server"]').val();
			var title = {
      		text: '服务器库存曲线统计图'   
	  		};
	  		var subtitle = {
	     		text: 'From_Tb:report_server'
	   		};
	   		
	   		var xAxis;
	      		
	      	$.ajax({
				url:"../ReportForms/TotalPoolXAxisList",
				data:{beginDate:beginDate,endDate:endDate,server:server},
				type:"post",
				success:function(obj){
					xAxis = obj;
				},
				dataType:"json",
				async:false
			});
	   		var yAxis = {
	     		title: {
	         	text: '总库存 (分)'
	      		},
	      	plotLines: [{
	         	value: 0,
	         	width: 1,
	         	color: '#808080'
	      		}]
	   		};   
	   		var tooltip = {
	      		shared: false,
            	crosshairs: true,
            	plotOptions: {
            		spline: {
                   		marker: {
                        	radius: 4,
                        	lineColor: '#666666',
                        	lineWidth: 1
                    	}
                	}
            	},
	      		valueSuffix: '分'
	  		};
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
				url:"../ReportForms/TotalPoolDataList",
				data:{beginDate:beginDate,endDate:endDate,server:server},
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
			
			
			$('#totalPoolshow').load('../ReportForms/TotalPool?beginDate='+beginDate+"&endDate="+endDate+"&server="+server);
		}
		
		function tableDetails(number){
			var server = $('[name="server"]').val();
			$('#tableDetails').load('../ReportForms/TableDetails?server='+server+"&number="+number);
		}
	
	</script>
		<div class="modal fade"  id="table" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" style="width:80%">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					</div>
					<div class="modal-body" >
						<div id="tableDetails"></div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-success" data-dismiss="modal" aria-hidden="true">确定</button>
					</div>
				</div>
			</div>
		</div>
		<div class="modal fade"  id="totalPool" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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