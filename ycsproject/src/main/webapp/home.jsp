<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>layout 后台大布局 - Layui</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath }/layui/css/layui.css">
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
	  <div class="layui-header">
	    <div class="layui-logo">阳春市医药交易及监督平台</div>
	    <!-- 头部区域（可配合layui已有的水平导航） -->
	   <!-- <ul class="layui-nav layui-layout-left">
	      <li class="layui-nav-item"><a href="">控制台</a></li>
	      <li class="layui-nav-item"><a href="">商品管理</a></li>
	      <li class="layui-nav-item"><a href="">用户</a></li>
	      <li class="layui-nav-item">
	        <a href="javascript:;">其它系统</a>
	        <dl class="layui-nav-child">
	          <dd><a href="">邮件管理</a></dd>
	          <dd><a href="">消息管理</a></dd>
	          <dd><a href="">授权管理</a></dd>
	        </dl>
	      </li>
	    </ul>-->
	    <ul class="layui-nav layui-layout-right">
	      <li class="layui-nav-item">
	        <a href="javascript:;">
	               欢迎当前用户：张三
	        </a>
	        
	      </li>
	      <li class="layui-nav-item"><a href="">退出系统</a></li>
	    </ul>
	  </div>
	  
	  <div class="layui-side layui-bg-black">
	  	<div class="layui-side-scroll">
	  		<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
	  		<ul class="layui-nav layui-nav-tree"  lay-filter="test">
	        <li class="layui-nav-item layui-nav-itemed">
	          <a class="" href="javascript:;">药品目录</a>
	          <dl class="layui-nav-child">
	            <dd><a href="javascript:;">列表一</a></dd>
	            <dd><a href="javascript:;">列表二</a></dd>
	            <dd><a href="javascript:;">列表三</a></dd>
	            <dd><a href="">超链接</a></dd>
	          </dl>
	        </li>
	        <li class="layui-nav-item">
	          <a href="javascript:;">医院信息管理</a>
	          <dl class="layui-nav-child">
	            <dd><a href="javascript:;">列表一</a></dd>
	            <dd><a href="javascript:;">列表二</a></dd>
	            <dd><a href="">超链接</a></dd>
	          </dl>
	        </li>
	        <li class="layui-nav-item">
	          <a href="javascript:;">采购单管理</a>
	          <dl class="layui-nav-child">
	            <dd><a href="javascript:;">列表一</a></dd>
	            <dd><a href="javascript:;">列表二</a></dd>
	            <dd><a href="">超链接</a></dd>
	          </dl>
	        </li>
	        <li class="layui-nav-item">
	          <a href="javascript:;">退货单单管理</a>
	          <dl class="layui-nav-child">
	            <dd><a href="javascript:;">列表一</a></dd>
	            <dd><a href="javascript:;">列表二</a></dd>
	            <dd><a href="">超链接</a></dd>
	          </dl>
	        </li>
	        <li class="layui-nav-item">
	          <a href="javascript:;">统计分析</a>
	          <dl class="layui-nav-child">
	            <dd><a href="javascript:;">列表一</a></dd>
	            <dd><a href="javascript:;">列表二</a></dd>
	            <dd><a href="">超链接</a></dd>
	          </dl>
	        </li>
	        <li class="layui-nav-item">
	          <a href="javascript:;">用户管理</a>
	          <dl class="layui-nav-child">
	            <dd><a href="javascript:;">监督单位</a></dd>
	            <dd><a href="javascript:;">医院</a></dd>
	            <dd><a href="">供应商</a></dd>
	            <dd id="btn-systemuser"><a href="javascript:;">系统用户</a></dd>
	          </dl>
	        </li>
	        
     	  </ul>
	  	</div>
	  </div>
	  
	  <div class="layui-body">
	    <!-- 内容主体区域 -->
	    <div class="layui-tab layui-tab-card" lay-filter="tab" lay-allowclose="true">
	    	<ul class="layui-tab-title">
	    		<li class="layui-this" id="tabs">欢迎使用</li>
	    	</ul>
	    	<div class="layui-tab-content">
	    		<div class="layui-tab-item layui-show" style="padding-top:250px;height:300px;background-color: whitesmoke;">
	    				<p style="font-family: KaiTi;font-size: 30px;" align="center">
	    					欢迎进入阳春市医药交易及监督平台系统
	    				</p>
	    			<!--<span style="font-family: KaiTi;font-size: 30px;color: white;">欢迎进入阳春市医药交易及监督平台系统</span>-->
	    		</div>
	    	</div>
	    </div>
	  </div>
	  
	  <div class="layui-footer">
	    <!-- 底部固定区域 -->
	    © layui.com - 底部固定区域
	  </div>
	</div>
	<script src="${pageContext.request.contextPath }/js/jquery-1.11.0.min.js"></script>
	<script src="${pageContext.request.contextPath }/layui/layui.js"></script>
	<script src="${pageContext.request.contextPath }/js/public.js"></script>
	<script>
	    //JavaScript代码区域
	    
	     function addTabs(title, url, id) {
            if ($(".layui-tab-title li[lay-id='" + id + "']").length > 0) {
                element.tabChange('tab', id);
            } else {
                element.tabAdd('tab', {
                    title: title
                    , content: '<iframe scrolling="no" frameborder="0" src="' + url + '" style="width:100%;height:600px;"></iframe>' //支持传入html
                    , id: id
                });
                element.tabChange('tab', id);
            }
        }
	   $(function(){
	   	/*
		   	layui.use('element', function(){
		        var element = layui.element;
		
		    });*/
		   $('#btn-systemuser').on('click', function() {
		  /* $('#btn-systemuser').click(function(){*/
	   	 		addTabs("系统用户列表","${pageContext.request.contextPath }/user/queryUser.action","tabs")
	   	 })
	   })
	
	</script>
</body>
</html>