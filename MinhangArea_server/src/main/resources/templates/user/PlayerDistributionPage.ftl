<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>玩家分布</title>
<link rel="stylesheet" type="text/css" href="/static/css/css.css" />
<link rel="stylesheet" type="text/css" href="/static/css/page.css" />
<link rel="stylesheet" href="/static/plugins/bootstrap/css/bootstrap.min.css">
<script src="/static/plugins/jQuery/jquery-2.1.1.min.js"></script>
<script src="/static/My97DatePicker/WdatePicker.js"></script>
<script src="/static/plugins/vue/vue-2.6.10.min.js"></script>
<script src="/static/js/custom/vue-pagination.js"></script>
<script src="/static/js/highcharts.js"></script>
<script src="/static/plugins/bootstrap/js/bootstrap.min.js"></script>

</head>

<body>
	<table>
		<tr>
			<td>
				开始日期：<input type="text" name="beginDate" onclick="WdatePicker()" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				结束日期：<input type="text" name="endDate" onclick="WdatePicker()" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				查询信息:
					<select name="content">
						<option value="0">玩家-等级分布</option>
						<option value="1">玩家-炮倍分布</option>
						<option value="2">玩家-游戏风格</option>
						<option value="3">玩家-游戏时长</option>
						<option value="4">玩家-货币数量</option>
					</select>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="查询数据及曲线图" onclick="QueryDataANDGraph()" />
			</td>	
		</tr>
	</table>
	<div id='showData'></div>
	<div id="container" style="position:fixed; bottom: 25%; border: 1px solid blue;width: 100%;height: 35%;"></div>
	<div id="container2" style="position:fixed; bottom: 1%; border: 1px solid red;width: 100%;height: 24%;"></div>
	<div class="modal fade"  id="QueryGraph" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="width:40%">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				</div>
				<div class="modal-body" >
					<div id="GraphContainer" style="min-width:400px;height:400px"></div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-success" data-dismiss="modal" aria-hidden="true">确定</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade"  id="QueryGraph2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="width:40%">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				</div>
				<div class="modal-body" >
					<div id="GraphContainer2" style="min-width:400px;height:400px"></div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-success" data-dismiss="modal" aria-hidden="true">确定</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
	var num;
	var rows;
	var totalPage;//总页数
	var totalPage;//总页数
	var pageSize = 9;//每页显示行数
	//***************************************************预加载函数（等级报表以及曲线图）*************************************************
	$(function(){
		var html = '<table>' 
		+ '<tr><th>日期</th>'
		+ '<th>1-20</th>'
		+ '<th>21-40</th>'
		+ '<th>41-60</th>'
		+ '<th>61-80</th>'
		+'<th>81-100</th>'
		+ '<th>101-120</th>'
		+ '<th>121-140</th>'
		+ '<th>141-160</th>'
		+ '<th>161-180</th>'
		+ '<th>181-200</th>'
		+ '<th></th></tr><tbody id="pageInfo">'

		$.ajax({
			url:"../ReportForms/levelDistribution",
			type:"post",
			success:function(obj){
				num = obj.rows;
				
				$.each(obj.list, function(commentIndex, comment){	
					html += '<tr><td>'+comment.date+'</td>'
							 + '<td>'+comment.level1+'</td>'
							 + '<td>'+comment.level2+'</td>'
							 + '<td>'+comment.level3+'</td>'
							 + '<td>'+comment.level4+'</td>'
							 + '<td>'+comment.level5+'</td>'
							 + '<td>'+comment.level6+'</td>'
							 + '<td>'+comment.level7+'</td>'
							 + '<td>'+comment.level8+'</td>'
							 + '<td>'+comment.level9+'</td>'
							 + '<td>'+comment.level10+'</td>'
							 + '<td><input type="button" name="'+comment.date+'" title="QueryGraph" data-target="#QueryGraph"  data-toggle="modal"  value="查看饼图" onclick="QueryLevelGraph(this)"/></td></tr>'
					}); 
				   html += '</tbody></table><div id="barcon" style="position:fixed; bottom: 65%;width: 100%;height: 2%;text-align:center;"></div>'; 
				   $('#showData').html(html);
				   
				   itable = document.getElementById("pageInfo");
				    //总共分几页
				    if(num/pageSize > parseInt(num/pageSize)){
				        totalPage=parseInt(num/pageSize)+1;
				    }else{
				        totalPage=parseInt(num/pageSize);
				    }
				    var currentPage = 1;//当前页数
				    var startRow = (currentPage - 1) * pageSize+1;//开始显示的行  31
				    var endRow = currentPage * pageSize;//结束显示的行   40
				    endRow = (endRow > num)? num : endRow;    //40
				    console.log(endRow);
				    //遍历显示数据实现分页
				    for(var i=1;i<(num+1);i++){
				        var irow = itable.rows[i-1];
				        if(i>=startRow && i<=endRow){
				            irow.style.display = "table-row";
				        }else{
				            irow.style.display = "none";
				        }
				    }
				    var pageEnd = document.getElementById("pageEnd");
				    var tempStr = "<span>&nbsp;共&nbsp;"+totalPage+"&nbsp;页&nbsp;&nbsp;&nbsp;</span>";
				    if(currentPage>1){
				        tempStr += "<button onClick=\"goPage("+(1)+")\">首页</button>";
				        tempStr += "<button onClick=\"goPage("+(currentPage-1)+")\">上一页</button>"
				    }else{
				        tempStr += "<button>首页</button>";
				        tempStr += "<button>上一页</button>";
				    }
				    for(var pageIndex= 1;pageIndex<totalPage+1;pageIndex++){
				        tempStr += "<a onclick=\"goPage("+pageIndex+")\"><span>&nbsp;&nbsp;"+ pageIndex +"&nbsp;&nbsp;</span></a>";
				    }
				    if(currentPage<totalPage){
				        tempStr += "<button onClick=\"goPage("+(currentPage+1)+")\">下一页</button>";
				        tempStr += "<button onClick=\"goPage("+(totalPage)+")\">尾页</button>";
				    }else{
				        tempStr += "<button>下一页</button>";
				        tempStr += "<button>尾页</button>";
				    }
				    document.getElementById("barcon").innerHTML = tempStr;
				   
			},
			dataType:"json",
		});
		//********************曲线图*******************
   		var title = {
      		text: '玩家等级分布曲线统计图'   
  		};
  		var subtitle = {
     		text: 'From_Tb:report_rank_distribution'
   		};
   		var chart = {
			type: 'line',
			zoomType: 'x',
			panning: true,
			panKey: 'shift'
		}; 
   		var xAxis;
      		
      	$.ajax({
			url:"../ReportForms/QueryLevelxAxis",
			type:"post",
			success:function(obj){
				xAxis = obj;
			},
			dataType:"json",
			async:false
		});
   		var yAxis = {
     		title: {
         	text: '玩家等级分布人数 (人)'
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
			url:"../ReportForms/QueryLevelData",
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
	//***************************************************分页*************************************************
	function goPage(pno){
    //总共分几页
    if(num/pageSize > parseInt(num/pageSize)){
        totalPage=parseInt(num/pageSize)+1;
    }else{
        totalPage=parseInt(num/pageSize);
    }
    var currentPage = pno;//当前页数
    var startRow = (currentPage - 1) * pageSize+1;//开始显示的行  31
    var endRow = currentPage * pageSize;//结束显示的行   40
    endRow = (endRow > num)? num : endRow;    //40
    console.log(endRow);
    //遍历显示数据实现分页
    for(var i=1;i<(num+1);i++){
        var irow = itable.rows[i-1];
        if(i>=startRow && i<=endRow){
            irow.style.display = "table-row";
        }else{
            irow.style.display = "none";
        }
    }
    var pageEnd = document.getElementById("pageEnd");
    var tempStr = "<span>&nbsp;共&nbsp;"+totalPage+"&nbsp;页&nbsp;&nbsp;&nbsp;</span>";
    if(currentPage>1){
        tempStr += "<button onClick=\"goPage("+(1)+")\">首页</button>";
        tempStr += "<button onClick=\"goPage("+(currentPage-1)+")\">上一页</button>"
    }else{
        tempStr += "<button>首页</button>";
        tempStr += "<button>上一页</button>";
    }
    for(var pageIndex= 1;pageIndex<totalPage+1;pageIndex++){
        tempStr += "<a onclick=\"goPage("+pageIndex+")\"><span>&nbsp;&nbsp;"+ pageIndex +"&nbsp;&nbsp;</span></a>";
    }
    if(currentPage<totalPage){
        tempStr += "<button onClick=\"goPage("+(currentPage+1)+")\">下一页</button>";
        tempStr += "<button onClick=\"goPage("+(totalPage)+")\">尾页</button>";
    }else{
        tempStr += "<button>下一页</button>";
        tempStr += "<button>尾页</button>";
    }
    document.getElementById("barcon").innerHTML = tempStr;
}
	
	//***************************************************（报表以及曲线图）*************************************************
	function QueryDataANDGraph(){
		var beginDate = $('[name="beginDate"]').val();
		var endDate = $('[name="endDate"]').val();
		var content = $('[name="content"]').val();
		//******************玩家等级分布*******************
		if(content == 0){
			var html = '<table>' 
			+ '<tr><th>日期</th>'
			+ '<th>1-20</th>'
			+ '<th>21-40</th>'
			+ '<th>41-60</th>'
			+ '<th>61-80</th>'
			+'<th>81-100</th>'
			+ '<th>101-120</th>'
			+ '<th>121-140</th>'
			+ '<th>141-160</th>'
			+ '<th>161-180</th>'
			+ '<th>181-200</th>'
			+ '<th></th></tr><tbody id="pageInfo">'

			$.ajax({
				url:"../ReportForms/levelDistribution",
				data:{beginDate:beginDate,endDate:endDate},
				type:"post",
				success:function(obj){
					num = obj.rows;
					
					$.each(obj.list, function(commentIndex, comment){	
						var sj = comment.date;
						console.log(comment);
						html += '<tr><td>'+comment.date+'</td>'
								 + '<td>'+comment.level1+'</td>'
								 + '<td>'+comment.level2+'</td>'
								 + '<td>'+comment.level3+'</td>'
								 + '<td>'+comment.level4+'</td>'
								 + '<td>'+comment.level5+'</td>'
								 + '<td>'+comment.level6+'</td>'
								 + '<td>'+comment.level7+'</td>'
								 + '<td>'+comment.level8+'</td>'
								 + '<td>'+comment.level9+'</td>'
								 + '<td>'+comment.level10+'</td>'
								 + '<td><input type="button" name="'+comment.date+'"  title="QueryGraph" data-target="#QueryGraph"  data-toggle="modal"  value="查看饼图" onclick="QueryLevelGraph(this)"/></td></tr>' 
						}); 
					   html += '</tbody></table><div id="barcon" style="position:fixed; bottom: 65%;width: 100%;height: 2%;text-align:center;"></div>'; 
					   $('#showData').html(html);
					   
					   itable = document.getElementById("pageInfo");
					    //总共分几页
					    if(num/pageSize > parseInt(num/pageSize)){
					        totalPage=parseInt(num/pageSize)+1;
					    }else{
					        totalPage=parseInt(num/pageSize);
					    }
					    var currentPage = 1;//当前页数
					    var startRow = (currentPage - 1) * pageSize+1;//开始显示的行  31
					    var endRow = currentPage * pageSize;//结束显示的行   40
					    endRow = (endRow > num)? num : endRow;    //40
					    console.log(endRow);
					    //遍历显示数据实现分页
					    for(var i=1;i<(num+1);i++){
					        var irow = itable.rows[i-1];
					        if(i>=startRow && i<=endRow){
					            irow.style.display = "table-row";
					        }else{
					            irow.style.display = "none";
					        }
					    }
					    var pageEnd = document.getElementById("pageEnd");
					    var tempStr = "<span>&nbsp;共&nbsp;"+totalPage+"&nbsp;页&nbsp;&nbsp;&nbsp;</span>";
					    if(currentPage>1){
					        tempStr += "<button onClick=\"goPage("+(1)+")\">首页</button>";
					        tempStr += "<button onClick=\"goPage("+(currentPage-1)+")\">上一页</button>"
					    }else{
					        tempStr += "<button>首页</button>";
					        tempStr += "<button>上一页</button>";
					    }
					    for(var pageIndex= 1;pageIndex<totalPage+1;pageIndex++){
					        tempStr += "<a onclick=\"goPage("+pageIndex+")\"><span>&nbsp;&nbsp;"+ pageIndex +"&nbsp;&nbsp;</span></a>";
					    }
					    if(currentPage<totalPage){
					        tempStr += "<button onClick=\"goPage("+(currentPage+1)+")\">下一页</button>";
					        tempStr += "<button onClick=\"goPage("+(totalPage)+")\">尾页</button>";
					    }else{
					        tempStr += "<button>下一页</button>";
					        tempStr += "<button>尾页</button>";
					    }
					    document.getElementById("barcon").innerHTML = tempStr;
					},
					dataType:"json",
				});
			
			var title = {
      		text: '玩家等级分布曲线统计图'   
	  		};
	  		var subtitle = {
	     		text: 'From_Tb:report_rank_distribution'
	   		};
	   		var chart = {
				type: 'line',
				zoomType: 'x',
				panning: true,
				panKey: 'shift'
			}; 
	   		var xAxis;
	      	$.ajax({
				url:"../ReportForms/QueryLevelxAxis",
				data:{beginDate:beginDate,endDate:endDate},
				type:"post",
				success:function(obj){
					xAxis = obj;
				},
				dataType:"json",
				async:false
			});
	   		var yAxis = {
	     		title: {
	         	text: '玩家等级分布人数 (人)'
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
				url:"../ReportForms/QueryLevelData",
				data:{beginDate:beginDate,endDate:endDate},
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
	   		$('#container2').load('../PlayerManage/WritePage');
	   		//******************玩家炮倍分布*******************
		}else if(content == 1){
			var html = '<table>' 
			+ '<tr><th>日期</th>'
			+ '<th>1-50</th>'
			+ '<th>60-100</th>'
			+ '<th>120-200</th>'
			+ '<th>250-400</th>'
			+ '<th>450-600</th>'
			+ '<th>650-800</th>'
			+ '<th>850-1000</th>'
			+ '<th>1100-1400</th>'
			+ '<th>1500-1800</th>'
			+ '<th>1900-2000</th>'
			+ '<th></th></tr><tbody id="pageInfo">'

			$.ajax({
				url:"../ReportForms/CannonDistribution",
				data:{beginDate:beginDate,endDate:endDate},
				type:"post",
				success:function(obj){
					num = obj.rows;
					$.each(obj.list, function(commentIndex, comment){	
						var sj = comment.date;
						console.log(comment);
						html += '<tr><td>'+comment.date+'</td>'
								 + '<td>'+comment.cannon1+'</td>'
								 + '<td>'+comment.cannon2+'</td>'
								 + '<td>'+comment.cannon3+'</td>'
								 + '<td>'+comment.cannon4+'</td>'
								 + '<td>'+comment.cannon5+'</td>'
								 + '<td>'+comment.cannon6+'</td>'
								 + '<td>'+comment.cannon7+'</td>'
								 + '<td>'+comment.cannon8+'</td>'
								 + '<td>'+comment.cannon9+'</td>'
								 + '<td>'+comment.cannon10+'</td>'
								 + '<td><input type="button" name="'+comment.date+'"  title="QueryGraph" data-target="#QueryGraph"  data-toggle="modal"  value="查看饼图" onclick="QueryCannonGraph(this)"/></td></tr>' 
						}); 
					   html += '</tbody></table><div id="barcon" style="position:fixed; bottom: 65%;width: 100%;height: 2%;text-align:center;"></div>'; 
					   $('#showData').html(html);
					   
					   itable = document.getElementById("pageInfo");
					    //总共分几页
					    if(num/pageSize > parseInt(num/pageSize)){
					        totalPage=parseInt(num/pageSize)+1;
					    }else{
					        totalPage=parseInt(num/pageSize);
					    }
					    var currentPage = 1;//当前页数
					    var startRow = (currentPage - 1) * pageSize+1;//开始显示的行  31
					    var endRow = currentPage * pageSize;//结束显示的行   40
					    endRow = (endRow > num)? num : endRow;    //40
					    console.log(endRow);
					    //遍历显示数据实现分页
					    for(var i=1;i<(num+1);i++){
					        var irow = itable.rows[i-1];
					        if(i>=startRow && i<=endRow){
					            irow.style.display = "table-row";
					        }else{
					            irow.style.display = "none";
					        }
					    }
					    var pageEnd = document.getElementById("pageEnd");
					    var tempStr = "<span>&nbsp;共&nbsp;"+totalPage+"&nbsp;页&nbsp;&nbsp;&nbsp;</span>";
					    if(currentPage>1){
					        tempStr += "<button onClick=\"goPage("+(1)+")\">首页</button>";
					        tempStr += "<button onClick=\"goPage("+(currentPage-1)+")\">上一页</button>"
					    }else{
					        tempStr += "<button>首页</button>";
					        tempStr += "<button>上一页</button>";
					    }
					    for(var pageIndex= 1;pageIndex<totalPage+1;pageIndex++){
					        tempStr += "<a onclick=\"goPage("+pageIndex+")\"><span>&nbsp;&nbsp;"+ pageIndex +"&nbsp;&nbsp;</span></a>";
					    }
					    if(currentPage<totalPage){
					        tempStr += "<button onClick=\"goPage("+(currentPage+1)+")\">下一页</button>";
					        tempStr += "<button onClick=\"goPage("+(totalPage)+")\">尾页</button>";
					    }else{
					        tempStr += "<button>下一页</button>";
					        tempStr += "<button>尾页</button>";
					    }
					    document.getElementById("barcon").innerHTML = tempStr;
					},
					dataType:"json",
				});
			
			var title = {
      		text: '玩家炮倍分布曲线统计图'   
	  		};
	  		var subtitle = {
	     		text: 'From_Tb:report_cannon_distribution'
	   		};
	   		var chart = {
				type: 'line',
				zoomType: 'x',
				panning: true,
				panKey: 'shift'
			}; 
	   		var xAxis;
	      	$.ajax({
				url:"../ReportForms/QueryCannonxAxis",
				data:{beginDate:beginDate,endDate:endDate},
				type:"post",
				success:function(obj){
					xAxis = obj;
				},
				dataType:"json",
				async:false
			});
	   		var yAxis = {
	     		title: {
	         	text: '玩家等级分布人数 (人)'
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
				url:"../ReportForms/QueryCannonData",
				data:{beginDate:beginDate,endDate:endDate},
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
	   		$('#container2').load('../PlayerManage/WritePage');
			//******************玩家游戏分格分布*******************
		}else if(content == 2){
			var html = '<table>' 
			+ '<tr><th>日期</th>'
			+ '<th>经典千炮捕鱼(人数)</th>'
			+ '<th>Q版捕鱼(人数)</th>'
			+ '<th>海王(人数)</th>'
			+ '<th>大奖赛(人数)</th>'
			+ '<th>经典千炮捕鱼(时长)</th>'
			+ '<th>Q版捕鱼(时长)</th>'
			+ '<th>海王(时长)</th>'
			+ '<th>大奖赛(时长)</th>'
			+ '<th></th></tr><tbody id="pageInfo">'

			$.ajax({
				url:"../ReportForms/GameDistribution",
				data:{beginDate:beginDate,endDate:endDate},
				type:"post",
				success:function(obj){
					num = obj.rows;
					$.each(obj.list, function(commentIndex, comment){	
						html += '<tr><td>'+comment.logDate+'</td>'
								 + '<td>'+comment.user1+'</td>'
								 + '<td>'+comment.user2+'</td>'
								 + '<td>'+comment.user3+'</td>'
								 + '<td>'+comment.user4+'</td>'
								 + '<td>'+comment.time1+'</td>'
								 + '<td>'+comment.time2+'</td>'
								 + '<td>'+comment.time3+'</td>'
								 + '<td>'+comment.time4+'</td>'
								 + '<td><input type="button" name="'+comment.logDate+'"  title="QueryGraph" data-target="#QueryGraph"  data-toggle="modal"  value="查看人数分布" onclick="QueryGameUserGraph(this)"/><input type="button" name="'+comment.logDate+'"  title="QueryGraph2" data-target="#QueryGraph2"  data-toggle="modal"  value="查看时长分布" onclick="QueryGameTimeGraph(this)"/></td></tr>' 
						}); 
					   html += '</tbody></table><div id="barcon" style="position:fixed; bottom: 65%;width: 100%;height: 2%;text-align:center;"></div>'; 
					   $('#showData').html(html);
					   
					   itable = document.getElementById("pageInfo");
					    //总共分几页
					    if(num/pageSize > parseInt(num/pageSize)){
					        totalPage=parseInt(num/pageSize)+1;
					    }else{
					        totalPage=parseInt(num/pageSize);
					    }
					    var currentPage = 1;//当前页数
					    var startRow = (currentPage - 1) * pageSize+1;//开始显示的行  31
					    var endRow = currentPage * pageSize;//结束显示的行   40
					    endRow = (endRow > num)? num : endRow;    //40
					    console.log(endRow);
					    //遍历显示数据实现分页
					    for(var i=1;i<(num+1);i++){
					        var irow = itable.rows[i-1];
					        if(i>=startRow && i<=endRow){
					            irow.style.display = "table-row";
					        }else{
					            irow.style.display = "none";
					        }
					    }
					    var pageEnd = document.getElementById("pageEnd");
					    var tempStr = "<span>&nbsp;共&nbsp;"+totalPage+"&nbsp;页&nbsp;&nbsp;&nbsp;</span>";
					    if(currentPage>1){
					        tempStr += "<button onClick=\"goPage("+(1)+")\">首页</button>";
					        tempStr += "<button onClick=\"goPage("+(currentPage-1)+")\">上一页</button>"
					    }else{
					        tempStr += "<button>首页</button>";
					        tempStr += "<button>上一页</button>";
					    }
					    for(var pageIndex= 1;pageIndex<totalPage+1;pageIndex++){
					        tempStr += "<a onclick=\"goPage("+pageIndex+")\"><span>&nbsp;&nbsp;"+ pageIndex +"&nbsp;&nbsp;</span></a>";
					    }
					    if(currentPage<totalPage){
					        tempStr += "<button onClick=\"goPage("+(currentPage+1)+")\">下一页</button>";
					        tempStr += "<button onClick=\"goPage("+(totalPage)+")\">尾页</button>";
					    }else{
					        tempStr += "<button>下一页</button>";
					        tempStr += "<button>尾页</button>";
					    }
					    document.getElementById("barcon").innerHTML = tempStr;
					},
					dataType:"json",
				});
			//*******************
			var title = {
      		text: '游戏人数分布曲线统计图'   
	  		};
	  		var subtitle = {
	     		text: 'From_Tb:report_game_distribution'
	   		};
	   		var chart = {
				type: 'line',
				zoomType: 'x',
				panning: true,
				panKey: 'shift'
			}; 
	   		var xAxis;
	      	$.ajax({
				url:"../ReportForms/QueryGameUserxAxis",
				data:{beginDate:beginDate,endDate:endDate},
				type:"post",
				success:function(obj){
					xAxis = obj;
				},
				dataType:"json",
				async:false
			});
	   		var yAxis = {
	     		title: {
	         	text: '玩家等级分布人数 (人)'
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
				url:"../ReportForms/QueryGameUserData",
				data:{beginDate:beginDate,endDate:endDate},
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
	   		//*********************
			var title = {
      		text: '游戏时长分布曲线统计图'   
	  		};
	  		var subtitle = {
	     		text: 'From_Tb:report_game_distribution'
	   		};
	   		var chart = {
				type: 'line',
				zoomType: 'x',
				panning: true,
				panKey: 'shift'
			}; 
	   		var xAxis;
	      	$.ajax({
				url:"../ReportForms/QueryGameTimexAxis",
				data:{beginDate:beginDate,endDate:endDate},
				type:"post",
				success:function(obj){
					xAxis = obj;
				},
				dataType:"json",
				async:false
			});
	   		var yAxis = {
	     		title: {
	         	text: '游戏时长(min)'
	      		},
	      	plotLines: [{
	         	value: 0,
	         	width: 1,
	         	color: '#808080'
	      		}]
	   		};   
	   		var tooltip = {
	      		valueSuffix: 'min',
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
				url:"../ReportForms/QueryGameTimeData",
				data:{beginDate:beginDate,endDate:endDate},
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
	   		$('#container2').highcharts(json);
			//******************玩家游戏时长分布*******************
		}else if(content == 3){
			var html = '<table>' 
			+ '<tr><th>日期</th>'
			+ '<th>10min以内(含)</th>'
			+ '<th>30min以内(含)</th>'
			+ '<th>60min以内(含)</th>'
			+ '<th>90min以内(含)</th>'
			+ '<th>120min以内(含)</th>'
			+ '<th>180min以内(含)</th>'
			+ '<th>240min以内(含)</th>'
			+ '<th>超过240min</th>'
			+ '<th></th></tr><tbody id="pageInfo">'

			$.ajax({
				url:"../ReportForms/playTimeDistribution",
				data:{beginDate:beginDate,endDate:endDate},
				type:"post",
				success:function(obj){
					num = obj.rows;
					
					$.each(obj.list, function(commentIndex, comment){	
						var sj = comment.date;
						console.log(comment);
						html += '<tr><td>'+comment.date+'</td>'
								 + '<td>'+comment.playTime1+'</td>'
								 + '<td>'+comment.playTime2+'</td>'
								 + '<td>'+comment.playTime3+'</td>'
								 + '<td>'+comment.playTime4+'</td>'
								 + '<td>'+comment.playTime5+'</td>'
								 + '<td>'+comment.playTime6+'</td>'
								 + '<td>'+comment.playTime7+'</td>'
								 + '<td>'+comment.playTime8+'</td>'
								 + '<td><input type="button" name="'+comment.date+'"  title="QueryGraph" data-target="#QueryGraph"  data-toggle="modal"  value="查看饼图" onclick="QueryPlayTimeGraph(this)"/></td></tr>' 
						}); 
					   html += '</tbody></table><div id="barcon" style="position:fixed; bottom: 65%;width: 100%;height: 2%;text-align:center;"></div>'; 
					   $('#showData').html(html);
					   
					   itable = document.getElementById("pageInfo");
					    //总共分几页
					    if(num/pageSize > parseInt(num/pageSize)){
					        totalPage=parseInt(num/pageSize)+1;
					    }else{
					        totalPage=parseInt(num/pageSize);
					    }
					    var currentPage = 1;//当前页数
					    var startRow = (currentPage - 1) * pageSize+1;//开始显示的行  31
					    var endRow = currentPage * pageSize;//结束显示的行   40
					    endRow = (endRow > num)? num : endRow;    //40
					    console.log(endRow);
					    //遍历显示数据实现分页
					    for(var i=1;i<(num+1);i++){
					        var irow = itable.rows[i-1];
					        if(i>=startRow && i<=endRow){
					            irow.style.display = "table-row";
					        }else{
					            irow.style.display = "none";
					        }
					    }
					    var pageEnd = document.getElementById("pageEnd");
					    var tempStr = "<span>&nbsp;共&nbsp;"+totalPage+"&nbsp;页&nbsp;&nbsp;&nbsp;</span>";
					    if(currentPage>1){
					        tempStr += "<button onClick=\"goPage("+(1)+")\">首页</button>";
					        tempStr += "<button onClick=\"goPage("+(currentPage-1)+")\">上一页</button>"
					    }else{
					        tempStr += "<button>首页</button>";
					        tempStr += "<button>上一页</button>";
					    }
					    for(var pageIndex= 1;pageIndex<totalPage+1;pageIndex++){
					        tempStr += "<a onclick=\"goPage("+pageIndex+")\"><span>&nbsp;&nbsp;"+ pageIndex +"&nbsp;&nbsp;</span></a>";
					    }
					    if(currentPage<totalPage){
					        tempStr += "<button onClick=\"goPage("+(currentPage+1)+")\">下一页</button>";
					        tempStr += "<button onClick=\"goPage("+(totalPage)+")\">尾页</button>";
					    }else{
					        tempStr += "<button>下一页</button>";
					        tempStr += "<button>尾页</button>";
					    }
					    document.getElementById("barcon").innerHTML = tempStr;
					},
					dataType:"json",
				});
			
			var title = {
      		text: '玩家游戏时长分布曲线统计图'   
	  		};
	  		var subtitle = {
	     		text: 'From_Tb:user_day_play_time'
	   		};
	   		var chart = {
				type: 'line',
				zoomType: 'x',
				panning: true,
				panKey: 'shift'
			}; 
	   		var xAxis;
	      	$.ajax({
				url:"../ReportForms/QueryPlayTimexAxis",
				data:{beginDate:beginDate,endDate:endDate},
				type:"post",
				success:function(obj){
					xAxis = obj;
				},
				dataType:"json",
				async:false
			});
	   		var yAxis = {
	     		title: {
	         	text: '玩家等级分布人数 (人)'
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
				url:"../ReportForms/QueryPlayTimeData",
				data:{beginDate:beginDate,endDate:endDate},
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
	   		$('#container2').load('../PlayerManage/WritePage');
			//******************玩家货币数量分布*******************
		}else if(content == 4){
			alert("444");
		}else{
			alert("无此记录");
		}
	}
	//*********************玩家等级分布饼状统计图***********************
	function QueryLevelGraph(THAT){
		var date = THAT.name;
        $.ajax({
			url:"../ReportForms/QueryLevelGraph",
			data:{date:date},
			type:"post",
			success:function(obj){
				$('#GraphContainer').highcharts({
		        chart: {
		            plotBackgroundColor: null,
		            plotBorderWidth: null,
		            plotShadow: false
		        },
		        title: {
		            text: '玩家等级分布饼状统计图'
		        },
		        tooltip: {
		            headerFormat: '{series.name}<br>',
		            pointFormat: '{point.name}: <b>{point.percentage:.1f}%</b>',
		        },
		        plotOptions: {
		            pie: {
		                allowPointSelect: true,
		                cursor: 'pointer',
		                dataLabels: {
		                    enabled: true,
		                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
		                    style: {
		                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
		                    }
		                }
		            }
		        },
				series: obj
				 });
			},
			dataType:"json",
		});
	}
	//*********************玩家炮倍分布饼状统计图***********************
	function QueryCannonGraph(THAT){
		var date = THAT.name;
        $.ajax({
			url:"../ReportForms/QueryCannonGraph",
			data:{date:date},
			type:"post",
			success:function(obj){
				$('#GraphContainer').highcharts({
		        chart: {
		            plotBackgroundColor: null,
		            plotBorderWidth: null,
		            plotShadow: false
		        },
		        title: {
		            text: '玩家炮倍分布饼状统计图'
		        },
		        tooltip: {
		            headerFormat: '{series.name}<br>',
		            pointFormat: '{point.name}: <b>{point.percentage:.1f}%</b>',
		        },
		        plotOptions: {
		            pie: {
		                allowPointSelect: true,
		                cursor: 'pointer',
		                dataLabels: {
		                    enabled: true,
		                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
		                    style: {
		                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
		                    }
		                }
		            }
		        },
				series: obj
				 });
			},
			dataType:"json",
		});
	}
	//*********************玩家游戏风格分布饼状统计图***********************
	function QueryGameUserGraph(THAT){
		var date = THAT.name;
        $.ajax({
			url:"../ReportForms/QueryGameUserGraph",
			data:{date:date},
			type:"post",
			success:function(obj){
				$('#GraphContainer').highcharts({
		        chart: {
		            plotBackgroundColor: null,
		            plotBorderWidth: null,
		            plotShadow: false
		        },
		        title: {
		            text: '针对不同游戏风格游戏人数分布饼状统计图'
		        },
		        tooltip: {
		            headerFormat: '{series.name}<br>',
		            pointFormat: '{point.name}: <b>{point.percentage:.1f}%</b>',
		        },
		        plotOptions: {
		            pie: {
		                allowPointSelect: true,
		                cursor: 'pointer',
		                dataLabels: {
		                    enabled: true,
		                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
		                    style: {
		                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
		                    }
		                }
		            }
		        },
				series: obj
				 });
			},
			dataType:"json",
		});
	}
	function QueryGameTimeGraph(THAT){
		var date = THAT.name;
        $.ajax({
			url:"../ReportForms/QueryGameTimeGraph",
			data:{date:date},
			type:"post",
			success:function(obj){
				$('#GraphContainer2').highcharts({
		        chart: {
		            plotBackgroundColor: null,
		            plotBorderWidth: null,
		            plotShadow: false
		        },
		        title: {
		            text: '针对不同游戏风格游戏时长分布饼状统计图'
		        },
		        tooltip: {
		            headerFormat: '{series.name}<br>',
		            pointFormat: '{point.name}: <b>{point.percentage:.1f}%</b>',
		        },
		        plotOptions: {
		            pie: {
		                allowPointSelect: true,
		                cursor: 'pointer',
		                dataLabels: {
		                    enabled: true,
		                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
		                    style: {
		                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
		                    }
		                }
		            }
		        },
				series: obj
				 });
			},
			dataType:"json",
		});
	}
	//*********************玩家游戏时长分布饼状统计图***********************
	function QueryPlayTimeGraph(THAT){
		var date = THAT.name;
        $.ajax({
			url:"../ReportForms/QueryPlayTimeGraph",
			data:{date:date},
			type:"post",
			success:function(obj){
				$('#GraphContainer').highcharts({
		        chart: {
		            plotBackgroundColor: null,
		            plotBorderWidth: null,
		            plotShadow: false
		        },
		        title: {
		            text: '玩家游戏时长分布饼状统计图'
		        },
		        tooltip: {
		            headerFormat: '{series.name}<br>',
		            pointFormat: '{point.name}: <b>{point.percentage:.1f}%</b>',
		        },
		        plotOptions: {
		            pie: {
		                allowPointSelect: true,
		                cursor: 'pointer',
		                dataLabels: {
		                    enabled: true,
		                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
		                    style: {
		                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
		                    }
		                }
		            }
		        },
				series: obj
				 });
			},
			dataType:"json",
		});
	}
</script>
<style>
input[type="text"],input[type="password"] {
	width:130px;
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
	width:130px;
	border: solid #ccc 2px;
	-webkit-border-radius: 6px;
	border-radius: 6px;
	-webkit-box-shadow: 0 1px 1px #ccc;
	background: #efefef;
	margin: 0 2px 0;
	text-indent: 5px;
}
</style>