<%--
  Created by IntelliJ IDEA.
  User: zqb
  Date: 2018/4/16
  Time: 16:00
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
    <title>优铺在线销售系统-订单</title>
    <link href="<%=basePath%>/static/bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="<%=basePath%>/static/iview/styles/iview.css" rel="stylesheet" type="text/css"/>
    <link href="<%=basePath%>/static/css/header.css" rel="stylesheet" type="text/css"/>
    <style>
        h4{
            font-weight: bolder;
        }
        p{
            font-size: 15px;
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
                <i-col span="16" offset="4" style="min-height: 650px;">

                    <div class="panel panel-default" style="padding: 15px;">
                        <div class="panel-heading" style="text-align: left;font-size: 14px;font-weight: bold;">订单列表</div>
                        <Row >
                            <div style="margin-bottom:10px;float: left;margin-top: 10px;">
                                <i-button @click="remove()" type="warning" icon="minus">删除记录</i-button>
                            </div>
                            <div style="float: right; margin-bottom: 10px;margin-top: 10px;">
                                <i-input placeholder="请输入查询条件" v-model="viewModel.keys" style="width: 250px"
                                         @on-enter="refresh()">
                                    <i-button slot="append" icon="search" @click="refresh()"></i-button>
                                </i-input>
                            </div>
                        </Row>

                        <Row style="margin-top: -15px;">
                            <table class="table table-hover table-bordered table-condensed" >
                                <%--<thead>--%>
                                    <%--<tr style="font-size: 15px;">--%>
                                        <%--<th style="width: 50px;">--%>
                                            <%--<Checkbox @on-change="checkAll()"  v-model="viewModel.allChecked" style="margin-left: 8px;">--%>
                                            <%--</Checkbox>--%>
                                        <%--</th>--%>
                                        <%--<th>商品数目</th>--%>
                                        <%--<th>商品总价</th>--%>
                                        <%--<th>购买时间</th>--%>
                                        <%--<th>操作</th>--%>
                                    <%--</tr>--%>
                                <%--</thead>--%>

                                <Row style="font-size: 15px;margin-top: 20px;background-color: #eeeeee;line-height: 45px;">
                                    <i-col span="2" style="padding-top: 15px;">
                                        <Checkbox @on-change="checkAll()"  v-model="viewModel.allChecked" style="margin-left: 8px;">
                                        </Checkbox>
                                    </i-col>
                                    <i-col span="4">
                                        商品数目(个)
                                    </i-col>

                                    <i-col span="4">
                                        商品总价(元)
                                    </i-col>

                                    <i-col span="7">
                                        购买时间
                                    </i-col>

                                    <i-col span="7">
                                        操作
                                    </i-col>
                                </Row>
                                <tbody>
                                    <tr v-for="item in viewModel.list" style="height: 40px;">
                                        <td style="width:8%;padding-top: 13px;">
                                            <Checkbox v-model="item.checked" style="margin-left: 8px;" :key="item.id"></Checkbox>
                                        </td>
                                        <td style="width:17%;line-height: 40px;">{{item.goodsNum}}</td>
                                        <td style="width:17%;line-height: 40px;">{{item.orderPrice}}</td>
                                        <td style="width:29%;line-height: 40px;">{{datetimeFormatFromLong(item.orderTime)}}</td>
                                        <td style="width:29%;line-height: 40px;">
                                            <a @click="showDetail(item.id)">
                                                <Icon type="edit"></Icon> 订单详情
                                            </a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </Row>

                        <Page :current="page.no" :total="page.total" :page-size="page.size"
                              show-total show-sizer show-elevator style="text-align: right;" placement="top"
                              :page-size-opts="[10,25,50]" @on-change="changePage($event)"
                              @on-page-size-change="changePageSize($event)">
                        </Page>
                    </div>
                </i-col>
            </Row>
        </Content>

        <jsp:include page="footer.jsp"/>
    </Layout>
</div>

<script type="text/javascript">
    //# sourceURL=myOrder.js
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
                total: 10,
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
    }


    //切换页面
    function changePage(pageNo) {
        if(pageNo != null)
            app.page.no = pageNo;
        refresh();
    }



    //全选事件
    function checkAll() {
        app.viewModel.list.forEach(function (item) {
            item.checked = app.viewModel.allChecked;
        });
    };


    function remove() {
        var list = [];
        app.viewModel.list.forEach(function (item) {
            if (item.checked)
                list.push(item);
        });

        if (list.length == 0) {
            app.$Message.error('请选择需移除的购买记录！');
            return;
        }

        app.$Modal.confirm({
            content: "<div style='margin-top: -16px;'><h4>移除记录</h4></div><br><p>确定要将所选购买记录移除？</p>",
            loading: true,
            onOk: function () {

                ajaxPostJSON("",list,function (res) {

                },null,true);

                app.$Modal.remove();
            }
        });
    }
    
    function refresh() {
        ajaxGet("/onlineSale/myOrder/getConsumerOrder?pageNo="+app.page.no+"&pageSize="+app.page.size+"&keys=" +encodeURIComponent(app.viewModel.keys),
            function (res) {
                app.viewModel.list=res.data.list;
                app.page.total=res.data.total;
        },null,false);
    }

    function showDetail(id) {
        ajaxGet("/onlineSale/myOrder/getOrderDetail?orderId="+id,function (res) {
            console.log(res);
            var detail="<div style='margin-top: -12px;'><h4>订单详情</h4></div>";
            detail+='<table class="table table-hover table-bordered table-condensed" style="margin-top: 35px;margin-left: -23px;">';
            detail+='<thead><tr>';
            detail+='<th>商品名称 </th>';
            detail+='<th>商品数目(个) </th>';
            detail+='<th>是否为秒杀商品 </th>';
            detail+='<th>商家用户名 </th>';
            detail+='</tr></thead>';

            detail+='<tbody>';

            for(var i=0;i<res.data.length;i++)
            {
                detail+='<tr style="height: 32px;">';
                detail+='<td style="width:25%;line-height: 32px;">'+res.data[i].goods.goodsName+'</td>';
                detail+='<td style="width:25%;line-height: 32px;">'+res.data[i].goodsNum+'</td>';
                detail+='<td style="width:25%;line-height: 32px;">'+(res.data[i].seckill==true?"是":"否")+'</td>';
                detail+='<td style="width:25%;line-height: 32px;">'+res.data[i].goods.user.userName+'</td>';
                detail+='</tr>';
            }
            detail+='</tbody>';
            detail+='</table>';
            app.$Modal.info({
                content: detail,
                width:700,
                top:300,
                loading: true,
                onOk: function () {
                    app.$Modal.remove();
                }
            });
        },null,false);
    }
    function del(id) {
        app.$Modal.confirm({
            content: "<div style='margin-top: -16px;'><h4>移除记录</h4></div><br><p>确定要将该购买记录移除？</p>",
            loading: true,
            onOk: function () {
                app.$Modal.remove();
            }
        });
    }
</script>
</body>
</html>
