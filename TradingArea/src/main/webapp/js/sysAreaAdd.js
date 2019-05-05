layui.use([ 'laypage', 'layer', 'form' ], function() {
	var laypage = layui.laypage, $ = layui.jquery, form = layui.form;
	
	// 监听提交
	form.on('submit(formSave)', function(data) {
		var code = data.field.code || '';
		var areaName = data.field.areaName || '';
		if (code == '') {
			layer.msg('请输入区域编号');
			return;
		}
		if (areaName == '') {
			layer.msg('请输入区域名称');
			return;
		}
		$.ajax({
			url : _basePath+"sys/area/addSave.do",
			type: 'post',
			data: data.field,
			dataType: "json",
			success : function(data) {
				if (data.code == 0) {
					layer.msg('操作成功！');
					window.location.href = _basePath+"sys/area/list";
				}
			}
		});
		return false;
	});
});

