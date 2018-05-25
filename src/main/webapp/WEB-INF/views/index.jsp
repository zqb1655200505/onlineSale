<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path;
    String goodsDetail="/onlineSale/consumer/goodsDetail?isSecKill=false&id=";
    String secKillGoodsDetail="/onlineSale/consumer/goodsDetail?isSecKill=true&id=";
    String secKillList="/onlineSale/secKill/secKillList";
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
            width: 45%;
            text-align: center;
            color: #fff;
            cursor: pointer;
            font-size: 20px;
        }
        .single-item{
            margin-left: 27%;
        }

        .goods-item-img
        {
            width: 100%;
        }

        .goods-item-description
        {
            font-size: 15px;
            padding: 10px;
            width: 100%;
            height: 100px;
            text-align: left;
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
            color: rgba(255, 255, 255, 0.5);
            font-size: 25px;
            margin-top: 30px;
            margin-bottom: 20px;
        }

        .sk_desc
        {
            margin-top: 20px;
            margin-bottom: 20px;
            font-size: 20px;
        }
        .sk_cd
        {
            width: 100%;
            margin: 0 auto;

        }
        .cd_item {
            text-align: center;
            background-color: #1c2438;
        }
        .cd_item_txt {
            position: relative;
            line-height: 50px;
            font-weight: bold;
            font-size: 20px;
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
            <Row v-if="hasSecKillGoods">
                <i-col offset="3" span="5">
                    <div style="height: 400px;background-color: #444965;">
                        <a class="sk_hd_lk" :href="'<%=secKillList%>'">
                            <div class="sk_tit">秒杀进行中ing</div>
                            <div class="sk_subtit">FLASH DEALS</div>
                            <Icon type="flash" style="font-size: 50px;"></Icon>
                            <div class="sk_desc">本场距离结束还剩</div>
                            <Row>
                                <i-col span="4" offset="5" class="cd_item">
                                    <span class="cd_item_txt">{{hour}}</span>
                                </i-col>
                                <i-col span="4" offset="1" class="cd_item">
                                    <span class="cd_item_txt">{{minute}}</span>
                                </i-col>

                                <i-col span="4" offset="1" class="cd_item">
                                    <span class="cd_item_txt">{{second}}</span>
                                </i-col>
                            </Row>
                        </a>
                    </div>
                </i-col>

                <i-col offset="1" span="12">
                    <Carousel autoplay autoplay-speed="50000" loop>
                        <Carousel-item v-for="(item,index) in seckillList" v-if="index<seckillList.length&&index%2==0">
                            <div style=" width: 100%;" >
                                <div  class="demo-carousel"  :class="getClass(index)">
                                    <img :src="'<%=basePath%>'+item.goods.goodsPic" style="width: 100%;height: 85%;" @click="gotoSeckill(item)">
                                    <div style="height: 60px;width: 100%;border: 1px solid grey;">
                                        <div style="width: 50%;height: 100%;float: left;background-color: red;line-height: 60px;">
                                            <span>￥{{item.seckillPrice}}</span>
                                        </div>
                                        <div style="width: 50%;height: 100%;float: right;text-decoration: line-through;color: grey;line-height: 60px;">
                                            ￥{{item.goods.goodsPrice}}
                                        </div>
                                    </div>

                                </div>

                                <div style="margin-left:55%;margin-top:-400px;" class="demo-carousel"  v-if="index<seckillList.length-1">
                                    <img :src="'<%=basePath%>'+seckillList[index+1].goods.goodsPic" @click="gotoSeckill(seckillList[index+1])" style="width: 100%;height: 85%;">
                                    <div style="height: 60px;width: 98%;border: 1px solid grey;">
                                        <div style="width: 50%;height: 100%;float: left;background-color: red;line-height: 60px;margin-top: -58px;">
                                            <span>￥{{seckillList[index+1].seckillPrice}}</span>
                                        </div>
                                        <div style="width: 50%;height: 100%;float: right;margin-top: -60px;text-decoration: line-through;color: grey;line-height: 60px;">
                                            ￥{{seckillList[index+1].goods.goodsPrice}}
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </Carousel-item>
                    </Carousel>
                </i-col>
            </Row>

            <Row :gutter="64">
                <i-col v-for="(item,index) in goodsList" v-if="index%4==0" span="5" offset="2" style="margin-top: 30px;">
                    <Card>
                        <a :href="'<%=goodsDetail%>'+item.id" target="_blank"><img :src="'<%=basePath%>'+item.goodsPic" class="goods-item-img"></a>
                        <div class="goods-item-description">
                            <p style="color: red;font-size: 22px;">￥{{item.goodsPrice}}</p>
                            <a :href="'<%=goodsDetail%>'+item.id" target="_blank">{{item.goodsName}}</a>
                        </div>
                    </Card>
                </i-col>
                <i-col v-else span="5" style="margin-top: 30px;">
                    <Card>
                        <a :href="'<%=goodsDetail%>'+item.id" target="_blank"><img :src="'<%=basePath%>'+item.goodsPic" class="goods-item-img"></a>
                        <div class="goods-item-description">
                            <p style="color: red;font-size: 22px;">￥{{item.goodsPrice}}</p>
                            <a :href="'<%=goodsDetail%>'+item.id" target="_blank">{{item.goodsName}}</a>
                        </div>
                    </Card>
                </i-col>
            </Row>

            <Row style="margin-top: 30px;">
                <i-col offset="4" span="16">
                    <Page :current="page.no" :total="page.total" :page-size="page.size"
                          show-total show-sizer show-elevator style="text-align: right;" placement="top"
                          :page-size-opts="[8, 16, 32, 64]" @on-change="changePage($event)"
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
            cartNum:cookie("cartGoodsNum")||0,

            keys:"",
            seckillList:[],
            goodsList:[],
            // 分页对象
            page : {
                no: 1,
                total: 30,
                size: parseInt(cookie("pageSize")) || 8,
            },

            hour:"00",
            minute:"00",
            second:"00",

            hasSecKillGoods:false,
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

        ajaxGet("/onlineSale/secKill/getSecKillTime",function (res) {
            console.log(res);
            if(res.code==="success")
            {
                var date = new Date();
                date.setTime(res.data);
                var date1=new Date();    //当前时间
                var date3=date.getTime()-date1.getTime();  //时间差的毫秒数
                timer(parseInt(date3/1000));
            }
        },null,false);


        ajaxGet("/onlineSale/consumer/getGoods?pageNo="+app.page.no+"&pageSize="+app.page.size+"&keys=" +encodeURIComponent(app.keys)
            ,function (res) {
                app.goodsList=res.data.list;
                app.page.total = res.data.total;
            },null,false);


        ajaxGet("/onlineSale/secKill/getSecKillGoods"
            ,function (res)
            {
                if(res.code=="success")
                {
                    app.hasSecKillGoods=true;
                    app.seckillList=res.data;
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

    function gotoSeckill(item)
    {
        window.open("<%=secKillGoodsDetail%>"+item.id);
        //window.location.href="<%=secKillGoodsDetail%>"+item.id;
    }

    function getClass(index) {
        if(index==app.seckillList.length-1)
            return "single-item";
        return "";
    }


    function timer(intDiff)
    {
        window.setInterval(function() {
            var day = 0,
                hour = 0,
                minute = 0,
                second = 0; //时间默认值
            if (intDiff > 0)
            {
                hour = Math.floor(intDiff / (60 * 60)) ;
                minute = Math.floor(intDiff / 60) -  (hour * 60);
                second = Math.floor(intDiff) -  (hour * 60 * 60) - (minute * 60);
            }
            if(hour<=9)
                hour = '0' + hour;
            if (minute <= 9)
                minute = '0' + minute;
            if (second <= 9)
                second = '0' + second;

            app.hour=hour;
            app.minute=minute;
            app.second=second;

            intDiff--;
        }, 1000);
    }
</script>
</body>
</html>
