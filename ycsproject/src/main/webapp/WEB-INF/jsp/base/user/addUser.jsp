<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/layui/css/layui.css" />
    
</head>

<body>
    <div class="layui-layout layui-layout-register">
        <form class="layui-form layui-form-pane" action="">
            <table style="border-collapse:separate; border-spacing:30px 25px;">
                <tr>
                    <td>
                        <div class="layui-form-item">
                            <label class="layui-form-label"><span style="color:red">*</span>&nbsp;用户账号</label>
                            <div class="layui-input-block">
                                <input type="text" id="sysuser_userid" name="sysuserCustom.userid" required
                                    lay-verify="userid" placeholder="请输入用户账号" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </td>
                    <td>
                        <div class="layui-form-item">
                            <label class="layui-form-label"><span style="color:red">*</span>&nbsp;用户名称</label>
                            <div class="layui-input-block">
                                <input type="text" id="sysuser_username" name="sysuserCustom.username"
                                    required lay-verify="required|username" placeholder="请输入用户名称" autocomplete="off"
                                    class="layui-input">
                            </div>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>
                        <div class="layui-form-item">
                            <label class="layui-form-label"><span style="color:red">*</span>&nbsp;用户密码</label>
                            <div class="layui-input-block">
                                <input type="password"  id="sysuser_password" name="sysuserCustom.pwd"
                                     lay-verify="pwd" placeholder="请输入用户密码" autocomplete="off"
                                    class="layui-input">
                            </div>
                        </div>
                    </td>
                    <td>
                        <div class="layui-form-item">
                            <label class="layui-form-label"><span style="color:red">*</span>&nbsp;用户类型</label>
                            <div class="layui-input-block">
                                <select name="sysuserCustom.groupid" id="sysuser_groupid" lay-verify="required" lay-filter="role">
                                    <option value=""></option>
                                    <option value="1">卫生局</option>
									<option value="2">卫生院</option>
									<option value="3">卫生室</option>
									<option value="4">供货商</option>
								 	<option value="0">系统管理员</option>
                                </select>
                            </div>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>
                        <div class="layui-form-item">
                            <label class="layui-form-label"><span style="color:red">*</span>&nbsp;单位名称</label>
                            <div class="layui-input-block">
                                <input type="text" id="sysuserCustom_sysmc" name="sysuserCustom.sysmc" required
                                    lay-verify="required" placeholder="请输入用户单位名称" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </td>
                    <td>
                        <div class="layui-form-item">
                            <label class="layui-form-label"><span style="color:red">*</span>&nbsp;用户状态</label>
                            <div class="layui-input-block" >
                            	 <input type="radio" lay-verify="state" name="sysuserCustom.userstate" value="1" title="正常" checked/>
                                 <input type="radio" lay-verify="state" name="sysuserCustom.userstate" value="0" title="暂停"/>
                            </div>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>
                        <div class="layui-form-item">
                            <button type="button" class="layui-btn" lay-submit="" lay-filter="submitform"
                                style="float:right;"><i class="layui-icon">&#xe61f;</i>添加</button>
                        </div>
                    </td>
                    <td>
                        <div class="layui-form-item">
                            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                        </div>
                    </td>
                </tr>
            </table>
        </form>
    </div>
<script src="${pageContext.request.contextPath }/js/jquery-1.11.0.min.js"></script>
<script src="${pageContext.request.contextPath }/layui/layui.js"></script>
<script type="text/javascript">
layui.use(['layer', 'form', 'element'], function () {
    element = layui.element;
    layer = layui.layer;
    form = layui.form;
    form.verify({
    	  username: function(value, item){ //value：表单的值、item：表单的DOM对象
    	    if(!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)){
    	      return '用户名不能有特殊字符';
    	    }
    	    if(/(^\_)|(\__)|(\_+$)/.test(value)){
    	      return '用户名首尾不能出现下划线\'_\'';
    	    }
    	  }
    	  ,userid: [
    	    /^[\S]{3,12}$/
    	    ,'用户账号必须3到12位，且不能出现空格'
    	  ] 
    	  ,pwd: [
      	    /^[\S]{4,16}$/
      	    ,'用户密码必须4到12位，且不能出现空格'
      	  ] 
    	});      
    form.on('submit(submitform)', function(data){
    	$.ajax({
    		  type: 'POST',
    		  url: "${pageContext.request.contextPath }/user/addSysuser.action",
    		  data: data.field,
    		  success: function(result){
    			  var data_v = result.resultInfo;
    				
    				//提交结果类型
    				var type=data_v.type;
    				//结果提示信息
    				var message=data_v.message;
    				//type=1代表成功
    			  if(type==1){
    				  layer.open({
 				       	 title:"提示信息"
 				        ,content: message
 				        ,btnAlign: 'c' //按钮居中
 				        ,icon: 1
 				        
 				      });
    			  }//0代表失败
    			  if(type==0){
       				  layer.open({
    				       	 title:"提示信息"
    				        ,content: message
    				        ,btnAlign: 'c' //按钮居中
    				        ,icon: 2
    				      });
    			  	}
    			 
    		  },
    		 /* error:function(date){
    			 
    			 var data_v = date.resultInfo;
    			 
 				//提交结果类型
 				var type=data_v.type;
 				
 				//结果提示信息
 				var message=data_v.message;
 				//type==0代表失败
 				 if(type==0){
   				  layer.open({
   				       	 title:"提示信息"
   				        ,content: message
   				        ,btnAlign: 'c' //按钮居中
   				        ,icon: 2
   				      });
   			  	} 
    		  }, */
    		  dataType: 'json'
    		});
    });
});
</script>
</body>
</html>