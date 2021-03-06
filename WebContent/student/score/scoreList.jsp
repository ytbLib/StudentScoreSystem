<%@ page language="java" contentType="text/html; charset=UTF-8"
	import = "java.sql.*, com.bqlib.model.*, 
	java.util.Date, java.util.ArrayList"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
pageContext.setAttribute("url", basePath);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">

    <!--引入 luyi 插件-->
    <link rel="stylesheet" href="../plugins/layui/css/layui.css" media="all" />

    <style type="text/css">
        body {
            margin: 3px 3px;
        }
        .color-black{
            color: #e1e2e3;
            background-color:#353c44;
        }
    </style>
</head>
<body>
    <div class="layui-col-md12 color-black">
        <div class="layui-row">
            <div class="layui-col-md4">
                <span class="title-font"><i class="layui-icon">&#xe623;成绩列表</i></span>
            </div>                  
        </div>
    </div>
    <div class="layui-col-md12">
        <table id="ScoreList" lay-filter="test"></table>       
    </div>
    <script src="../plugins/jquery/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="../plugins/layui/layui.js"></script>
    <script>
	    layui.use('table', function(){
	        var table = layui.table;
    	  
    	  //第一个实例
    	    var talbleIns = table.render({
	    	    elem: '#ScoreList',
	    	    //height: 315,
	    	    url: "${url}studentServlet?type=listScoreLimitBySid&sSno=${studentlogin.sSno }",//数据接口	 
	    	    cols: [[ //表头
	    	      {field: 'cName', title: '课程名', sort: true, align: 'center'},
	    	      {field: 'tName', title: '教师', align: 'center'},
	    	      {field: 'usualResults', title: '平时成绩', sort: true, align: 'center',sort: true},
	    	      {field: 'examResults', title: '实验成绩', align: 'center', sort: true},
	    	      {field: 'experimentalResults', title: '考试成绩', align: 'center'},
	    	      {field: 'totalScore', title: '总成绩', sort: true, align: 'center'},
	    	    ]],
	    	    page: {
                    layout: ['limit', 'prev', 'page', 'next', 'count', 'skip'],
                    groups: 10
                },
                id:'idTest',
    	    });    	  
    	    table.on('tool(test)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
    	        var data = obj.data,       //获得当前行数据
    	            layEvent = obj.event;  //获得 lay-event 对应的值
    	        
    	        //查看详情操作
    	        if (layEvent === 'detail') {
    	        	window.location.href = "${url}administratorServlet?type=getTeacherBySno&toPage=teacherDetial&tSno="+data.tSno;
                    return ;
    	        } 
    	        
    	        //删除操作
    	        if (layEvent === 'del') {
    	            layer.confirm('确定要删除吗？', function(index){
	            	   obj.del(); 
	            	   layer.close(index);
	            	   var url = "${url}administratorServlet?type=deleteTeacher";
	            	   $.post(url,{"tSno":data.tSno}, function(message){
	            		   layer.msg(message);
	            		   talbleIns.reload({
	                           url: '${url}administratorServlet?type=listTeacherLimit'
	                       });
	            	   }, "text");	            	   
    	            });
    	            return;
    	        }
    	        //编辑操作
    	        if (layEvent === 'edit') {
    	        	window.location.href = "${url}administratorServlet?type=getTeacherBySno&toPage=editTeacher&tSno="+data.tSno;	          
    	          return ;
    	        }
    	      });   	    

    	    var $ = layui.$, active = {
				getCheckData: function(){ //获取选中数据
					var checkStatus = table.checkStatus('idTest'),
					data = checkStatus.data;
					//layer.alert(JSON.stringify(data));
					if (data.length == 0){
						layer.alert("请选择要删除的教师");
						return ;
					}
					layer.confirm('确定要删除吗？', function(index){
                        layer.close(index);
                        console.log(data);
                        for (var i = 0; i < data.length; i++){
                            var teacher = data[i];
                            var url = "${url}administratorServlet?type=deleteTeacher";  
                            $(document).queue("post", 
                                $.ajax({
                                    url: url,
                                    data: {"tSno":teacher.tSno}, 
                                    type:"post",
                                    dataType: "text",
                                    success:function(message){
                                           layer.msg(message);                                              
                                           $(document).dequeue("post");
                                           talbleIns.reload({
                                               url: '${url}administratorServlet?type=listTeacherLimit'
                                                   });
                                    },
                                    error:function(){
                                        $(document).queue("post", [] );
                                    }
                            }));                               
                        } 
                        $(document).dequeue("post");
                    });					
				},
				editStudent: function(){
					var checkStatus = table.checkStatus('idTest'),
					data = checkStatus.data;
					if (data.length <= 0){
                        layer.alert("请选择要编辑的教师");
                        return ;
                    }
					if (data.length > 1){
                        layer.alert("一次只能编辑一个教师");
                        return ;
                    }
					window.location.href = "${url}administratorServlet?type=getTeacherBySno&toPage=editTeacher&tSno="+data[0].tSno;
				},	
	        };
    	    
    	    $('.demoTable .layui-btn').on('click', function(){
    	      var type = $(this).data('type');
    	      active[type] ? active[type].call(this) : '';
    	    });
	    	  
	    });
    </script>
</body>
</html>