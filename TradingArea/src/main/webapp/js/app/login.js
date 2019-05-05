layui.use([ 'laypage', 'layer', 'form', 'element' ], function() {
	var laypage = layui.laypage, $ = layui.jquery, form = layui.form, element = layui.element;
	
	// 监听提交
	form.on('submit(formSave)', function(data) {
		var index = layer.load();
		$.ajax({
			url : _basePath+"sys/user/login.do",
			type: 'post',
			data: data.field,
			dataType: "json",
			success : function(data) {
				layer.close(index);
				layer.msg(data.msg);
				if (data.code == 0) {
					window.location.href = _basePath+"app/show";
				}
			}
		});
		return false;
	});
	
});

document.onkeydown = function keyDownSearch(e) {    
    // 兼容FF和IE和Opera    
    var theEvent = e || window.event;    
    var code = theEvent.keyCode || theEvent.which || theEvent.charCode;    
    if (code == 13) {    
        document.getElementById("loginFunc").click();
        return false;    
    }    
    return true;    
};