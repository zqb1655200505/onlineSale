<%@ page import="java.net.URLEncoder" %><%--
  Created by IntelliJ IDEA.
  User: zqb
  Date: 2018/5/23
  Time: 15:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path;
    String baseUrl="/onlineSale/consumer/goodsDetail?isSecKill=true&id=";
%>
<html>
<head>
    <title>优铺在线销售系统-秒杀商品</title>
    <link href="<%=basePath%>/static/iview/styles/iview.css" rel="stylesheet" type="text/css"/>
    <link href="<%=basePath%>/static/css/header.css" rel="stylesheet" type="text/css"/>
    <style>


        .goods-item-img
        {
            width: 100%;
        }
        .goods-item-description
        {
            font-size: 15px;
            padding: 10px;
            width: 100%;
            height: 50px;
            text-align: left;
        }
    </style>
</head>
<body>
<div class="layout" v-cloak id="app">
    <Layout>

        <Header>
            <i-menu mode="horizontal" theme="dark">
                <div class="layout-logo">
                    <a href="/onlineSale/index">
                        <img src="<%=basePath%>/upload/image/logo.png" class="logo-img">
                    </a>
                </div>
                <div class="layout-nav">
                    <template v-if="!haveLogin">
                        <Menu-Item name="login">
                            <a href="/onlineSale/login">
                                <Icon type="ios-navigate"></Icon>
                                登录
                            </a>
                        </Menu-Item>
                        <Menu-Item name="register">
                            <a href="/onlineSale/register">
                                <Icon type="ios-keypad"></Icon>
                                注册
                            </a>
                        </Menu-Item>
                    </template>

                    <Menu-Item name="username" v-else>
                        <a>
                            <template>
                                <Avatar id="userPic" :src="'<%=basePath%>'+avatarSrc"/>
                            </template>
                            <span>{{username}}</span>
                        </a>
                    </Menu-Item>

                    <Menu-Item name="MyCart">
                        <Badge :count="cartNum">
                            <a href="/onlineSale/myCart/">
                                <Icon type="ios-cart"></Icon>
                                购物车
                            </a>
                        </Badge>
                    </Menu-Item>
                    <Menu-Item name="MyOrder">
                        <a href="/onlineSale/myOrder/">
                            <Icon type="bag"></Icon>
                            我的订单
                        </a>
                    </Menu-Item>

                    <Menu-Item name="MyOrder" v-if="haveLogin && isSeller">
                        <a href="/onlineSale/myStore/">
                            <Icon type="home"></Icon>
                            我的店铺
                        </a>
                    </Menu-Item>

                    <Menu-Item name="logout" v-if="haveLogin">
                        <a style="color: #cd121b" href="/onlineSale/logout">
                            <Icon type="log-out"></Icon>
                            退出
                        </a>
                    </Menu-Item>
                </div>
            </i-menu>


        </Header>

        <Content class="layout-content-center" style="min-height: 650px;">

            <Row :gutter="64">
                <i-col v-for="(item,index) in seckillList" v-if="index%4==0" span="5" offset="2" style="margin-top: 30px;">
                    <Card>
                        <a :href="'<%=baseUrl%>'+item.id" target="_blank"><img :src="'<%=basePath%>'+item.goods.goodsPic" class="goods-item-img"></a>
                        <div class="goods-item-description">
                            <a :href="'<%=baseUrl%>'+item.id" target="_blank">{{item.goods.goodsName}}</a>
                        </div>
                        <div style="height: 60px;width: 100%;border: 1px solid red;">
                            <div style="width: 70%;height: 100%;float: left;">
                                <div style="width: 100%;height: 60%;text-align: left;padding-left: 15px;">
                                    <span style="color: red;font-size: 22px;line-height: 36px;">￥{{item.seckillPrice}}</span>
                                    <span style="text-decoration: line-through;color: #1c2438;font-size: 15px;line-height: 36px;">￥{{item.goods.goodsPrice}}</span>
                                </div>
                                <div style="width: 100%;height: 40%;text-align: left;padding-left: 30px;">
                                    <span style="color: grey;">库存：{{item.restNum}}</span>
                                </div>
                            </div>
                            <div style="width: 30%;height: 100%;float: right;text-align: center;cursor: pointer;background-color: red;color: white;">
                                <h4 style="line-height: 60px;">立即抢购</h4>
                            </div>
                        </div>
                    </Card>
                </i-col>
                <i-col v-else span="5" style="margin-top: 30px;">
                    <Card>
                        <a :href="'<%=baseUrl%>'+item.id" target="_blank"><img :src="'<%=basePath%>'+item.goods.goodsPic" class="goods-item-img"></a>
                        <div class="goods-item-description">
                            <a :href="'<%=baseUrl%>'+item.id" target="_blank">{{item.goods.goodsName}}</a>
                        </div>
                        <div style="height: 60px;width: 100%;border: 1px solid red;">
                            <div style="width: 70%;height: 100%;float: left;">
                                <div style="width: 100%;height: 60%;text-align: left;padding-left: 15px;">
                                    <span style="color: red;font-size: 22px;line-height: 36px;">￥{{item.seckillPrice}}</span>
                                    <span style="text-decoration: line-through;color: #1c2438;font-size: 15px;line-height: 36px;">￥{{item.goods.goodsPrice}}</span>
                                </div>
                                <div style="width: 100%;height: 40%;text-align: left;padding-left: 30px;">
                                    <span style="color: grey;">库存：{{item.restNum}}</span>
                                </div>
                            </div>
                            <div style="width: 30%;height: 100%;float: right;text-align: center;cursor: pointer;background-color: red;color: white;">
                                <h4 style="line-height: 60px;">立即抢购</h4>
                            </div>
                        </div>
                    </Card>
                </i-col>
            </Row>

        </Content>

        <jsp:include page="footer.jsp"/>
    </Layout>
</div>

<%--获取本机ip，存储在returnCitySN对象中--%>
<script src="http://pv.sohu.com/cityjson?ie=utf-8"></script>
<script type="text/javascript">
    //# sourceURL=index.js
    var app = new Vue({
        el: "#app",

        data: {

            avatarSrc:"/upload/image/defaultAvatar.jpg",
            username:"",
            haveLogin:false,
            isSeller:false,
            cartNum:cookie("cartGoodsNum")||0,

            keys:"",
            seckillList:[],

        }
    });



    function refresh() {

        ajaxGet("/onlineSale/secKill/getSecKillGoods"
            ,function (res)
            {
                if(res.code=="success")
                {
                    app.seckillList=res.data;
                    console.log(app.seckillList);
                    if(app.seckillList.length==null||app.seckillList.length==0)
                    {
                        app.hasSecKillGoods=false;
                    }
                }
            },null,false);
    }

    $(document).ready(function () {
        ajaxGet("/onlineSale/getLoginUserInfo",function (res) {
            if(res.code==="success")
            {
                app.username=res.data.userName;
                app.avatarSrc=res.data.userPic;
                app.haveLogin=true;
                if(res.data.userType==="ADMINISTRATOR")
                {
                    app.isSeller=true;
                }
            }
        },null,false);
        refresh();
    });

</script>
</body>
</html>
