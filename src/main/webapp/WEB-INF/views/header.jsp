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
                <Menu-Item name="login" >
                    <a href="#">
                        <Icon type="ios-navigate"></Icon>
                        登录
                    </a>
                </Menu-Item>
                <Menu-Item name="register">
                    <a href="#1">
                        <Icon type="ios-keypad"></Icon>
                        注册
                    </a>
                </Menu-Item>
            </template>

            <Submenu name="username" v-else>
                <a slot="title">
                    <template>
                        <Avatar id="userPic" :src="'<%=basePath%>'+avatarSrc"/>
                    </template>
                    <span>{{username}}</span>
                </a>
                <Menu-Group title="使用">
                    <Menu-Item name="3-1">新增和启动</Menu-Item>
                    <Menu-Item name="3-2">活跃分析</Menu-Item>
                    <Menu-Item name="3-3">时段分析</Menu-Item>
                </Menu-Group>
            </Submenu>

            <Menu-Item name="MyCart">
                <a>
                    <Icon type="ios-analytics"></Icon>
                    购物车
                </a>

            </Menu-Item>
            <Menu-Item name="MyOrder">
                <a>
                    <Icon type="ios-paper"></Icon>
                    我的订单
                </a>

            </Menu-Item>
        </div>
    </i-menu>


</Header>
</body>
</html>
