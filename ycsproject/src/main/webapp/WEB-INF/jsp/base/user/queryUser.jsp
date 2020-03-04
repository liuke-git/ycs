<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta charset="utf-8">
  <title>table模块快速使用</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath }/layui/css/layui.css">
  <style type="text/css">
  	.layui-table-cell .layui-form-checkbox[lay-skin="primary"]{top: 50%;transform: translateY(-50%)}
  </style>
</head>
<body>
 	<div>
 		
 		<form id="userForm" class="layui-form layui-form-pane">
 			<table style="border-collapse:separate; border-spacing:5px 2px;">
 				<tr>
 					<td>
 						<div class="layui-form-item">
 							<label class="layui-form-label">用户账号</label>
 							<div class="layui-input-block">
 								<input class="layui-input" name="sysuserCustom.userid" autocomplete="off">
 							</div>
 						</div>
 					</td>
 					<td>
 						<div class="layui-form-item">
 							<label class="layui-form-label">用户名称</label>
 							<div class="layui-input-block">
 								<input class="layui-input" name="sysuserCustom.username"  autocomplete="off">
 							</div>
 						</div>
 					</td>
 					<td>
 						<div class="layui-form-item">
 							<label class="layui-form-label">单位名称</label>
 							<div class="layui-input-block">
 								<input class="layui-input" name="sysuserCustom.sysmc" autocomplete="off">
 							</div>
 						</div>
 					</td>
 					<td>
 						<div class="layui-form-item" id="jobError">
 							<label class="layui-form-label">用户类型</label>
 							<div class="layui-input-block">
 								<select lay-filter="job" name="sysuserCustom.groupid">
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
 					<td>
 						<div class="layui-form-item">
 							<!--<div class="layui-input-block">-->
 								<button type="button" class="layui-btn" id="queryUser">&nbsp;&nbsp;<i
 		                                        class="layui-icon">&#xe615;</i>搜&nbsp;&nbsp;索&nbsp;&nbsp;</button>
 							<!--</div>-->
 						</div>
 					</td>
 				</tr>
 		
 			</table>
 		
 		</form>
 		
 		<table id="userTable" lay-filter="test"></table>
 		 <script type="text/html" id="toolbarDemo">
 		 	<button class="layui-btn layui-btn-sm" lay-event="add"><i
                class="layui-icon">&#xe654;</i>添加</button>
            <button class="layui-btn layui-btn-sm" data-type="getCheckData" lay-event="delete_many"><i
                class="layui-icon">&#xe640;</i>批量删除</button>
        </script>
        
        <script type="text/html" id="barDemo">
            <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
        </script>
        
        
 	</div>

 
