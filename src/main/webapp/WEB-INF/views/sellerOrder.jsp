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
                                <i-button @click="edit()" type="success" icon="plus">上架商品</i-button>
                                <i-button @click="del()" type="error" icon="minus">下架商品</i-button>
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
                                    <th style="width: 50px;">
                                        <Checkbox @on-change="checkAll()"  v-model="viewModel.allChecked" style="margin-left: 8px;">
                                        </Checkbox>
                                    </th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr v-for="item in viewModel.list">
                                    <td>
                                        <Checkbox v-model="item.checked" style="margin-left: 8px;" :key="item.id"></Checkbox>
                                    </td>

                                </tr>
                                </tbody>
                            </table>

                            <Page :current="page.no" :total="page.total" :page-size="page.size"
                                  show-total show-sizer show-elevator style="text-align: right;" placement="top"
                                  :page-size-opts="[ 4, 8, 16]" @on-change="changePage($event)"
                                  @on-page-size-change="changePageSize($event)">
                            </Page>
                        </div>
                    </div>
                </i-col>
            </Row>

        </Content>

        <jsp:include page="footer.jsp"/>

        <Modal :title="editModal.title" width="600" :mask-closable="false"  v-model="editModal.show" :loading="editModal.loading" @on-ok="edit_ok('editFrame')">
            <iframe id="editFrame" width="100%"  frameborder="0" :src="editModal.url"></iframe>
        </Modal>

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
                size: parseInt(cookie("pageSize")) || 4,
            },

            // 编辑模态框
            editModal: {
                title: "",
                url: "",
                loading: true,
                show: false
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


    function refresh()
    {

    }


    //编辑
    function edit(id) {

        app.editModal= {
            title: "",
            url: "",
            loading: true,
            show: false
        };

        if (id == null) {
            app.editModal.title = "添加商品";
            app.editModal.url = "/onlineSale/myStore/goodsForm";
        } else {
            app.editModal.title = "编辑商品信息";
            app.editModal.url = "/onlineSale/myStore/goodsForm?id=" + id;
        }
        app.editModal.show = true;
    };

</script>
</body>
</html>
