<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path;
%>
<html>
<head>
    <link href="<%=basePath%>/static/iview/styles/iview.css" rel="stylesheet" type="text/css"/>
    <style scoped>
        .layout{
            border: 1px solid #d7dde4;
            background: #f5f7f9;
            position: relative;
            border-radius: 4px;
            overflow: hidden;
        }
        .layout-logo{
            width: 100px;
            height: 30px;
            background: #5b6270;
            border-radius: 3px;
            float: left;
            position: relative;
            top: 15px;
            left: 20px;
        }
        .layout-nav{
            width: 420px;
            margin: 0 auto;
            margin-right: 20px;
            color: white;
            font-size: 18px;
        }

        .layout-content-center{
            width: 800px;
            height: 600px;
            padding: 0 30px;
            margin:0 auto;
            text-align: center;
        }
        .layout-footer-center{
            text-align: center;
            font-size: 15px;
        }
        MenuItem
        {
            margin-left: 20px;
        }

        .demo-carousel
        {
            height: 400px;
            line-height: 400px;
            text-align: center;
            color: #fff;
            font-size: 20px;
            background: #506b9e;
        }

        .goods-item-img
        {
            width: 100%;
            height: auto;
        }

    </style>

</head>
<body>
<div class="layout" v-cloak id="app">
    <Layout>
        <Header>
            <i-menu mode="horizontal" theme="dark" active-name="1">
                <div class="layout-logo"></div>
                <div class="layout-nav">
                    <MenuItem name="login">
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
        <Content class="layout-content-center">
            <Row>
                <i-col offset="2" span="20">
                    <Carousel v-model="value2" autoplay  loop>
                        <Carousel-item>
                            <div class="demo-carousel">1</div>
                        </Carousel-item>
                        <Carousel-item>
                            <div class="demo-carousel">2</div>
                        </Carousel-item>
                        <Carousel-item>
                            <div class="demo-carousel">3</div>
                        </Carousel-item>
                        <Carousel-item>
                            <div class="demo-carousel">4</div>
                        </Carousel-item>
                    </Carousel>
                </i-col>
            </Row>

            <Row :gutter="64">
                <i-col span="5" offset="2">
                    <Card>
                        <img src="#" class="goods-item-img">
                        <div class="goods-item-description">

                        </div>
                    </Card>
                </i-col>
                <i-col  span="5">
                    <Card>
                        <img src="#" class="goods-item-img">
                        <div class="goods-item-description">

                        </div>
                    </Card>
                </i-col>
                <i-col  span="5">
                    <Card>
                        <img src="#" class="goods-item-img">
                        <div class="goods-item-description">

                        </div>
                    </Card>
                </i-col>
                <i-col  span="5">
                    <Card>
                        <img src="#" class="goods-item-img">
                        <div class="goods-item-description">

                        </div>
                    </Card>
                </i-col>

                <i-col span="5" offset="2">
                    <Card>
                        <img src="#" class="goods-item-img">
                        <div class="goods-item-description">

                        </div>
                    </Card>
                </i-col>
                <i-col  span="5">
                    <Card>
                        <img src="#" class="goods-item-img">
                        <div class="goods-item-description">

                        </div>
                    </Card>
                </i-col>
                <i-col  span="5">
                    <Card>
                        <img src="#" class="goods-item-img">
                        <div class="goods-item-description">

                        </div>
                    </Card>
                </i-col>
                <i-col  span="5">
                    <Card>
                        <img src="#" class="goods-item-img">
                        <div class="goods-item-description">

                        </div>
                    </Card>
                </i-col>
            </Row>


        </Content>
        <Footer class="layout-footer-center">2011-2016 &copy; TalkingData</Footer>
    </Layout>


</div>
<script src="<%=basePath%>/static/common/js/jquery-2.0.0.min.js"></script>
<script src="<%=basePath%>/static/common/js/common.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/vue/vue.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/iview/iview.min.js"></script>
<script type="text/javascript">
    var app = new Vue({
        el: "#app",

        data: {
            value2:0,
        },
        method:{

        }
    });
</script>
</body>
</html>
