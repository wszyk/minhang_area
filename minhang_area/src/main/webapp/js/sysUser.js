layui.use([ 'laypage', 'layer', 'form' ], function() {
	var laypage = layui.laypage, $ = layui.jquery, form = layui.form;
	
	// 加载数组数据
	var loadData = function(page) {
		var index = layer.load();
		$.ajax({
			url : _basePath+"sys/user/getList.do?page="+page,
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
			itemHtml += '<td>'+_object.loginName+'</td>';
			// itemHtml += '<td>'+_object.password+'</td>';
			var role = '普通用户';
			if(_object.role == 0) {
				role = '超级管理员';
			}
			else if(_object.role == 2) {
				role = '限制级用户';
			}
			itemHtml += '<td>'+role+'</td>';
			itemHtml += '<td>'+_object.areaName+'</td>';
			itemHtml += '<td>'+_object.description+'</td>';
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
			window.location.href = _basePath+'sys/user/editView/'+dataId;
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
				url : _basePath + "sys/user/delete.do",
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
	
	loadData(1);
});

