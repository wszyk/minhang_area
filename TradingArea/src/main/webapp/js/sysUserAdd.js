layui.use([ 'laypage', 'layer', 'form' ], function() {
	var laypage = layui.laypage, $ = layui.jquery, form = layui.form;
	
	// 监听提交
	form.on('submit(formSave)', function(data) {
		var loginName = data.field.loginName || '';
		var password = data.field.password || '';
		if (loginName == '') {
			layer.msg('请输入登录名');
			return;
		}
		if (password == '') {
			layer.msg('请输入密码');
			return;
		}
		$.ajax({
			url : _basePath+"sys/user/addSave.do",
			type: 'post',
			data: data.field,
			dataType: "json",
			success : function(data) {
				if (data.code == 0) {
					layer.msg('操作成功！');
					window.location.href = _basePath+"sys/user/list";
				}
			}
		});
		return false;
	});
});

