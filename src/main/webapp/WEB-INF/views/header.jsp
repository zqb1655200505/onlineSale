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
    <title>**在线销售系统</title>
    <link href="<%=basePath%>/static/iview/styles/iview.css" rel="stylesheet" type="text/css"/>
    <link href="<%=basePath%>/static/css/header.css" rel="stylesheet" type="text/css"/>
</head>
<body >
<Header v-cloak id="header">
    <i-menu mode="horizontal" theme="dark">
        <div class="layout-logo"></div>
        <div class="layout-nav">
            <template v-if="haveLogin">
                <MenuItem name="login" >
                    <a href="#">
                        <Icon type="ios-navigate"></Icon>
                        登录
                    </a>
                </MenuItem>
                <MenuItem name="register">
                    <a href="#1">
                        <Icon type="ios-keypad"></Icon>
                        注册
                    </a>
                </MenuItem>
            </template>


            <MenuItem name="username" v-else>
                <a>
                    <template>
                        <Avatar id="userPic" :src="'<%=basePath%>'+avatarSrc"/>
                    </template>
                    <span>{{username}}</span>
                </a>

            </MenuItem>

            <MenuItem name="MyCart">
                <a>
                    <Icon type="ios-analytics"></Icon>
                    购物车
                </a>

            </MenuItem>
            <MenuItem name="MyOrder">
                <a>
                    <Icon type="ios-paper"></Icon>
                    我的订单
                </a>

            </MenuItem>
        </div>
    </i-menu>
</Header>
</body>
</html>
