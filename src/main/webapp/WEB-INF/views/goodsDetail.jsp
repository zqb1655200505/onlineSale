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
    <link href="<%=basePath%>/static/bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="<%=basePath%>/static/css/header.css" rel="stylesheet" type="text/css"/>
    <link href="<%=basePath%>/static/zoom/base.css" rel="stylesheet" type="text/css"/>\

    <style>
        .jqZoomPup
        {
            width: 150px;
            height: 150px;
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
                        <a href="/onlineSale/myCart/">
                            <Icon type="ios-cart"></Icon>
                            购物车
                        </a>

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
                <i-col span="16" offset="4" style="min-height: 700px;background-color: #b2b2b2">
                    <Row>
                        <i-col span="8">
                            <div class="right-extra">
                                <div id="preview" class="spec-preview" style="width: 100%;">
                                    <span class="jqzoom">
                                        <img jqimg="<%=basePath%>${goods.goodsPic}" src="<%=basePath%>${goods.goodsPic}" style="width: 100%;"/>
                                    </span>
                                </div>
                            </div>

                        </i-col>
                        <i-col span="15" offset="1">

                        </i-col>
                    </Row>
                </i-col>
            </Row>
        </Content>

        <jsp:include page="footer.jsp"/>
    </Layout>
</div>
<script type="text/javascript" src="<%=basePath%>/static/zoom/jquery.jqzoom.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/zoom/base.js"></script>
<script type="text/javascript">
    //# sourceURL=goodsDetail.js
    var app = new Vue({
        el: "#app",

        data: {
            avatarSrc:"/upload/image/defaultAvatar.jpg",
            username:"",
            haveLogin:false,
            isSeller:false,
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

        console.log("${goods}");
    });



</script>
</body>
</html>
