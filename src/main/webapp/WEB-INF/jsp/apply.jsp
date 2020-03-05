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
        <li class="layui-nav-item"><a href="/view/index">管理物品</a></li>
        <li class="layui-nav-item"><a href="/view/apply">管理申请</a></li>
    </ul>
</div>
<%--<div class="layui-body">--%>
    <div class="main" style="width:1140px;height:550px;border: 0; margin-top: 5%;  margin: 0 auto">
        <div class="layui-form-item" style="margin:15px;height:30px;">
            <div class="layui-input-inline">
                <button class="layui-btn" id="btn" lay-filter="add" lay-event="add" data-type="reload" name="add"
                        onclick="myadd();">
                    <i class="layui-icon"></i>申领
                </button>
            </div>
        </div>
        <%--表格--%>
        <div>
            <table id="goods" lay-filter="goods"></table>
        </div>
        <%--修改窗--%>
        <div id="editForm" style="display:none;width:800px;padding-top:10px;">
            <form id="formData" class="layui-form">
                <%--<input type="hidden" name="goodsId" id="goodsId">--%>
                <div class="layui-form-item" lay-filter="test">
                    <%--<div style="color: red">*</div>--%>
                    <label class="layui-form-label">物品名称</label>

                    <div class="layui-input-inline">
                        <select name="recordsGoodsId" id="recordsGoodsId"   lay-verify="required" lay-filter="recordsGoodsId">
                        </select>
                    </div>
                </div>
                <div class="layui-form-item" lay-filter="test">
                    <label class="layui-form-label">领用人员</label>
                    <div class="layui-input-block">
                        <input type="text" name="recordsName" id="recordsName"  lay-verify="required"
                               placeholder="请输入人员名称"
                               value="" class="layui-input"/>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label"  lay-verify="required|Date">领用日期</label>
                    <div class="layui-input-inline">
                        <input type="text" id="recordsDate" name="recordsDate" class="layui-input"
                               style="float:left;width:100px;">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">领用数量</label>
                    <div class="layui-input-block">
                        <input type="text" name="recordsNum" id="recordsNum"  lay-verify="required|number"
                               placeholder="请输入领用数量"
                               value="" class="layui-input"/>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">物品备注</label>
                    <div class="layui-input-block">
                <textarea name="recordsDesc" id="recordsDesc"  lay-verify="required"
                          class="layui-textarea"></textarea>
                    </div>
                </div>
            </form>
        </div>
    </div>
<script type="text/javascript">

    var table;
    var layer;
    var form;
    var upload;
    layui.use(['layer', 'table', 'form', "laydate"], function () {
        table = layui.table;
        layer = layui.layer;
        form = layui.form;
        layui.laytpl.fn = function (value) {
            //json日期格式转换为正常格式
            var date = new Date(parseInt(value.replace("/Date(", "").replace(")/", ""), 10));
            var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
            var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
            return date.getFullYear() + "-" + month + "-" + day;
        }
        //--------------方法渲染TABLE----------------
        var tableIns = table.render({
            elem: '#goods'
            , id: 'goods'
            , url: 'record/findBySplitPage'
            , cols: [[
                {checkbox: true, LAY_CHECKED: false} //其它参数在此省略
                , {field: 'recordsId', title: '物品id', width: 0, align: 'center'}
                , {field: 'goodsName', title: '物品名称', width: 180, align: 'center'}
                , {field: 'recordsName', title: '领用人员', width: 180, align: 'center'}
                , {field: 'recordsDate', title: '领用时间', width: 220, align: 'center'}
                , {field: 'recordsNum', title: '领用数量', width: 120, align: 'center'}
                , {field: 'recordsDesc', title: '领用说明', width: 120, align: 'center'}
                // , {title: '操作', fixed: 'right', width: 190, align: 'center', toolbar: '#bar'}
            ]]
            , page: true
            , limits: [5, 10, 15]
            , limit: 10 //默认采用10
            , done: function (res, curr, count) {
                //如果是异步请求数据方式，res即为你接口返回的信息。
                //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
                //console.log(res);
                //得到当前页码
                //console.log(curr);
                $("#curPageIndex").val(curr);
                //得到数据总量
                //console.log(count);
            }
        });
        //下拉框
        $.ajax({
            type: "POST",
            url: "goods/findAll",
            success: function (arr) {
                var str = "<option value=''>请选择物品</option>";
                for (var i = 0; i < arr.length; i++) {
                    str = str + "<option value='" + arr[i].goodsId + "'>" + arr[i].goodsName + "</option>";
                }
                $("#recordsGoodsId").html(str);
                form.render();
            }
        });

        // 时间选择
        var laydate = layui.laydate;
        //执行一个laydate实例
        laydate.render({
            elem: '#recordsDate' //指定元素
        });

        // // #region --------------新增----------------
        $(document).on('click', '#btn', function () {
            layer.open({
                type: 1,
                title: '编辑物品信息',
                shade: 0.4,  //阴影度
                fix: false,
                shadeClose: true,
                maxmin: false,
                area: ['900px;', '540px;'],    //窗体大小（宽,高）
                content: $('#editForm'),
                success: function (layero, index) {
                    var body = layer.getChildFrame('body', index); //得到子页面层的BODY
                    form.render();
                    body.find('#hidValue').val(index); //将本层的窗口索引传给子页面层的hidValue中
                },
                btn: ['保存', '取消'],
                //表单校验
                success: function (layero) {
                    $(':focus').blur();
                    // 添加form标识
                    layero.addClass('layui-form');
                    // 将保存按钮改变成提交按钮
                    layero.find('.layui-layer-btn0').attr({
                        'lay-filter': 'formDemo',
                        'lay-submit': ''
                    });
                    form.render();
                },
                yes: function (index, layero) {
                    // 修改    form数据发送封装到后端实体类，必须name属性名与实体类一一对应
                    $.post('record/addRecord', $('#formData').serialize(), function (data) {
                        if (data == 'success') {
                            parent.layer.msg('添加成功', {icon: 1, shade: 0.4, time: 1000});
                            //重载table
                            tableIns.reload({
                                where: {
                                    keyword: 0
                                }, page: {
                                    curr: 1 //重新从第 1 页开始
                                }
                            });
                        } else {
                            parent.layer.msg('添加失败，可能库存不够了！', {icon: 5, shade: 0.4, time: 1000});
                        }
                        $("#newImg").html("");
                        layer.close(index);
                    });
                }
            });
        });
        //     }
        // });

    });
</script>
</body>
</html>