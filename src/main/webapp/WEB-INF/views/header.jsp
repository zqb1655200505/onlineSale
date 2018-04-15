<%--
  Created by IntelliJ IDEA.
  User: zqb
  Date: 2018/4/12
  Time: 20:37
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
    <title>优铺在线销售系统</title>
    <link href="<%=basePath%>/static/iview/styles/iview.css" rel="stylesheet" type="text/css"/>
    <link href="<%=basePath%>/static/css/header.css" rel="stylesheet" type="text/css"/>
</head>
<body >
<Header v-cloak id="header">

    <i-menu mode="horizontal" theme="dark">
        <div class="layout-logo"></div>
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
                <a href="/onlineSale/myCart">
                    <Icon type="ios-cart"></Icon>
                    购物车
                </a>

            </Menu-Item>
            <Menu-Item name="MyOrder">
                <a href="/onlineSale/myOrder">
                    <Icon type="ios-list"></Icon>
                    我的订单
                </a>
            </Menu-Item>

            <Menu-Item name="MyOrder" v-if="haveLogin">
                <a href="/onlineSale/myShopStore">
                    <Icon type="ios-list"></Icon>
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
</body>
</html>
