<%@ page language="java" contentType="text/html; utf-8"
pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
pageContext.setAttribute("url", basePath);
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>新增院系信息</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">

    <!--引入 luyi 插件-->
    <link rel="stylesheet" href="../plugins/layui/css/layui.css" media="all" />
    <style>
        body {
            margin-left: 3px;
            margin-top: 0px;
            margin-right: 3px;
            margin-bottom: 0px;
            font-size: 12px;
        }

        .pic{
            width:130px;
            height:130px;
            border-radius:50% ;
            margin:20px auto;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="layui-container" style="margin-top: 10px">
<!-- <%//=basePath %>administratorServlet?type=addStudent-->
    <form action="" class="layui-form" method="post" id="addinfomation">
       <div id="hiddenInput">
       <input type="hidden" name="sPhotoPath" value="">
       </div>
        <div class="layui-row">
            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                <legend>新增院系信息</legend>
            </fieldset>
            <div class="layui-col-md12">
                <div class="layui-row">
                    <div class="layui-col-md8 layui-col-md-offset2">
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">院系编号<span style="color: red">*</span></label>
                                <div class="layui-input-inline">
                                    <input type="text" name="dId" lay-verify="dId" placeholder="" value="${department.dId }" autocomplete="off" class="layui-input" disabled="disabled">
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">院系名称<span style="color: red">*</span></label>
                                <div class="layui-input-inline">
                                    <input type="text" name="dName" lay-verify="dName" placeholder="" value="${department.dName }" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label">院系地址</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="dAddress" lay-verify="dAddress" placeholder="" value="${department.dAddress }" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-col-md12">
                <div class="layui-row">
                    <div class="layui-col-md4 layui-col-md-offset4">
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <button class="layui-btn" lay-submit="" lay-filter="demo1">保存</button>
                                <button type="reset" class="layui-btn layui-btn-primary" id="reset">重置</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
<script src="../plugins/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="../plugins/layui/layui.js"></script>
<script>
    layui.use(['form', 'layer'], function() {
        var form = layui.form,
            layer = layui.layer;

        //自定义验证规则
        form.verify({        
            pName: function (value) {
                if(value.length < 1){
                    return '专业名称不能为空';
                }
            },
            department: function(value) {
                if (value.length <= 0) {
                    return "所属院系不能为空" ;
                }
            }
        });

        //监听提交
        form.on('submit(demo1)', function(data) {
            //layer.alert(JSON.stringify(data.field), {
              //  title: '最终的提交信息'
            //});
            var url = "${url}administratorServlet?type=updateDepartment";
            $.post(url,data.field,function(result){
                alert(result);
                window.location.href = "${url}administratorServlet?type=getDepartmentById&pId=${department.dId}";
            },"text");          
            return false;
        });       
    });
</script>
</body>
</html>