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
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="/static/css/layui.css">
    <script type="text/javascript" src="/static/js/jquery.1.12.4.min.js"></script>
    <script type="text/javascript" src="/static/js/layui.js"></script>
</head>
<body>

<div class="layui-form-item" style="margin:15px;height:30px;">
    <div class="layui-input-inline">
        <button class="layui-btn" id="btn" lay-filter="add" lay-event="add" data-type="reload" name="add" onclick="myadd();">
            <i class="layui-icon"></i>新增
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
        <input type="hidden" name="goodsId" id="goodsId">
        <div class="layui-form-item">
            <label class="layui-form-label">物品名称</label>
            <div class="layui-input-block">
                <input type="text" name="goodsName" id="goodsName"  lay-verify="required" placeholder="请输入物品名称"
                       value="" class="layui-input"/>
            </div>
        </div>
        <div class="layui-form-item" lay-filter="test">
            <label class="layui-form-label">物品类别</label>
            <div class="layui-input-inline">
                <%--<select name="goodsType.typeId" id="goodsType" required lay-verify="required" lay-filter="goodsTypeId">--%>
                <%--</select>--%>
                <select name="goodsTypeID" id="goodsTypeID"  lay-verify="required" lay-filter="goodsTypeID">
                    <option value="1">电脑</option>
                    <option value="2">办公用品</option>
                    <option value="3">配件</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" >入库日期</label>
            <div class="layui-input-inline">
                <input type="text" id="goodsDate" name="goodsDate" lay-verify="required|Date" class="layui-input" style="float:left;width:190px;">
                <%--<input type="text" name="goodsData" id="goodsData" required lay-verify="required" placeholder="请输入商品价格" value="" class="layui-input" />--%>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" >库存量</label>
            <div class="layui-input-block">
                <input type="text" name="goodsNum" id="goodsNum"  lay-verify="required|number" placeholder="请输入物品库存"
                       value="" class="layui-input"/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">单位</label>
            <div class="layui-input-block">
                <input type="text" name="goodsUnit" id="goodsUnit"  lay-verify="required" placeholder="请输入单位"
                       value="" class="layui-input"/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">物品备注</label>
            <div class="layui-input-block">
                <textarea name="goodsDesc" id="goodsDesc"  lay-verify="required"
                          class="layui-textarea"></textarea>
            </div>
        </div>
    </form>
</div>
<script type="text/html" id="bar">
    <a class="layui-btn layui-btn-xs layui-btn-normal" title="修改" lay-event="edit">修改</a>
    <a class="layui-btn layui-btn-xs" title="删除" lay-event="delete">刪除</a>
</script>
<script type="text/html" id="dateTpl">
    {{ layui.laytpl.fn(d.editdate) }}
</script>
<script type="text/javascript">
    var table;
    var layer;
    var form;
    var upload;
    layui.use(['layer', 'table', 'form',"laydate"], function () {
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
            , url: 'goods/findBySplitPage'
            , cols: [[
                {checkbox: true, LAY_CHECKED: false} //其它参数在此省略
                , {field: 'goodsId', title: '物品id', width: 0, align: 'center'}
                , {field: 'goodsName', title: '物品名称', width: 180, align: 'center'}
                , {field: 'goodsType', title: '物品类别', width: 180, align: 'center'}
                , {field: 'goodsDate', title: '入库日期', width: 220, align: 'center'}
                , {field: 'goodsUnit', title: '单位', width: 120, align: 'center'}
                , {field: 'goodsNum', title: '库存', width: 120, align: 'center'}
                , {title: '操作', fixed: 'right', width: 190, align: 'center', toolbar: '#bar'}
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
        // 时间选择
        var laydate = layui.laydate;
        //执行一个laydate实例
        laydate.render({
            elem: '#goodsDate' //指定元素
        });

        // // #region --------------新增----------------
        $(document).on('click','#btn',function(){
            layer.open({
                type: 1,
                title: '新增物品信息',
                shade: 0.4,  //阴影度
                fix: false,
                shadeClose: true,
                maxmin: false,
                area: ['900px;', '540px;'],    //窗体大小（宽,高）
                content: $('#editForm'),
                // success: function (layero, index) {
                //     var body = layer.getChildFrame('body', index); //得到子页面层的BODY
                //     form.render();
                //     body.find('#hidValue').val(index); //将本层的窗口索引传给子页面层的hidValue中
                // },
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
                    // 保存
                    $.post('goods/addGoods', $('#formData').serialize(), function (data) {
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
                            parent.layer.msg('添加失败', {icon: 5, shade: 0.4, time: 1000});
                        }
                        $("#newImg").html("");
                        layer.close(index);
                    });
                }
            });
        });
        //     }
        // });
        //#endregion


        //工具条事件监听
        table.on('tool(goods)', function (obj) { //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值
            var tr = obj.tr; //获得当前行 tr 的DOM对象
            var goodsId = data.goodsId;
            if (layEvent === 'edit') { //编辑
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
                        $("#goodsId").val(data.goodsId);
                        $("#goodsName").val(data.goodsName);
                        $("#goodsTypeID").val(data.goodsTypeID);
                        $("#goodsDate").val(data.goodsDate);
                        $("#goodsUnit").val(data.goodsUnit);
                        $("#goodsNum").val(data.goodsNum);
                        $("#goodsDesc").val(data.goodsDesc);
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
                    //提交
                    yes: function (index, layero) {
                        // 修改
                        $.post('goods/updateGoods', $('#formData').serialize(), function (data) {
                            if (data == 'success') {
                                parent.layer.msg('修改成功', {icon: 1, shade: 0.4, time: 1000});
                                //重载table
                                tableIns.reload({
                                    where: {
                                        keyword: 0
                                    }, page: {
                                        curr: 1 //重新从第 1 页开始
                                    }
                                });
                            } else {
                                parent.layer.msg('修改失败', {icon: 5, shade: 0.4, time: 1000});
                            }
                            $("#newImg").html("");
                            layer.close(index);
                        });
                    }
                });
            } else if (layEvent === 'delete') {
                layer.confirm('是否删除该物品？', {
                    btn: ['确认', '取消'] //可以无限个按钮
                    , btn1: function (index, layero) {
                        $.ajax({
                            type: "POST",
                            url: "goods/delete",
                            data: "goodsId=" + data.goodsId,
                            success: function (msg) {
                                if (msg == 'success') {
                                    parent.layer.msg('删除成功', {icon: 1, shade: 0.4, time: 1000});
                                } else {
                                    parent.layer.msg('删除失败,可能还有库存！', {icon: 5, shade: 0.4, time: 1000});
                                }
                            }
                        });
                        //重载table
                        tableIns.reload({
                            where: {
                                keyword: 0
                            }, page: {
                                curr: 1 //重新从第 1 页开始
                            }
                        });
                        //删除该行（更新）
                        // $(tr).remove();
                        layer.close(index);
                    }
                });
            }
        });
    });
</script>
</body>
</html>