<script src="${pageContext.request.contextPath }/js/jquery-1.11.0.min.js"></script>
<script src="${pageContext.request.contextPath }/js/custom.box.main.js"></script>
<script src="${pageContext.request.contextPath }/layui/layui.js"></script>
<script>
layui.use('table', function(){
  var table = layui.table;
  
  //第一个实例
  table.render({
    elem: '#userTable'
    ,height: 'full-60', 
    cellMinWidth: 80
    ,even: true
    ,id: 'user'
    ,url: '${pageContext.request.contextPath }/user/queryuser_result.action' //数据接口
    ,page: true //开启分页
    ,limits: [5,10,20,30,50,80]
    ,cols: [[ //表头
       { type: 'checkbox', width: 50, fixed: 'left' },
       { type: 'numbers', title:"ID", width: 45, fixed: 'left' },
       {field: 'userid', title: '账号', align: 'center', width:150}
      ,{field: 'username', title: '名称', align: 'center', width:180}
      ,{filed: 'groupid', title: '用户类型',align: 'center', width:120, templet:function(d) {			
    	  var t = d.groupid;		
    	  if(t==1){				
    		  return '卫生局'			}
    	  else if(t==2){			
    		  return '卫生院'			}
    	  else if(t==3){			
    		  return '卫生室'			}
    	  else if(t==4){			
    		  return '供应商'			}	
    	  else if(t==0){			
    		  return '系统管理员'		}	
		}
      }
      ,{field: 'sysmc', title: '所属单位',align: 'center', width: 200} 
      ,{field: 'userstate', title: '状态', align: 'center', width: 100, templet:function(d) {			
    	  var t = d.userstate;		
    	  if(t==1){				
    		  return '正常'			}
    	  else if(t==0){			
    		  return '暂停'			}
		}}
      ,{field: 'opertation', title: '操作', toolbar: '#barDemo', align: 'center', width: 150}
      
    ]]
    ,toolbar: '#toolbarDemo'//设置表头工具栏
    
  });
  
  //表头工具栏监听事件
  table.on('toolbar(test)', function(obj){
    var checkStatus = table.checkStatus(obj.config.id);
    switch(obj.event){
      case 'add':
    	  layer.open({
    	        type: 1
    	        ,title: "添加用户"
    	        ,maxmin: true
    	        ,id: 'addUser' //防止重复弹出
    	        ,area: ['750px', '500px']
    	        ,content: '<iframe scrolling="no" frameborder="0" src="${pageContext.request.contextPath }/user/addUserpage.action" style="width:700px;height:450px;"></iframe>'
    	        ,shade: 0 //不显示遮罩
    	        ,end:function(){
    	        	//table.reload('userTable',{  });//弹出层结束后，刷新主页面
    	        	$(".layui-laypage-btn").click() ;
			       }
    	      });
      break;
      case 'delete_many':   //批量删除
    	  if(checkStatus.data.length==0){
  			parent.layer.msg('请先选择要删除的数据行！', {icon:0});
  			return ;
  		}else{
  			var total = checkStatus.data.length;
  			layer.confirm("您确定要删除所选的"+total+"个用户吗?", function (index) {
      		  var ids = "";
      			for(var i=0;i<checkStatus.data.length;i++){
      				ids += checkStatus.data[i].id+",";
      			}
      			$.post(
      					'${pageContext.request.contextPath }/user/batch_deleteSysuser.action', 
      					{'ids':ids}, 
      					function(data){	
      						 var data_v = data.resultInfo;
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
     		   				        ,end:function(){ $(".layui-laypage-btn").click() ;/* location.reload(); */}
     		   				      });
     		      			  }else{
	     		      				layer.open({
	   	    				       	 title:"提示信息"
	   	    				        ,content: "删除失败！"
	   	    				        ,btnAlign: 'c' //按钮居中
	   	    				        ,icon: 2
	   	    				      });
     		      			  }
      					},
      					"json"
      			);
  			});
  		}
      break;
    };
   
  });
  //表格行工具监听事件
  table.on('tool(test)', function (obj) {
      var data = obj.data;
      
      if (obj.event === 'del') {
    	  layer.confirm("您确定要删除账号为"+data.userid+"的用户吗?", function (index) {
    		  var id = data.id;
    		  $.ajax({
        		  type: 'POST',
        		  url: "${pageContext.request.contextPath }/user/deleteSysuser.action",
        		  data: {"id":id},
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
	   				        ,end:function(){ $(".layui-laypage-btn").click() ;/* location.reload(); */}
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
        		  dataType: 'json'
    		  });
    	  });
      }
      if (obj.event === 'edit') {
    	  var id = data.id;
    	  layer.open({
  	        type: 1
  	        ,title: "修改用户"
  	        ,maxmin: true
  	        ,id: 'editUser' //防止重复弹出
  	        ,area: ['750px', '500px']
  	        ,content: '<iframe scrolling="no" frameborder="0" src="${pageContext.request.contextPath }/user/editSysuser.action?id='+id+'" style="width:700px;height:450px;"></iframe>'
  	        ,shade: 0 //不显示遮罩
  	        ,end:function(){
  	        	//table.reload('userTable',{  });//弹出层结束后，刷新主页面
  	        	$(".layui-laypage-btn").click() ;
			       } 
  	      });
    	  
      }
  });
  
  //查询方法
  $("#queryUser").click(function(){
  	  
  	  //封装了一个js方法，把form表单的条件数据提取出来，封装成json数据。(custom.box.main.js)
  	  var formdata = $("#userForm").serializeJson();
  	   table.reload('user', {
  		  where:formdata
  	  /*  ,page: {
  		    curr: 1 //重新从第 1 页开始
  		  } */
  	   }); 
   });
});

</script>
</body>
</html>