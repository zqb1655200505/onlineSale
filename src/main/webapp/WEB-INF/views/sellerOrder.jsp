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
    <link href="<%=basePath%>/static/bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css">
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
        th,td{
            text-align: center;
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
                    <i-menu theme="dark" active-name="2" style="width: 90%;">
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

                        </Menu-Group>
                    </i-menu>
                </i-col>

                <i-col offset="1" span="16" style="min-height: 700px;">
                    <div class="panel panel-default">
                        <div class="panel-heading" style="text-align: left;font-size: 14px;font-weight: bold;">秒杀商品列表</div>

                        <div class="wrapper-sm" style="padding: 10px 15px;">
                            <div style="margin-bottom:10px;margin-top: 5px;float: left;">
                                <i-button @click="del()" type="error" icon="minus">删除订单</i-button>
                            </div>
                            <div style="float: right; margin-bottom: 10px;margin-top: 5px;">
                                <i-input placeholder="请输入查询条件" v-model="viewModel.keys" style="width: 250px"
                                         @on-enter="refresh()">
                                    <i-button slot="append" icon="search" @click="refresh()"></i-button>
                                </i-input>
                            </div>


                            <table class="table table-hover table-bordered table-condensed" style="margin-top: 10px;" >
                                <!--<table id="contentTable" class="table table-striped table-bordered table-condensed">-->
                                <thead>
                                <tr style="font-size: 15px;">
                                    <th>
                                        <Checkbox @on-change="checkAll()"  v-model="viewModel.allChecked" style="margin-left: 8px;">
                                        </Checkbox>
                                    </th>
                                    <th style="width:25%;line-height: 40px;">商品名称</th>
                                    <th style="width:10%;line-height: 40px;">商品数目</th>
                                    <th style="width:15%;line-height: 40px;">购买者</th>
                                    <th style="width:25%;line-height: 40px;">购买时间</th>
                                    <th style="width:15%;line-height: 40px;">是否秒杀</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr v-for="item in viewModel.list" style="cursor: pointer;">
                                    <td style="width:10%;padding-top: 13px;">
                                        <Checkbox v-model="item.checked" style="margin-left: 8px;" :key="item.id"></Checkbox>
                                    </td>

                                    <td style="width:25%;line-height: 40px;">{{item.goods.goodsName}}</td>
                                    <td style="width:10%;line-height: 40px;">{{item.goodsNum}}</td>
                                    <td style="width:15%;line-height: 40px;">{{item.order.buyer.userName}}</td>
                                    <td style="width:25%;line-height: 40px;">{{datetimeFormatFromLong(item.order.orderTime)}}</td>
                                    <td style="width:15%;line-height: 40px;">
                                        {{item.seckill== true?'是':'否'}}
                                    </td>
                                </tr>
                                </tbody>
                            </table>

                            <Page :current="page.no" :total="page.total" :page-size="page.size"
                                  show-total show-sizer show-elevator style="text-align: right;" placement="top"
                                  :page-size-opts="[10, 25, 50]" @on-change="changePage($event)"
                                  @on-page-size-change="changePageSize($event)">
                            </Page>
                        </div>
                    </div>
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
            cartNum:cookie("cartGoodsNum")||0,

            //视图对象
            viewModel:{
                keys:"",
                allChecked:false,
                list:[],
            },

            page : {
                no: 1,
                total: 20,
                size: parseInt(cookie("pageSize")) || 10,
            },


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
        refresh();
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

    //全选事件
    function checkAll() {
        app.viewModel.list.forEach(function (item) {
            item.checked = app.viewModel.allChecked;
        });
    };


    function del(id) {
        var list = [];

        if (id == null) {
            app.viewModel.list.forEach(function (item) {
                if (item.checked) list.push(item.id);
            });

            if (list.length == 0) {
                app.$Message.error('请选择欲删除记录');
                return;
            }
        } else {
            list.push(id);
        }

        app.$Modal.confirm({
            title: '提示信息',
            content: '确定要删除记录？',
            loading: true,
            onOk: function () {
                ajaxPostJSON("", list, function () {
                    app.viewModel.allChecked = false;
                    refresh();
                    app.$Modal.remove();
                });
            }
        });
    }


    function refresh()
    {
        ajaxGet("/onlineSale/myOrder/getSellerOrder?pageNo="+app.page.no+"&pageSize="+app.page.size+"&keys=" +encodeURIComponent(app.viewModel.keys),
            function (res) {
                app.viewModel.list=res.data.list;
                app.page.total = res.data.total;
        },null,false);
    }


</script>
</body>
</html>
