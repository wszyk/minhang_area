layui.use([ 'laypage', 'layer', 'form', 'laydate', 'upload' ], function() {
	var laypage = layui.laypage, $ = layui.jquery, form = layui.form,laydate = layui.laydate, upload = layui.upload;
	
	// 监听提交
	form.on('submit(formSave)', function(data) {
		$.ajax({
			url : _basePath+"sys/tradeData/importSave.do",
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
	
	// 上传文件
	upload.render({
		elem: '#file',
		url : _basePath+'base/upLoadFile.do',
		accept: 'file',
		exts: 'xls|xlsx',
		before : function(input) {
			// 返回的参数item，即为当前的input DOM对象
			console.log('文件上传中');
		},
		done : function(res, index, upload) {
			$("#importFile").val(res.data.src);
		}
	});
});

