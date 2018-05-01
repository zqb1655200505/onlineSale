<%--
  Created by IntelliJ IDEA.
  User: zqb
  Date: 2018/4/23
  Time: 10:57
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
    <title>编辑商品秒杀信息</title>
    <link href="<%=basePath%>/static/iview/styles/iview.css" rel="stylesheet" type="text/css"/>
    <link href="<%=basePath%>/static/bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="<%=basePath%>/static/css/header.css" rel="stylesheet" type="text/css"/>
    <style>
        .ivu-form-item
        {
            margin-bottom: 25px;
        }
        .ivu-input[disabled]
        {
            color: black;
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
            <Form-item label="商品名称：" prop="goods">
                <i-Input v-model="seckill.goods.goodsName" type="text"  maxlength="255" disabled></i-Input>

            </Form-item>

            <Form-item label="商品数目：" prop="goods">
                <i-Input v-model="seckill.goods.goodsNum" type="number"  maxlength="255" disabled></i-Input>
            </Form-item>

            <Form-item label="商品价格：" prop="goods">
                <i-Input v-model="seckill.goods.goodsPrice" type="number"  maxlength="255" disabled></i-Input>
            </Form-item>

            <Form-item label="秒杀价格：" prop="seckillPrice">
                <i-Input v-model="seckill.seckillPrice" type="number" ></i-Input>
            </Form-item>

            <Form-item label="秒杀数目：" prop="restNum">
                <i-Input v-model="seckill.restNum" type="number" ></i-Input>
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
    //# sourceURL=secKillForm.js

    var app = new Vue({
        el: "#app",

        data: {
            seckill: {
                id: "${seckill.id}",
                goods: {
                    id: "${seckill.goods.id}",
                    goodsName: "${seckill.goods.goodsName}",
                    goodsPrice: "${seckill.goods.goodsPrice}",
                    goodsNum: "${seckill.goods.goodsNum}",
                },
                restNum:"${seckill.restNum}",
                seckillPrice:"${seckill.seckillPrice}",
                seckillBeginTime:getDateTime('${seckill.seckillBeginTime}'),
            },

            const: validateRestNumCheck = function (rule, value, callback) {

                if (value === '') {
                    callback(new Error('秒杀数目不能为空'));
                }
                else if(Number(value)<0)
                {
                    callback(new Error('秒杀数目不能小于0!'));
                }
                else if ((Number(value) - Number(app.seckill.goods.goodsNum))>0) {
                    callback(new Error('秒杀数目不能高于商品余量!'));
                }
                else
                {
                    callback();
                }
            },
            const: validateSecKillPriceCheck = function (rule, value, callback) {

                if (value === '') {
                    callback(new Error('秒杀价格不能为空'));
                }
                else if(value<0)
                {
                    callback(new Error('秒杀价格不能小于0!'));
                }
                else {
                    callback();
                }
            },
            // 验证规则
            validate: {
                restNum:[{required: true,validator: validateRestNumCheck}],
                seckillPrice:[{required: true,validator: validateSecKillPriceCheck}],
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
                    parent.app.editModal.show=false;
                    parent.changePage();
                },null,false);
            }
            else
            {
                //假装提交
                parent.app.editModal.loading = false;
                setTimeout("parent.app.editModal.loading = true", 100);
                parent.app.$Message.error('请正确填写信息!');
            }
            parent.app.editModal.loading = false;
        });

    }

    //cst转换有问题
    function getDateTime(time) {
        var d=new Date(time);
        var year=d.getFullYear();
        var month=d.getMonth();
        var arr=time.split(" ");
        return year+"-"+month+"-"+arr[2]+" "+arr[3];
    }
</script>
</body>
</html>
