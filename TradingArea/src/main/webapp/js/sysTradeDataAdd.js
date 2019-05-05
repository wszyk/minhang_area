layui.use([ 'laypage', 'layer', 'form', 'laydate' ], function() {
	var laypage = layui.laypage, $ = layui.jquery, form = layui.form,laydate = layui.laydate;;
	
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
	var selectAreaId = $("#areaId").val();
	getAllTradesByAreaId(selectAreaId);
	
	// 监听区域变化的时候
	form.on('select(areaId)', function(data){
		getAllTradesByAreaId(data.value);
	});
	
	// 监听提交
	form.on('submit(formSave)', function(data) {
		$.ajax({
			url : _basePath+"sys/tradeData/addSave.do",
			type: 'post',
			data: data.field,
			dataType: "json",
			success : function(data) {
				if (data.code == 0) {
					layer.msg('操作成功！');
					window.location.href = _basePath+"sys/tradeData/list";
				}
			}
		});
		return false;
	});
});

