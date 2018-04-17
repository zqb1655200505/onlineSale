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
    <style type="text/css">
        .demo-carousel
        {
            height: 400px;
            text-align: center;
            color: #fff;
            font-size: 20px;
        }

        .goods-item-img
        {
            width: 100%;
            height: auto;
        }

        .goods-item-description
        {
            background-color: #2baee9;
            font-size: 17px;
            padding: 10px;
            width: 100%;
            height: 100px;
        }

        .sk_hd_lk{
            display: block;
            width: 100%;
            height: 100%;
        }
        .sk_tit
        {
            width: 100%;
            text-align: center;
            font-size: 30px;
            padding-top: 50px;
        }

        .sk_subtit{
            width: 100%;
            text-align: center;
            color: #f19999;
            color: rgba(255, 255, 255, 0.5);
            font-size: 25px;
            margin-top: 30px;
            margin-bottom: 20px;
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
                <i-col offset="3" span="5">
                    <div style="height: 400px;background-color: #444965;">
                        <a class="sk_hd_lk" >
                            <div class="sk_tit">秒杀进行中ing</div>
                            <div class="sk_subtit">FLASH DEALS</div>
                            <Icon type="flash" style="font-size: 50px;"></Icon>
                        </a>
                    </div>
                </i-col>

                <i-col offset="1" span="12">
                    <Carousel autoplay autoplay-speed="3000" loop>
                        <Carousel-item v-for="(item,index) in seckillList">
                            <div class="demo-carousel" @click="gotoSeckill(index)">
                                <img :src="'<%=basePath%>'+item.image" style="width: 100%;height: 100%;">
                            </div>
                        </Carousel-item>

                    </Carousel>
                </i-col>
            </Row>

            <Row :gutter="64">
                <i-col v-for="(item,index) in goodsList" v-if="index%4==0" span="5" offset="2" style="margin-top: 30px;">
                    <Card>
                        <a :href="item.link"><img :src="'<%=basePath%>'+item.image" class="goods-item-img"></a>
                        <div class="goods-item-description">
                            <span>{{item.description}}{{index}}</span>
                        </div>
                    </Card>
                </i-col>
                <i-col v-else span="5" style="margin-top: 30px;">
                    <Card>
                        <a :href="item.link"><img :src="'<%=basePath%>'+item.image" class="goods-item-img"></a>
                        <div class="goods-item-description">
                            <span>{{item.description}}{{index}}</span>
                        </div>
                    </Card>
                </i-col>
            </Row>

            <Row style="margin-top: 30px;">
                <i-col offset="4" span="16">
                    <Page :current="page.no" :total="page.total" :page-size="page.size"
                          show-total show-sizer show-elevator style="text-align: right;" placement="top"
                          :page-size-opts="[10, 25, 50, 100]" @on-change="changePage($event)"
                          @on-page-size-change="changePageSize($event)">
                    </Page>
                </i-col>

            </Row>
        </Content>

        <jsp:include page="footer.jsp"/>
    </Layout>
</div>

<script type="text/javascript">
    //# sourceURL=index.js
    var app = new Vue({
        el: "#app",

        data: {

            avatarSrc:"/upload/image/defaultAvatar.jpg",
            username:"",
            haveLogin:false,
            isSeller:false,

            seckillList:[],
            goodsList:[],
            // 分页对象
            page : {
                no: 1,
                total: 100,
                size: parseInt(cookie("pageSize")) || 10,
            },
        }
    });

    //改变每页数量
    function changePageSize(pageSize) {
        cookie("pageSize", pageSize);
        app.page.size=pageSize;
        refresh();
    };


    //切换页面
    function changePage(pageNo) {
        if(pageNo != null)
            app.page.no = pageNo;
        refresh();
    };

    function refresh() {
        app.goodsList.splice(0,app.goodsList.length);
        for(var i=0;i<app.page.size;i++)
        {
            var item={
                description:"aas搭嘎第三方八十多分",
                image:"/upload/image/test.jpg",
                link:"#"+i,
            };
            app.goodsList.push(item);
        }
        app.seckillList.splice(0,app.seckillList.length);

        for(var i=0;i<app.page.size;i++)
        {
            var item={
                description:"aas搭嘎第三方八十多分",
                link:"#"+1,
                image:"/upload/image/test.jpg"
            };
            app.seckillList.push(item);
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
    });

    function gotoSeckill(id) {
        alert(id);
    }
</script>
</body>
</html>
