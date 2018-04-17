<%--
  Created by IntelliJ IDEA.
  User: zqb
  Date: 2018/4/16
  Time: 16:01
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
    <title>优铺在线销售系统-商家订单</title>
    <link href="<%=basePath%>/static/iview/styles/iview.css" rel="stylesheet" type="text/css"/>
    <link href="<%=basePath%>/static/css/header.css" rel="stylesheet" type="text/css"/>

    <style>
        .layout-content-center .ivu-menu-item
        {
            line-height: 60px;
        }
        .ivu-menu-vertical .ivu-menu-item-group-title
        {
            text-align: left;
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
                    <Menu-Item name="username">
                        <a>
                            <template>
                                <Avatar id="userPic" :src="'<%=basePath%>'+avatarSrc"/>
                            </template>
                            <span> {{username}}</span>
                        </a>
                    </Menu-Item>

                    <Menu-Item name="logout">
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
                <i-col span="3" offset="2">
                    <i-menu theme="dark" active-name="2" style="width: 200px;">
                        <Menu-Group title="我的店铺">
                            <a href="/onlineSale/myStore/index">
                                <Menu-Item name="1">
                                    <Icon type="document-text"></Icon>
                                    商品管理
                                </Menu-Item>
                            </a>
                            <a href="/onlineSale/myStore/myOrder">
                                <Menu-Item name="2">
                                    <Icon type="chatbubbles"></Icon>
                                    订单管理
                                </Menu-Item>
                            </a>
                            <a href="/onlineSale/myStore/mySecKillGoods">
                                <Menu-Item name="3">
                                    <Icon type="heart"></Icon>
                                    秒杀管理
                                </Menu-Item>
                            </a>
                            <a href="#4">
                                <Menu-Item name="4">
                                    <Icon type="heart-broken"></Icon>
                                    流失用户
                                </Menu-Item>
                            </a>
                        </Menu-Group>
                    </i-menu>
                </i-col>

                <i-col offset="1" span="16" style="height: 100px;background-color: #2baee9;">

                </i-col>
            </Row>

        </Content>

        <jsp:include page="footer.jsp"/>
    </Layout>
</div>

<script type="text/javascript">
    //# sourceURL=sellerOrder.js
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
    });
</script>
</body>
</html>
