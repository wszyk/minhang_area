layui.use([ 'laypage', 'layer', 'form', 'laydate' ], function() {
	var laypage = layui.laypage, $ = layui.jquery, form = layui.form,laydate = layui.laydate;
	
	//日期
	  laydate.render({
	    elem: '#dateStart'
	    ,done: function(value, date, endDate){
	    	loadData(1);
	    }
	  });
	  laydate.render({
	    elem: '#dateEnd'
    	,done: function(value, date, endDate){
	    	loadData(1);
	    }
	  });
	
	// 加载数组数据
	var loadData = function(page) {
		var areaId = $("#areaId").val();
		var tradeId = $("#tradeId").val();
		var industry = $("#industry").val();
		var dateStart = $("#dateStart").val() || '';
		var dateEnd = $("#dateEnd").val() || '';
		
		var index = layer.load();
		$.ajax({
			url : _basePath+"sys/tradeData/getList.do",
			type: "POST",
			data: {
				"page": page,
				"areaId": areaId,
				"tradeId": tradeId,
				"industry": industry,
				"dateStart": dateStart,
				"dateEnd": dateEnd
			},
			dataType: "json",
			success : function(data) {
				layer.close(index);
				initTableData(data);
			}
		});
	};
	
	// 初始化列表
	var initTableData = function(data) {
		var pages = data.pages;
		var currentPage = data.currentPage;
		laypage.render({
			elem: 'page',
			count : pages,
			curr : currentPage,
			skin : '#000',
			jump: function(obj, first){
			    //得到了当前页，用于向服务端请求对应数据
			    var curr = obj.curr;
			    if (!first) {
			    	loadData(curr);
			    }
			}
		});
		
		$("#tableBody").empty();
		var dataList = data.data;
		for (var i = 0; i < dataList.length; i++) {
			var _object = dataList[i];
			var itemHtml = '<tr>';
			itemHtml += '<td><input data-id="'+_object.id+'" type="checkbox" name="" lay-skin="primary"><div class="layui-unselect layui-form-checkbox" lay-skin="primary"><i class="layui-icon">&#xe626;</i></div></td>';
//			itemHtml += '<td>'+_object.tradeCode+'</td>';
			itemHtml += '<td>'+_object.tradeName+'</td>';
			itemHtml += '<td>'+_object.dateTime+'</td>';
//			itemHtml += '<td>'+_object.mcc+'</td>';
			itemHtml += '<td>'+_object.sales+'</td>';
			itemHtml += '<td>'+_object.salesNums+'</td>';
//			itemHtml += '<td>'+_object.avgPrice+'</td>';
			itemHtml += '<td>'+_object.mids+'</td>';
			itemHtml += '<td>'+_object.industry+'</td>';
			itemHtml += '</tr>';
			$("#tableBody").append(itemHtml);
		}
		
		form.on('checkbox(allChoose)', function(data) {
			var child = $(data.elem).parents('table').find(
					'tbody input[type="checkbox"]');
			child.each(function(index, item) {
				item.checked = data.elem.checked;
			});
			form.render('checkbox');
		});
		form.render();
		
	};
	
	// 编辑
	$("#edit").on("click", function() {
		var selectObjs = $("#tableBody").find(".layui-form-checked");
		if (selectObjs.length != 1) {
			layer.msg("请选择一个编辑！");
			return;
		}
		selectObjs.each(function(index) {
			var dataId = $(this).prev().attr("data-id");
			window.location.href = _basePath+'sys/tradeData/editView/'+dataId;
		});
	});
	
	// 删除
	$("#delete").on("click", function(ele) {
		var selectObjs = $("#tableBody").find(".layui-form-checked");
		if (selectObjs.length != 1) {
			layer.msg("请选择一个删除！");
			return;
		}
		layer.confirm('确认删除？', {
			icon : 3,
			title : '提示'
		}, function(index) {
			var dataId = '';
			selectObjs.each(function(index) {
				dataId = $(this).prev().attr("data-id");
			});
			// 提交后台删除
			$.ajax({
				url : _basePath + "sys/tradeData/delete.do",
				type: "post",
				data: {"id": dataId},
				dataType : "json",
				success : function(data) {
					layer.close(index);
					// 重新加载页面
					loadData(1);
				}
			});
		}, function(index) {
			layer.close(index);
		});
		
	});
	
	// 导出模板
	$("#export").on("click", function(ele) {
		window.location.href = _basePath+"sys/tradeData/export";
	});
	
	// 导出数据
	$("#exportData").on("click", function(ele) {
		var areaId = $("#areaId").val();
		var tradeId = $("#tradeId").val();
		var industry = $("#industry").val();
		industry = encodeURI(encodeURI(industry));
		var dateStart = $("#dateStart").val() || '';
		var dateEnd = $("#dateEnd").val() || '';
		window.location.href = _basePath+"sys/tradeData/exportData?areaId="+areaId+"&tradeId="+tradeId+"&industry="+industry+"&dateStart="+dateStart+"&dateEnd="+dateEnd;
	});
	
	// 获得这个区域的所有商圈
	var getAllTradesByAreaId = function(areaId) {
		$.ajax({
			url : _basePath+"sys/tradeData/getAllTradesByAreaId.do?areaId="+areaId,
			dataType: "json",
			success : function(data) {
				initTradeData(data);
			}
		});
	};
	
	var initTradeData = function(data) {
		$("#tradeId").empty();
		$("#tradeId").html('<option value="-1">请选择</option>');
		var tradeList = data.data || [];
		var _tradeId = $("#tradeId").attr("data-value");
		for(var i = 0; i < tradeList.length; i++) {
			var _obj = tradeList[i];
			var itemHtml = '<option value="'+_obj.id+'">'+_obj.tradeName+'</option>';
			if (_tradeId == _obj.id) {
				itemHtml = '<option selected value="'+_obj.id+'">'+_obj.tradeName+'</option>';
			}
			$("#tradeId").append(itemHtml);
		}
		form.render();
	};
	
	// 监听区域变化的时候
	form.on('select(areaId)', function(data){
		getAllTradesByAreaId(data.value);
	});
	form.on('select', function(data){
		loadData(1);
	});
	
	
	loadData(1);
});

