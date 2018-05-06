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
    <title>优铺在线销售系统-秒杀商品</title>
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
        #editFrame{
            height: 40%;
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
                    <i-menu theme="dark" active-name="3" style="width: 90%;">
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

                <i-col offset="1" span="16" style="min-height: 650px;">
                    <div class="panel panel-default">
                        <div class="panel-heading" style="text-align: left;font-size: 14px;font-weight: bold;">秒杀商品列表</div>

                        <div class="wrapper-sm" style="padding: 10px 15px;">
                            <div style="margin-bottom:10px;margin-top: 5px;float: left;">
                                <i-button @click="del()" type="error" icon="minus">批量删除秒杀商品</i-button>
                            </div>
                            <div style="float: right; margin-bottom: 10px;margin-top: 5px;">
                                <i-input placeholder="请输入查询条件" v-model="viewModel.keys" style="width: 250px"
                                         @on-enter="refresh()">
                                    <i-button slot="append" icon="search" @click="refresh()"></i-button>
                                </i-input>
                            </div>


                            <table class="table table-hover table-bordered table-condensed" style="margin-top: 10px;line-height: 35px;" >
                                <thead>
                                <tr style="font-size: 15px;">
                                    <th style="width: 50px;">
                                        <Checkbox @on-change="checkAll()"  v-model="viewModel.allChecked" style="margin-left: 8px;margin-top: -5px;">
                                        </Checkbox>
                                    </th>
                                    <th style="line-height: 40px;">商品名称</th>
                                    <th style="line-height: 40px;">秒杀数量</th>
                                    <th style="line-height: 40px;">秒杀价格(元)</th>
                                    <th style="line-height: 40px;">商品原价(元)</th>
                                    <th style="line-height: 40px;">开始秒杀时间</th>
                                    <th style="line-height: 40px;">秒杀状态</th>
                                    <th style="line-height: 40px;">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr v-for="item in viewModel.list">
                                    <td>
                                        <Checkbox v-model="item.checked" style="margin-left: 8px;margin-top: 10px;" :key="item.id"></Checkbox>
                                    </td>
                                    <td style="line-height: 40px;">{{item.goods.goodsName}}</td>
                                    <td style="line-height: 40px;">{{item.restNum}}</td>
                                    <td style="line-height: 40px;">{{item.seckillPrice}}</td>
                                    <td style="line-height: 40px;">{{item.goods.goodsPrice}}</td>
                                    <td style="line-height: 40px;">{{datetimeFormatFromLong(item.seckillBeginTime)}}</td>
                                    <td style="line-height: 40px;">
                                        <i-switch v-model="item.deleteFlag" @on-change="changeStatus(item.deleteFlag,item.id)" style="line-height: 40px;"></i-switch>
                                    </td>
                                    <td style="line-height: 40px;">
                                        <a @click="edit(item.id)">
                                            <Icon type="edit"></Icon> 编辑
                                        </a>
                                        &nbsp;
                                        <a @click="del(item.id)">
                                            <Icon type="android-delete"></Icon> 删除
                                        </a>
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


        <Modal :title="editModal.title" width="600" :mask-closable="false"  v-model="editModal.show" :loading="editModal.loading" @on-ok="edit_ok('editFrame')">
            <iframe id="editFrame" width="100%"  frameborder="0" :src="editModal.url"></iframe>
        </Modal>
    </Layout>
</div>

<script type="text/javascript">
    //# sourceURL=sellerSecKillGoods.js
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


    function refresh()
    {
        ajaxGet("/onlineSale/myStore/getMySecKillGoods?pageNo="+app.page.no+"&pageSize="+app.page.size+"&keys=" +encodeURIComponent(app.viewModel.keys)
            ,function (res) {
            console.log(res.data.list);
            app.viewModel.list = res.data.list;
            app.page.total = res.data.total;
        },null,false);
    }


    //编辑
    function edit(id) {

        app.editModal= {
            title: "",
            url: "",
            loading: true,
            show: false
        };
        app.editModal.title = "编辑秒杀商品信息";
        app.editModal.url = "/onlineSale/myStore/secKillForm?secKillId=" + id;
        app.editModal.show = true;
    }

    function edit_ok(id) {
        document.getElementById(id).contentWindow.submit();
    }

    function changeStatus(status,id)
    {
        ajaxGet("/onlineSale/myStore/changeSecKillGoodsStatus?id="+id+"&status="+status,function (res) {

        },null,false);
    }
</script>
</body>
</html>
