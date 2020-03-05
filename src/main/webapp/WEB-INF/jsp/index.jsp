<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>物品管理</title>
    <link rel="stylesheet" href="/static/css/layui.css">
    <script src="/static/js/jquery.1.12.4.min.js"></script>
    <script src="/static/js/layui.js"></script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <!--导航条-->
    <ul class="layui-nav layui-nav-tree" lay-filter="test">
        <li class="layui-nav-item"><a href="">管理物品</a></li>
        <li class="layui-nav-item"><a href="/view/apply">管理申请</a></li>
    </ul>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <iframe src="/view/manage" name="myframe" style="width:1140px;height:550px;border: 0;"></iframe>
    </div>
</div>

<script>
    //JavaScript代码区域
    layui.use(['element', 'layer', 'table'], function () {
        var element = layui.element;
        var table = layui.table;
        var layer = layui.layer;
    });
</script>
</body>
</html>