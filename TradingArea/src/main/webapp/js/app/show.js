layui.use([ 'laypage', 'layer', 'form', 'element' ], function() {
	var laypage = layui.laypage, $ = layui.jquery, form = layui.form, element = layui.element;
	
	element.on('tab(analysis)', function(){
		selectAnalysis = this.getAttribute("data-id")*1;
		if (selectAnalysis == 1) {
			selectTime = selectTime1;
			selectContent = selectContent1;
			loadTotalAnalysis();
		}
		else if (selectAnalysis == 2) {
			selectTime = selectTime2;
			selectContent = selectContent2 + "," + selectContent21;
			loadTrendAnalysis();
		}
		else if (selectAnalysis == 3) {
			selectTime = selectTime3 + "," + selectTime31;
			selectContent = selectContent3 + "," + selectContent31;
			loadCompareAnalysis();
		}
	});
	
	$(".time").on("change", function() {
		selectTime3 = $("#comTime31").val() + '-' + $("#comTime311").val();
		selectTime31 = $("#comTime32").val() + '-' + $("#comTime322").val();
		selectTime = selectTime3 + "," + selectTime31;
		loadCompareAnalysis();
	});
	
	$("#comContent2").on("change", function() {
		selectContent21 = this.value;
		selectContent = selectContent2 + "," + selectContent21;
		loadTrendAnalysis();
	});
	$("#comContent3").on("change", function() {
		selectContent31 = this.value;
		selectContent = selectContent3 + "," + selectContent31;
		loadCompareAnalysis();
	});
	form.on('radio', function() {
		if ('year1' == this.value || 'quarter1' == this.value || 'month1' == this.value) {
			selectTime1 = this.value.substring(0, this.value.length-1);
			selectTime = this.value.substring(0, this.value.length-1);
		}
		else if ('year2' == this.value || 'quarter2' == this.value || 'month2' == this.value) {
			selectTime2 = this.value.substring(0, this.value.length-1);
			selectTime = this.value.substring(0, this.value.length-1);
		}
		else if ('sales1' == this.value || 'mids1' == this.value || 'salesNums1' == this.value) {
			selectContent1 = this.value.substring(0, this.value.length-1);
			selectContent = this.value.substring(0, this.value.length-1);
		}
		else if ('sales2' == this.value || 'mids2' == this.value || 'salesNums2' == this.value) {
			selectContent2 = this.value.substring(0, this.value.length-1);
			selectContent = selectContent2 + "," + selectContent21;
		}
		else if ('sales3' == this.value || 'mids3' == this.value || 'salesNums3' == this.value) {
			selectContent3 = this.value.substring(0, this.value.length-1);
			selectContent = selectContent3 + "," + selectContent31;
		}
		if (selectAnalysis == 1) {
			loadTotalAnalysis();
		}
		else if (selectAnalysis == 2) {
			loadTrendAnalysis();
		}
		else if (selectAnalysis == 3) {
			loadCompareAnalysis();
		}
	});
	
	// 获得展示区域的高度
	var height = $("#layuiTabContent").css("height");
	height = height.replace('px', '');
	$("#totalAnalysis1").css("height", (height-150)+"px");
	$("#totalAnalysis2").css("height", (height-150)+"px");
	$("#trendAnalysis").css("height", (height-150)+"px");
	$("#relationshipAnalysis1").css("height", (height-150)+"px");
	$("#relationshipAnalysis2").css("height", (height-150)+"px");
	
    
    // 加载总量的数据
	loadTotalAnalysis = function() {
		$.ajax({
			url : _basePath+"app/loadTotalAnalysis.do",
			type: 'post',
			data: {"selectNodes": selectNodes.join(","), "selectTime":selectTime, "selectContent":selectContent},
			dataType: "json",
			success : function(data) {
				if (data.code == 0) {
					$(".app-statistics").css("visibility", "visible");
					refreshTotalAnalysis(data);
				}
			}
		});
		
	};
	
	var refreshTotalAnalysis = function (data) {
		var selectObj = $("input[name='comContent1']:checked");
		var yUnit = selectObj.attr('data-unit');
		var yTitle = selectObj.attr("title");
		var yTitleUnit = yTitle+'/'+yUnit;
		
		var myChart1 = echarts.init(document.getElementById('totalAnalysis1'));
		var dataClassifyArr = [];
		var dateTimeArr = [];
		var seriesArr = [];
		for (var i = 0; i < data.tradeDataList.length; i++) {
			var _obj = data.tradeDataList[i];
			var dateTime = _obj.dateTime;
			var name = _obj.name;
			if (isContains(dataClassifyArr, name) == false) {
				dataClassifyArr.push(name);
			}
			if (isContains(dateTimeArr, dateTime) == false) {
				dateTimeArr.push(dateTime);
			}
		}
		for (var i = 0; i < dataClassifyArr.length; i++) {
			var _series = {};
			_series.name = dataClassifyArr[i];
			_series.type = 'bar';
			_series.stack = '总量';
			var valueArr = [];
			for (var j = 0; j < dateTimeArr.length; j++) {
				var val = getValByTimeAndClassify(data.tradeDataList, dateTimeArr[j], dataClassifyArr[i]);
				if (yTitle == '销售额') {
					valueArr.push(val/10000);
				}
				else {
					valueArr.push(val);
				}
			}
			_series.data = valueArr;
			seriesArr.push(_series);
		}
		
		var option1 = {
				color: ['#ca8622', '#c23531','#2f4554', '#61a0a8', '#d48265', '#91c7ae','#749f83', '#bda29a','#6e7074', '#546570', '#c4ccd3', '#01AAED'],
			    tooltip : {
			        trigger: 'axis',
			        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
			        },
			        formatter: function(obj) {
			        	var result = '';
			        	for (var i = 0; i < obj.length; i++) {
			        		var _obj = obj[i];
			        		var name = _obj.name;
			        		var value = _obj.value;
			        		var seriesName = _obj.seriesName;
			        		if (i == 0) {
			        			result += name + '<br/>';
			        		}
			        		result += seriesName + ': ' + value + yUnit + '<br/>';
			        	}
			        	return result;
			        }
			    },
			    textStyle: {
			        color: '#ccc'
			    },
			    legend: {
			    	itemWidth: 10,
			        data: dataClassifyArr,
			        textStyle: {
			        	color: '#ccc'
			        }
			    },
			    grid: {
			        left: '3%',
			        top: '20%',
			        right: '10%',
			        bottom: '3%',
			        containLabel: true
			    },
			    yAxis:  {
			    	name: yTitleUnit,
			        type: 'value',
			        nameTextStyle: {
			            color: '#ccc'
			        },
			        splitLine: {
			            show: false
			        },
			        axisLine: {
			            lineStyle: {
			                color: '#ccc'
			            }
			        }
			    },
			    xAxis: {
			    	name: '时间',
			        type: 'category',
			        data: dateTimeArr,
			        nameTextStyle: {
			            color: '#ccc'
			        },
			        axisLine: {
			            lineStyle: {
			                color: '#ccc'
			            }
			        }
			    },
			    series: seriesArr
			};
		myChart1.setOption(option1, true);
		
		
		// 基于准备好的dom，初始化echarts实例
	    var myChart2 = echarts.init(document.getElementById('totalAnalysis2'));
	    var option2 = {
	    		color: ['#ca8622', '#c23531','#2f4554', '#61a0a8', '#d48265', '#91c7ae','#749f83', '#bda29a','#6e7074', '#546570', '#c4ccd3', '#01AAED'],
	    		title: {
			        left: 'center',
			        top: 20,
			        textStyle: {
			            color: '#ccc'
			        }
			    },
			    textStyle: {
			        color: '#ccc'
			    },
			    tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    },
	    	    series : [
	    	        {
	    	            name: '总量分析',
	    	            type: 'pie',
	    	            radius : '55%',
	    	            center: ['50%', '60%'],
	    	            data:data.dataList,
	    	            itemStyle: {
	    	                emphasis: {
	    	                    shadowBlur: 10,
	    	                    shadowOffsetX: 0,
	    	                    shadowColor: 'rgba(0, 0, 0, 0.5)'
	    	                }
	    	            }
	    	        }
	    	    ]
	    	};
	 // 使用刚指定的配置项和数据显示图表。
		myChart2.setOption(option2, true);
		
	};
	
	
	loadTrendAnalysis = function() {
		$.ajax({
			url : _basePath+"app/loadTrendAnalysis.do",
			type: 'post',
			data: {"selectNodes": selectNodes.join(","), "selectTime":selectTime, "selectContent":selectContent},
			dataType: "json",
			success : function(data) {
				if (data.code == 0) {
					$(".app-statistics").css("visibility", "visible");
					refreshTrendAnalysis(data.data);
				}
			}
		});
		
	};
	var refreshTrendAnalysis = function(data) {
		if (data.length == 0) {
			return;
		}
		
		var selectObj = $("input[name='comContent2']:checked");
		var yUnit = selectObj.attr('data-unit');
		var yTitle = selectObj.attr("title");
		var yTitleUnit = yTitle+'/'+yUnit;
		
		var tradeArr = [];
		var dateTimeArr = [];
		var seriesArr = [];
		for (var i = 0; i < data.length; i++) {
			var _obj = data[i];
			var dateTime = _obj.dateTime;
			var name = _obj.name;
			if (isContains(tradeArr, name) == false) {
				tradeArr.push(name);
			}
			if (isContains(dateTimeArr, dateTime) == false) {
				dateTimeArr.push(dateTime);
			}
		}
		for (var i = 0; i < tradeArr.length; i++) {
			var _series = {};
			_series.name = tradeArr[i];
			_series.type = 'line';
			_series.markPoint = {
                data: [
	                    {type: 'max', name: '最大值'},
	                    {type: 'min', name: '最小值'}
	                ]
	            };
			_series.markLine = {
	                data: [
	                    {type: 'average', name: '平均值'}
	                ]
	            };
			var valueArr = [];
			for (var j = 0; j < dateTimeArr.length; j++) {
				var val = getValByTimeAndClassify(data, dateTimeArr[j], tradeArr[i]);
				if (yTitle == '销售额') {
					valueArr.push(val/10000);
				}
				else {
					valueArr.push(val);
				}
			}
			_series.data = valueArr;
			seriesArr.push(_series);
		}
		
		
		var myChart = echarts.init(document.getElementById('trendAnalysis'));
		var option = {
			    title: {
			        textStyle: {
			            color: '#ccc'
			        }
			    },
			    tooltip: {
			        trigger: 'axis',
			        formatter: function(obj) {
			        	var result = '';
			        	for (var i = 0; i < obj.length; i++) {
			        		var _obj = obj[i];
			        		var name = _obj.name;
			        		var value = _obj.value;
			        		var seriesName = _obj.seriesName;
			        		if (i == 0) {
			        			result += name + '<br/>';
			        		}
			        		result += seriesName + ': ' + value + yUnit + '<br/>';
			        	}
			        	return result;
			        }
			    },
			    textStyle: {
			        color: '#ccc'
			    },
			    grid: {
			        left: '3%',
			        top: '20%',
			        right: '10%',
			        bottom: '3%',
			        containLabel: true
			    },
			    legend: {
			        data:tradeArr,
			        textStyle: {
			        	color: '#ccc'
			        }
			    },
			    xAxis:  {
			    	name: '时间',
			        type: 'category',
			        boundaryGap: false,
			        data: dateTimeArr,
			        axisLine: {
			            lineStyle: {
			                color: '#ccc'
			            }
			        }
			    },
			    yAxis: {
			    	name: yTitleUnit,
			        type: 'value',
			        axisLabel: {
			            formatter: '{value}'
			        },
			        splitLine: {
			            show: false
			        },
			        axisLine: {
			            lineStyle: {
			                color: '#ccc'
			            }
			        }
			    },
			    series: seriesArr
			};
		myChart.setOption(option, true);
	};
	
	
	loadCompareAnalysis = function() {
		$.ajax({
			url : _basePath+"app/loadCompareAnalysis.do",
			type: 'post',
			data: {"selectNodes": selectNodes.join(","), "selectTime":selectTime, "selectContent":selectContent},
			dataType: "json",
			success : function(data) {
				if (data.code == 0) {
					$(".app-statistics").css("visibility", "visible");
					refreshCompareAnalysis(data);
				}
			}
		});
	};
	var refreshCompareAnalysis = function(result) {
		var selectObj = $("input[name='comContent3']:checked");
		var yUnit = selectObj.attr('data-unit');
		var yTitle = selectObj.attr("title");
		var yTitleUnit = yTitle+'/'+yUnit;
		
		var data = result.data;
		var tradeArr = [];
		var tradeArrX = [];
		var seriesArr = [];
		for (var i = 0; i < data.length; i++) {
			var _obj = data[i];
			var name = _obj.name;
			if (isContains(tradeArr, name) == false) {
				tradeArr.push(name);
				tradeArrX.push(name.split("").join("\n"));
			}
		}
		var _series = {};
		_series.type = 'bar';
		var valueArr = [];
		for (var i = 0; i < tradeArr.length; i++) {
			var val = getValByClassify(data, tradeArr[i]);
			if (yTitle == '销售额') {
				valueArr.push(val/10000);
			}
			else {
				valueArr.push(val);
			}
		}
		_series.data = valueArr;
		seriesArr.push(_series);
		
		var myChart1 = echarts.init(document.getElementById('relationshipAnalysis1'));
		var option1 = {
				title: {
			        textStyle: {
			            color: '#ccc'
			        }
			    },
			    color: ['#ca8622', '#c23531','#2f4554', '#61a0a8', '#d48265', '#91c7ae','#749f83', '#bda29a','#6e7074', '#546570', '#c4ccd3'],
				textStyle: {
			        color: '#ccc'
			    },
			    tooltip : {
			        trigger: 'axis',
			        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
			        },
			        formatter: '{b} <br/>'+yTitle+' : {c}'+yUnit
			    },
			    grid: {
			        left: '3%',
			        right: '10%',
			        bottom: '3%',
			        containLabel: true
			    },
			    xAxis : [
			        {
			        	name: '商圈',
			            type : 'category',
			            data : tradeArrX,
			            axisLine: {
			                lineStyle: {
			                    color: '#ccc'
			                }
			            }
			        }
			    ],
			    yAxis : [
			        {
			        	name: yTitleUnit,
			            type : 'value',
			            splitLine: {
				            show: false
				        },
				        axisLine: {
				            lineStyle: {
				                color: '#ccc'
				            }
				        }
			        }
			    ],
			    series : seriesArr
			};
		myChart1.setOption(option1, true);
		
		var tradeData = result.tradeData;
		var maxVal = getMaxValByKey(tradeData);
		var avgVal = 1;
		if (maxVal > 10) {
			avgVal = maxVal / 100;
		}
		
		var tradeArr = [];
		var valArr = [];
		var seriesArr = [];
		for (var i = 0; i < tradeData.length; i++) {
			var _obj = tradeData[i];
			var name = _obj.name;
			if (isContains(tradeArr, name) == false) {
				tradeArr.push(name);
			}
		}
		
		for (var i = 0; i < tradeArr.length; i++) {
			var tmp1Arr = [];
			var tmp2Arr = [];
			var _obj = getObjByClassify(tradeData, tradeArr[i]);
			// 销售额
			var sales = _obj.sales;
			// 销售笔数
			var salesNums = _obj.salesNums;
			// 商户数
			var mids = _obj.mids;
			
			tmp2Arr.push(salesNums/1000);
			tmp2Arr.push(sales/10000);
			tmp2Arr.push(mids);
			tmp2Arr.push(tradeArr[i]);
			tmp1Arr.push(tmp2Arr);
			valArr.push(tmp1Arr);
		}
		for (var i = 0; i < tradeArr.length; i++) {
			var _series = {};
			_series.name = tradeArr[i];
			_series.type = 'scatter';
			_series.data = valArr[i];
			_series.symbolSize = function (data) {
				var size = data[2] / avgVal;
				if (size < 10) {
					size = 10;
				}
                return size;
            };
			seriesArr.push(_series);
		}
		var myChart2 = echarts.init(document.getElementById('relationshipAnalysis2'));

       var option2 = {
    	color: ['#ca8622', '#c23531','#2f4554', '#61a0a8', '#d48265', '#91c7ae','#749f83', '#bda29a','#6e7074', '#546570', '#c4ccd3'],
		   textStyle: {
		        color: '#ccc'
		    },
		    grid: {
		        left: '3%',
		        top: '20%',
		        right: '15%',
		        bottom: '5%',
		        containLabel: true
		    },
		    legend: {
		        right: 10,
		        textStyle: {
			        color: '#ccc'
			    },
		        data: tradeArr
		    },
		    tooltip: {
		    	trigger: 'item',
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		        },
		        formatter: function (obj) {
		            var value = obj.data;
		            var result = value[3] + '<br>';
		            result += '主要商户数：' + value[2] + '个<br>';
		            result += '交易笔数：' + value[0]*1000 + '笔<br>';
		            result += '销售额：' + value[1] + '万元<br>';
		            
		            return result;
		        }
		    },
            xAxis: {
            	name: '销售笔数/千',
            	nameLocation: 'middle',
            	nameGap: 25,
                splitLine: {
                     show: false
                },
                axisLine: {
                    lineStyle: {
                        color: '#ccc'
                    }
                }
            },
            yAxis: {
            	name: '销售额/万元',
                splitLine: {
                     show: false
                    
                },
                axisLine: {
                    lineStyle: {
                        color: '#ccc'
                    }
                },
                scale: true
            },
            series: seriesArr
        };
       myChart2.setOption(option2, true);
	};
	
	
	
	
	
	
	
	
	var getObjByClassify = function(dataArr, classify) {
		var result = {};
		for (var i = 0; i < dataArr.length; i++) {
			if (classify == dataArr[i].name) {
				result = dataArr[i];
				break;
			}
		}
		return result;
	};
	var getValByTimeAndClassify = function(dataArr, dataTime, classify) {
		var val = 0;
		for (var i = 0; i < dataArr.length; i++) {
			if (dataTime == dataArr[i].dateTime && classify == dataArr[i].name) {
				val = dataArr[i].value;
				break;
			}
		}
		return val;
	};
	var getValByClassify = function(dataArr, classify) {
		var val = 0;
		for (var i = 0; i < dataArr.length; i++) {
			if (classify == dataArr[i].name) {
				val = dataArr[i].value;
				break;
			}
		}
		return val;
	};
	var isContains = function(dataArr, dataVal) {
		var result = false;
		for (var i = 0; i < dataArr.length; i++) {
			if (dataVal == dataArr[i]) {
				result = true;
				break;
			}
		}
		return result;
	};
	
	var getMaxValByKey = function(dataArr) {
		var result = 0;
		for (var i = 0; i < dataArr.length; i++) {
			var _obj = dataArr[i];
			if (_obj.mids > result) {
				result = _obj.mids;
			}
		}
		return result;
	};
	
	
});

