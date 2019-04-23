<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>实时在线查询</title>
<link rel="stylesheet" type="text/css" href="/static/css/css.css" />
<link rel="stylesheet" type="text/css" href="/static/css/page.css" />
<script src="/static/plugins/jQuery/jquery-2.1.1.min.js"></script>
<script src="/static/My97DatePicker/WdatePicker.js"></script>
<script src="/static/plugins/vue/vue-2.6.10.min.js"></script>
<script src="/static/js/custom/vue-pagination.js"></script>

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
				<select name="server" id="content">
						<option value="">请选择</option>
						<#list serverList! as server>
							<option value="${server.serverid?c!}">${server.serverid?c!}</option>
						</#list>
				</select>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				桌子ID：
				<select name="table">
					<option value="">请选择</option>
						<#list tableList! as table>
							<option value="${table.tableid?c!}">${table.tableid?c!}</option>
						</#list>
				</select>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				椅子尾号：
				<select name="chair" class="zxc" >
					<option value="">请选择</option>
					<option value="9">9</option>
					<option value="8">8</option>
					<option value="7">7</option>
					<option value="6">6</option>
					<option value="5">5</option>
					<option value="4">4</option>
					<option value="3">3</option>
					<option value="2">2</option>
					<option value="1">1</option>
					<option value="0">0</option>
				</select>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="查询" onclick="downScore()" />
			</td>
		</tr>
	</table>
	<div id="downScore">
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
			<#list downScoreList! as ds>
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
	</div>
	<div id='showData'>
		<table>
			<thead>
				<tr>
					<th colspan="22">下分信息详情</th>
				</tr>
				<tr>
					<th width="20%">玩家ID</th>
					<th width="20%">服务器ID</th>
					<th width="20%">桌子ID</th>
					<th width="20%">椅子ID</th>
					<th width="20%">下分</th>
				</tr>
			</thead>
			<tbody>
			 	<tr v-for="(value,index) in dataList">
			 		<td>{{value.userid}}</td>
			 		<td>{{value.serverid}}</td>
					<td>{{value.tableid}}</td>
					<td>{{value.chairid}}</td>
					<td>{{value.downscore}}</td>
			 	</tr>
			</tbody>
		</table>
	</div>
	<#include "../pagination.ftl"/>
	<script type="text/javascript">
		var showData = createShowData('showData');
		var pagination = createPagination(showData,'../ReportForms/DownScoreDetails');
		pagination.pageSize = 17;
		showDataFun(showData,pagination,'../ReportForms/DownScoreDetails');
		function downScore(){
			var beginDate = $('[name="beginDate"]').val();
			var endDate = $('[name="endDate"]').val();
			var server = $('[name="server"]').val();
			var table = $('[name="table"]').val();
			var chair = $('[name="chair"]').val();
			$('#downScore').load('../ReportForms/DownScore?beginDate='+beginDate+"&endDate="+endDate+"&server="+server+"&table="+table+"&chair="+chair);
			showDataFun(showData,pagination,'../ReportForms/DownScoreDetails?beginDate='+beginDate+"&endDate="+endDate+"&server="+server+"&table="+table+"&chair="+chair);
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
    background: #f3f3f4; 
    position:fixed; top:78%; left:25%;
    
  	} 
</style>