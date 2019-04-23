<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>实时在线查询</title>
<link rel="stylesheet" type="text/css" href="/static/css/css.css" />
<script src="/static/js/jquery-1.8.2.min.js"></script>
<script src="/static/js/highcharts.js"></script>
<script type="text/javascript">
	$(function() {
   		var title = {
      		text: '实时在线人数统计'   
  		};
  		var subtitle = {
     		text: 'From_Tb:report_realtimeonline'
   		};
   		var chart = {
			type: 'line',
			zoomType: 'x',
			panning: true,
			panKey: 'shift'
		}; 
   		var xAxis;
      		
      	$.ajax({
			url:"../ReportForms/FirstTimeList",
			type:"post",
			success:function(obj){
				xAxis = obj;
			},
			dataType:"json",
			async:false
		});
   		var yAxis = {
     		title: {
         	text: '在线人数 (人)'
      		},
      	plotLines: [{
         	value: 0,
         	width: 1,
         	color: '#808080'
      		}]
   		};   
   		var tooltip = {
      		valueSuffix: '人',
      		crosshairs: [{            // 设置准星线样式
         	width: 3,
          	color: '#006cee',
          	dashStyle: 'dashdot',
          	zIndex: 100 
        	}, {
        	width: 1,
          	color: "#006cee",
          	dashStyle: 'longdashdot',
          	zIndex: 100 
     	 	}]
  		}
   		var legend = {
      		layout: 'vertical',
     		 align: 'right',
      		verticalAlign: 'middle',
      		borderWidth: 0
   		};
   		
		var series;
		$.ajax({
			url:"../ReportForms/FirstDataList",
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
   		json.chart = chart;
   		$('#container').highcharts(json);
  });
	//渠道全选
	function cqx(){
		$(".channel").attr("checked",true);
	}
	//渠道全不选
	function cqbx(){
		$(".channel").attr("checked",false);
	}
	//渠道反选
	function cfx(){
		$(".channel").each(function(){
			$(this).attr("checked",!$(this).attr("checked"));
		});
	}
	//语言全选
	function lqx(){
		$(".language").attr("checked",true);
	}
	//语言全不选
	function lqbx(){
		$(".language").attr("checked",false);
	}
	//语言反选
	function lfx(){
		$(".language").each(function(){
			$(this).attr("checked",!$(this).attr("checked"));
		});
	}
	//条件查询
	function Query(){
 		var title = {
      		text: '实时在线人数统计'   
  		};
  		var subtitle = {
     		text: 'From_Tb:report_realtimeonline'
   		};
   		var chart = {
			type: 'line',
			zoomType: 'x',
			panning: true,
			panKey: 'shift'
		}; 
		
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
		
   		var xAxis;
      	
      	$.ajax({
			url:"../ReportForms/TimeList",
			data:{language:language,channel:channel},
			type:"post",
			success:function(obj){
				xAxis = obj;
			},
			dataType:"json",
			async:false
		});
   		var yAxis = {
     		title: {
         	text: '在线人数 (人)'
      		},
      	plotLines: [{
         	value: 0,
         	width: 1,
         	color: '#808080'
      		}]
   		}; 
   		
   		var tooltip = {
      		valueSuffix: '人',
      		crosshairs: [{            // 设置准星线样式
         	width: 3,
          	color: '#006cee',
          	dashStyle: 'dashdot',
          	zIndex: 100 
        	}, {
        	width: 1,
          	color: "#006cee",
          	dashStyle: 'longdashdot',
          	zIndex: 100 
     	 	}]
  		}
   		var legend = {
      		layout: 'vertical',
     		 align: 'right',
      		verticalAlign: 'middle',
      		borderWidth: 0
   		};
   		
		var series;
		
		$.ajax({
			url:"../ReportForms/conditionDataList",
			data:{language:language,channel:channel},
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
   		json.chart = chart;
   		$('#container').highcharts(json);
	}	
</script>

</head>

<body>
	<table>
		<tr>
			<div id="container" style="width: 100%; height: 100%; margin: 0 auto"></div>
		</tr>
		<tr>
			<td>
				渠道：
			</td>	
			<td>
				<#list AllChannelList as channel>
					<input type="checkbox" class="channel" value="${channel.chan!}" />${channel.chan!}
				</#list>
			</td>	
			<td>
				<input type="button" value="全选"  onclick="cqx()"/>
				<input type="button" value="全不选"  onclick="cqbx()"/>
				<input type="button" value="反选"  onclick="cfx()"/>
			</td>
		</tr>
		<tr>
			<td>
				语言：
			</td>
			<td>
				<#list AllLanguageList as language>
					<input type="checkbox" class="language" value="${language.lang!}" />${language.lang!}
				</#list>
			</td>	
			<td>
				<input type="button" value="全选"  onclick="lqx()"/>
				<input type="button" value="全不选"  onclick="lqbx()"/>
				<input type="button" value="反选"  onclick="lfx()"/>
			</td>
		</tr>
		<tr>
			<td colspan="22" >
				<input type="button" onclick="Query()" value="查询" />
			</td>
		</tr>
	</table>
	
</body>
</html>