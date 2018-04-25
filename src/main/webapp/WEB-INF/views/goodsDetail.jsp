<%--
  Created by IntelliJ IDEA.
  User: zqb
  Date: 2018/4/23
  Time: 17:00
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
    <title>优铺在线销售系统-商品详情</title>
    <link href="<%=basePath%>/static/iview/styles/iview.css" rel="stylesheet" type="text/css"/>
    <link href="<%=basePath%>/static/css/header.css" rel="stylesheet" type="text/css"/>
    <style rel="stylesheet">
        .ivu-input-number-input,ivu-input-number-handler-wrap
        {
            height: 45px;
        }
        .ivu-input-number-handler
        {
            height: 22px;
        }
        .ivu-input-number-handler-down-inner, .ivu-input-number-handler-up-inner
        {
            line-height: 22px;
            font-size: 16px;
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

        <Content class="layout-content-center">
            <Row>
                <i-col span="16" offset="4" style="min-height: 650px;">
                    <Row>
                        <i-col span="8">
                            <img src="<%=basePath%>${goods.goodsPic}" style="width: 100%;cursor:pointer;"/>
                        </i-col>
                        <i-col span="15" offset="1" style="text-align: left;">
                            <Row style="padding: 5px 15px;margin-top: 12px;">
                                <h1>${goods.goodsName}</h1>
                            </Row>
                            <Row style="background-color: #eeeeee;padding: 10px 15px;">
                                <h2 style="color: red;">￥${goods.goodsPrice}</h2>
                                <p style="font-size: 16px;">${goods.goodsDescription}</p>
                                <p style="font-size: 16px;">商品余量 ：${goods.goodsNum}</p>
                            </Row>

                            <hr style="margin-top: 20px;border-bottom: dotted; border-bottom-color: #b2b2b2;border-bottom-width: thin;"/>
                            <Row style="text-align: center;font-size: 16px;line-height: 22px;margin-top: 10px;">
                                <i-col span="7">
                                    <label>月销量 </label><span style="color: red;font-weight: bolder;"> 123</span>
                                </i-col>

                                <i-col span="1" style="color: #b2b2b2">|</i-col>

                                <i-col span="7">
                                    <label>累计销量 </label><span style="color: red;font-weight: bolder;"> 1234</span>
                                </i-col>

                                <i-col span="1" style="color: #b2b2b2;">|</i-col>

                                <i-col span="7">
                                    <label>累计评价 </label><span style="color: red;font-weight: bolder;"> 125</span>
                                </i-col>
                            </Row>
                            <hr style="margin-top: 10px;border-bottom: dotted; border-bottom-color: #b2b2b2;border-bottom-width: thin;"/>

                            <Row style="margin-top: 20px;">
                                <i-col span="5">
                                    <Input-Number :max="${goods.goodsNum}" :min="1" v-model="purchaseNum" style="height: 45px;"></Input-Number>
                                </i-col>

                                <i-col span="5" offset="1">
                                    <i-button type="error" style="height: 45px;width: 100%;" @click="addToCart">加入购物车</i-button>
                                </i-col>
                            </Row>
                        </i-col>
                    </Row>
                </i-col>
            </Row>
        </Content>

        <Footer class="layout-footer-center">
            <hr style="margin-bottom: 10px;"/>
            2014-2018 &copy; software engineering
        </Footer>
        <script type="text/javascript" src="<%=basePath%>/static/js/jquery-2.0.0.min.js"></script>
        <script type="text/javascript" src="<%=basePath%>/static/iview/vue.min.js"></script>
        <script type="text/javascript" src="<%=basePath%>/static/iview/iview.min.js"></script>
        <script type="text/javascript" src="<%=basePath%>/static/js/common.js"></script>
    </Layout>
</div>
<script type="text/javascript">
    //# sourceURL=goodsDetail.js
    var app = new Vue({
        el: "#app",

        data: {
            avatarSrc:"/upload/image/defaultAvatar.jpg",
            username:"",
            haveLogin:false,
            isSeller:false,
            cartNum:cookie("cartGoodsNum")||0,
            purchaseNum:1,
        }
    });


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
    });


    function addToCart()
    {
        var option={
            path:"/onlineSale",
            expires:7,
        };
        var count=cookie("cartGoodsNum")||0;
        cookie("cartGoodsNum",Number(count)+app.purchaseNum,option);
        app.cartNum=Number(count)+app.purchaseNum;

        var itemNumList=cookie("itemNumList")||"";
        var cartGoodsIdList=cookie("cartGoodsIdList")||"";

        if(cartGoodsIdList=="")
        {
            cartGoodsIdList="${goods.id}";
            itemNumList=app.purchaseNum+"";
        }
        else
        {
            var index=-1;
            var idList=cartGoodsIdList.split(";");
            for(var i=0;i<idList.length;i++)
            {
                if(idList[i]=="${goods.id}")
                {
                    index=i;
                    break;
                }
            }
            if(index==-1)
            {
                cartGoodsIdList=cartGoodsIdList+";"+"${goods.id}";
                itemNumList=itemNumList+";"+app.purchaseNum;
            }
            else
            {
                var itemNum=itemNumList.split(";");
                itemNum[index]=Number(itemNum[index])+app.purchaseNum;
                itemNumList="";
                for(var i=0;i<itemNum.length-1;i++)
                {
                    itemNumList=itemNumList+itemNum[i]+";";
                }
                itemNumList=itemNumList+itemNum[itemNum.length-1];
            }
        }
        cookie("cartGoodsIdList",cartGoodsIdList,option);
        cookie("itemNumList",itemNumList,option);

    }

</script>
</body>
</html>
