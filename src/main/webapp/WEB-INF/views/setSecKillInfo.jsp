<%--
  Created by IntelliJ IDEA.
  User: zqb
  Date: 2018/4/20
  Time: 10:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path;
%>
<html>
<head>
    <title>设置商品秒杀信息</title>
    <link href="<%=basePath%>/static/iview/styles/iview.css" rel="stylesheet" type="text/css"/>
    <link href="<%=basePath%>/static/bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="<%=basePath%>/static/css/header.css" rel="stylesheet" type="text/css"/>
    <style>
        .ivu-form-item
        {
            margin-bottom: 48px;
        }


        .ivu-date-picker
        {
            width:100%;
        }
    </style>
</head>
<body>
<div v-cloak id="app">
    <i-form ref="form" :model="seckill" :rules="validate" :label-width="120">
        <div style="padding:20px;">
            <Form-item label="商品名称：" prop="goods" style="margin-top: 20px;">
                <i-Input v-model="seckill.goods.goodsName" type="text"  maxlength="255" disabled></i-Input>

            </Form-item>

            <Form-item label="秒杀数目：" prop="restNum">
                <i-Input v-model="seckill.restNum" type="number" min="0" ></i-Input>
            </Form-item>

            <Form-item label="秒杀价格：" prop="seckillPrice">
                <i-Input v-model="seckill.seckillPrice" type="number" ></i-Input>
            </Form-item>

            <Form-item label="开始秒杀时间：" prop="seckillBeginTime">
                <Date-Picker type="datetime" format="yyyy-MM-dd HH:mm:ss" v-model="seckill.seckillBeginTime" placement="bottom"></Date-Picker>
            </Form-item>


        </div>
    </i-form>
</div>
<script type="text/javascript" src="<%=basePath%>/static/js/jquery-2.0.0.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/iview/vue.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/iview/iview.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/common.js"></script>
<script type="text/javascript">
    //# sourceURL=setSecKillInfo.js

    var app = new Vue({
        el: "#app",

        data: {
            seckill: {
                id: "",
                goods: {
                    id: "${goods.id}",
                    goodsName: "${goods.goodsName}",
                },
                restNum:"",
                seckillPrice:"",
                seckillBeginTime:"",
            },
            // 验证规则
            validate: {
                restNum:[{required: true, message: '秒杀数目不能为空', trigger: 'blur' }],
                seckillPrice:[{required: true, message: '秒杀价格不能为空', trigger: 'blur' }],
                seckillBeginTime:[{required: true, type: 'date',message: '开始秒杀时间不能为空', trigger: 'change' }],
            }

        }
    });


    // 提交表单
    function submit() {

        app.$refs["form"].validate(function (valid) {
            if (valid)
            {
                var data={
                    "seckill":JSON.stringify(app.seckill)
                };
                ajaxPost("/onlineSale/myStore/setSecKill",data,function (res) {
                    parent.app.secKillModal.show=false;
                },null,false);
            }
            else
            {
                //假装提交
                parent.app.secKillModal.loading = false;
                setTimeout("parent.app.secKillModal.loading = true", 100);
                app.$Message.error('请正确填写信息!');
            }
            parent.app.secKillModal.loading = false;
        });

    }
</script>
</body>
</html>
