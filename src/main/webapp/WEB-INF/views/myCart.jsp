<%--
  Created by IntelliJ IDEA.
  User: zqb
  Date: 2018/4/16
  Time: 15:56
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
    <title>优铺在线销售系统-购物车</title>
    <link href="<%=basePath%>/static/iview/styles/iview.css" rel="stylesheet" type="text/css"/>
    <link href="<%=basePath%>/static/css/header.css" rel="stylesheet" type="text/css"/>
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

                    <%--<Menu-Item name="MyCart">--%>
                        <%--<Badge :count="cartNum">--%>
                            <%--<a href="/onlineSale/myCart/">--%>
                                <%--<Icon type="ios-cart"></Icon>--%>
                                <%--购物车--%>
                            <%--</a>--%>
                        <%--</Badge>--%>
                    <%--</Menu-Item>--%>

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
                <i-col span="16" offset="4">
                    <Row>
                        <div style="margin-bottom:10px;margin-top: 5px;float: left;">
                            <i-button @click="remove()" type="error" icon="minus">从购物车移除</i-button>
                        </div>
                        <div style="float: right; margin-bottom: 10px;margin-top: 5px;">
                            <i-input placeholder="请输入查询条件" v-model="viewModel.keys" style="width: 250px"
                                     @on-enter="refresh()">
                                <i-button slot="append" icon="search" @click="refresh()"></i-button>
                            </i-input>
                        </div>
                    </Row>

                    <Row style="font-size: 15px;margin-top: 20px;background-color: #eeeeee;line-height: 45px;">
                        <i-col span="1" style="padding-top: 15px;">
                            <Checkbox @on-change="checkAll()"  v-model="viewModel.allChecked" style="margin-left: 8px;">
                            </Checkbox>
                        </i-col>
                        <i-col span="11">
                            商品
                        </i-col>

                        <i-col span="3">
                            单价
                        </i-col>

                        <i-col span="3">
                            数量
                        </i-col>

                        <i-col span="3">
                            小计
                        </i-col>

                        <i-col span="3">
                            操作
                        </i-col>
                    </Row>

                    <Row v-for="item in viewModel.list" style="font-size: 15px;margin-top: 10px;background-color: #eeeeee;line-height: 45px;">
                        <i-col span="1" style="padding-top: 15px;">
                            <Checkbox v-model="item.checked" style="margin-left: 8px;" :key="item.id"></Checkbox>
                        </i-col>
                        <i-col span="11">
                            <i-col span="4">
                                <img style="height: 100px;" src="#"/>
                            </i-col>
                            <i-col span="20">

                            </i-col>
                        </i-col>

                        <i-col span="3">
                            单价
                        </i-col>

                        <i-col span="3">
                            数量
                        </i-col>

                        <i-col span="3">
                            小计
                        </i-col>

                        <i-col span="3">
                            操作
                        </i-col>
                    </Row>
                </i-col>
            </Row>

        </Content>

        <jsp:include page="footer.jsp"/>
    </Layout>
</div>

<script type="text/javascript">
    //# sourceURL=myCart.js
    var app = new Vue({
        el: "#app",

        data: {
            avatarSrc:"/upload/image/defaultAvatar.jpg",
            username:"",
            haveLogin:false,
            isSeller:false,
            cartNum:cookie("cartGoodsNum")||0,

            //视图对象
            viewModel:{
                keys:"",
                allChecked:false,
                list:[],
            },
        }
    });


    //全选事件
    function checkAll() {
        app.viewModel.list.forEach(function (item) {
            item.checked = app.viewModel.allChecked;
        });
    };


    function remove() {
        var list = [];
        app.viewModel.list.forEach(function (item) {
            if (item.checked) list.push(item.id);
        });

        if (list.length == 0) {
            app.$Message.error('请选择下架商品');
            return;
        }

        app.$Modal.confirm({
            title: '提示信息',
            content: '确定要下架所选商品吗？',
            loading: true,
            onOk: function () {

            }
        });
    }

    function refresh()
    {
        var cartGoodsIdList=cookie("cartGoodsIdList")||"";
        if(cartGoodsIdList!="")
        {
            console.log(cartGoodsIdList);
            ajaxGet("/onlineSale/myCart/getCartGoods?idList="+cartGoodsIdList,function (res) {
                app.viewModel.list=res.data;
                console.log(app.viewModel.list);
            },null,false);
        }
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
//        var option={
//            path:"/onlineSale",
//            expires:7,
//
//        };
//        cookie("cartGoodsNum",0,option);
    });
</script>
</body>
</html>
