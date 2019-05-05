<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%String path = request.getContextPath();String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"><html><head><title>商圈平台管理系统</title><script type="text/javascript">	var _basePath = '<%=basePath%>';</script><meta http-equiv="pragma" content="no-cache"><meta http-equiv="cache-control" content="no-cache"><meta http-equiv="expires" content="0"><meta http-equiv="keywords" content="keyword1,keyword2,keyword3"><meta http-equiv="description" content="This is my page"><jsp:include page="adminCommon.jsp"></jsp:include>	<link rel="shortcut icon" href="<%=path %>/images/favicon.ico"/></head><body>	<div class="layui-layout layui-layout-admin">		<jsp:include page="adminHeader.jsp"></jsp:include>		<jsp:include page="adminLeft.jsp"></jsp:include>		<div class="layui-tab layui-tab-brief">			<div class="layui-body layui-tab-content">				<div class="layui-tab-item layui-show">					<div class="layui-main">						<div id="LAY_preview">							<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">							  <legend>系统管理-用户管理-<c:if test="${user == null }">添加</c:if><c:if test="${user != null }">编辑</c:if></legend>							</fieldset>							<!-- <div>								<a href="javascript:history.go(-1);" id="addFunc" class="layui-btn layui-btn-sm"><i class="layui-icon">&#xe603;</i> 返回</a>								<a href="" id="addFunc" class="layui-btn layui-btn-sm layui-btn-normal"><i class="layui-icon">&#xe618;</i> 保存</a>							</div> -->							<form class="layui-form form" action="">								<input type="hidden" id="id" name="id" value="${user.id }" />							  <div class="layui-form-item">							    <label class="layui-form-label">登录名</label>							    <div class="layui-input-block">							      <input type="text" name="loginName" value="${user.loginName }" lay-verify="required" autocomplete="off" placeholder="请输入登录名" class="layui-input">							    </div>							  </div>							  <div class="layui-form-item">							    <label class="layui-form-label">密码</label>							    <div class="layui-input-block">							      <input type="text" name="password" value="${user.password }" lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">							    </div>							  </div>							<div class="layui-form-item">									<label class="layui-form-label">角色</label>									<div class="layui-input-block">										<select name="role" lay-filter="role">											<option <c:if test="${user.role == 1}">selected</c:if> value="1">普通用户</option>											<option <c:if test="${user.role == 0}">selected</c:if> value="0">超级管理员</option>											<option <c:if test="${user.role == 2}">selected</c:if> value="2">限制级用户</option>										</select>									</div>								</div>							<div class="layui-form-item">									<label class="layui-form-label">区域</label>									<div class="layui-input-block">										<select name="areaId" lay-filter="areaId">											<c:forEach items="${areaList }" var="area" >												<option <c:if test="${area.id == user.areaId}">selected</c:if> value="${area.id }">${area.areaName }</option>											</c:forEach>										</select>									</div>								</div>							<div class="layui-form-item layui-form-text">							    <label class="layui-form-label">描述</label>							    <div class="layui-input-block">							      <textarea name="description" lay-verify="required" placeholder="请输入描述" class="layui-textarea">${user.description }</textarea>							    </div>							  </div>							<div class="layui-form-item">							  <div class="layui-input-block">								<a href="javascript:history.go(-1);" id="addFunc" class="layui-btn layui-btn-sm"><i class="layui-icon">&#xe603;</i> 返回</a>								<a id="addFunc" lay-submit lay-filter="formSave" class="layui-btn layui-btn-sm layui-btn-normal"><i class="layui-icon">&#xe618;</i> 保存</a>								<button type="reset" class="layui-btn layui-btn-sm layui-btn-primary"><i class="layui-icon">&#x1006;</i> 重置</button>								</div>							</div>							</form>						</div>					</div>				</div>			</div>		</div>		<jsp:include page="adminFooter.jsp"></jsp:include>	</div>	<script type="text/javascript" src="<%=basePath%>js/sysUserAdd.js" charset="utf-8"></script></body></html>