layui.use([ 'laypage', 'layer', 'form' ], function() {
	var laypage = layui.laypage, $ = layui.jquery, form = layui.form;
	
	// 监听提交
	form.on('submit(formSave)', function(data) {
		var tradeName = data.field.tradeName || '';
		var lng = data.field.lng || '';
		var lat = data.field.lat || '';
		if (tradeName == '') {
			layer.msg('请输入名称');
			return;
		}
		if (lng == '') {
			layer.msg('请选择经度');
			return;
		}
		if (lat == '') {
			layer.msg('请选择纬度');
			return;
		}
		$.ajax({
			url : _basePath+"sys/trade/addSave.do",
			type: 'post',
			data: data.field,
			dataType: "json",
			success : function(data) {
				if (data.code == 0) {
					layer.msg('操作成功！');
					window.location.href = _basePath+"sys/trade/list";
				}
			}
		});
		return false;
	});
});

