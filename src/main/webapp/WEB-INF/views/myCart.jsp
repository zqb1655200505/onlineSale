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
    String goodsDetail="/onlineSale/consumer/goodsDetail?isSecKill=false&id=";
%>
<html>
<head>
    <title>优铺在线销售系统-购物车</title>
    <link href="<%=basePath%>/static/iview/styles/iview.css" rel="stylesheet" type="text/css"/>
    <link href="<%=basePath%>/static/css/header.css" rel="stylesheet" type="text/css"/>
    <style rel="stylesheet">
        .ivu-input-number-input,ivu-input-number-handler-wrap
        {
            height: 38px;
        }
        .ivu-input-number-handler
        {
            height: 18px;
        }
        .ivu-input-number-handler-down-inner, .ivu-input-number-handler-up-inner
        {
            line-height: 18px;
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
                <i-col span="16" offset="4" style="min-height: 650px;">
                    <Row>
                        <div style="margin-bottom:10px;margin-top: 5px;float: left;">
                            <i-button @click="remove()" type="warning" icon="minus">从购物车移除</i-button>
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


                    <Row v-for="item in viewModel.list" style="font-size: 15px;margin-top: 10px;background-color: #d8ebee;">
                        <i-col span="1" style="padding-top: 15px;">
                            <Checkbox v-model="item.checked" style="margin-left: 8px;" :key="item.id" @on-change="itemStatusChange($event,item)"></Checkbox>
                        </i-col>
                        <i-col span="11">
                            <i-col span="6">
                                <a :href="'<%=goodsDetail%>'+item.id"><img style="height: 100px;" :src="item.goodsPic"/></a>
                            </i-col>
                            <i-col offset="1" span="17" style="padding-top: 20px;line-height: 25px;text-align: left;">
                                <a :href="'<%=goodsDetail%>'+item.id">{{item.goodsName}}</a>
                            </i-col>
                        </i-col>

                        <i-col span="3" style="padding-top: 20px;">
                            <span>￥{{item.goodsPrice}}</span>
                        </i-col>

                        <i-col span="3" style="padding-top: 10px;">
                            <Input-Number :max="item.goodsNum" :min="1" v-model="getGoodsNumber(item.id)" style="height: 38px;" @on-change="itemNumChange($event,item)"></Input-Number>
                            <p style="line-height: 40px;">库存：<span style="color: red;">{{item.goodsNum}}</span></p>
                        </i-col>

                        <i-col span="3" style="padding-top: 20px;">
                            <span :id="'price_'+item.id">￥{{getGoodsNumber(item.id)*item.goodsPrice}}</span>
                        </i-col>
                        <%--getItemCountPrice(item)--%>
                        <i-col span="3" style="padding-top: 20px;">
                            <a @click="removeConfirm(item)">
                                <Icon type="android-delete"></Icon> 删除
                            </a>
                        </i-col>
                    </Row>


                    <Row style="height: 50px;margin-top: 10px;border: 1px solid #d2d2d2;font-size: 14px;">
                        <i-col span="2">
                            <Checkbox @on-change="checkAll()"  v-model="viewModel.allChecked" style="margin-left: 8px;margin-top: 18px;">
                                &nbsp;&nbsp;全选
                            </Checkbox>
                        </i-col>

                        <i-col span="4" offset="11">
                            <p style="line-height: 50px;">共选择<span style="color: red;font-weight: bolder;"> {{chooseNum}} </span>件商品</p>
                        </i-col>

                        <i-col span="4">
                            <p style="line-height: 50px;">总价<span style="color: red;font-size: 16px;font-weight: bolder;"> ￥{{totalPrice}} </span></p>
                        </i-col>

                        <i-col span="3" style="height: 100%;">
                            <i-button type="error" style="width: 100%;height: 100%;font-size: 22px;" @click="gotoSettlement">去结算</i-button>
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

            page : {
                no: 1,
                total: 20,
                size: parseInt(cookie("pageSize")) || 5,
            },

            chooseNum:0,

            totalPrice:0,

            purchaseModal:"",
        }
    });


    //全选事件
    function checkAll() {
        app.totalPrice=0;
        if(app.viewModel.allChecked)
        {
            app.viewModel.list.forEach(function (item) {
                item.checked = app.viewModel.allChecked;
                app.totalPrice=app.totalPrice+getGoodsNumber(item.id)*item.goodsPrice;
            });
        }
        else
        {
            app.viewModel.list.forEach(function (item) {
                item.checked = app.viewModel.allChecked;
            });
        }
    };


    function remove() {
        var list = [];
        app.viewModel.list.forEach(function (item) {
            if (item.checked)
                list.push(item);
        });

        if (list.length == 0) {
            app.$Message.error('请选择需移除商品！');
            return;
        }

        app.$Modal.confirm({
            content: "<div style='margin-top: -16px;'><h2>移除商品</h2></div><br><p>确认将所选商品从购物车移除？</p>",
            loading: true,
            onOk: function () {
                for(var i=0;i<list.length;i++)
                {
                    removeFromCookie(list[i]);
                }
            }
        });
    }

    function refresh()
    {
        var cartGoodsIdList=cookie("cartGoodsIdList")||"";
        var itemNumList=cookie("itemNumList")||"";
        if(cartGoodsIdList!="")
        {
            ajaxGet("/onlineSale/myCart/getCartGoods?idList="+cartGoodsIdList+"&pageNo="+app.page.no+"&pageSize="+app.page.size+"&keys=" +encodeURIComponent(app.viewModel.keys),
                function (res) {
                app.viewModel.list=res.data;
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

                //登录成功，将cookie中的购物车记录加入数据库
            }
        },null,false);

        refresh();
    });


    //从cookie获取该商品数目
    function getGoodsNumber(id) {
        var cartGoodsIdList=cookie("cartGoodsIdList")||"";
        var itemNumList=cookie("itemNumList")||"";
        var numList=itemNumList.split(";");
        var index=-1;
        var idList=cartGoodsIdList.split(";");
        for(var i=0;i<idList.length;i++)
        {
            if(idList[i]==id)
            {
                index=i;
                break;
            }
        }
        return numList[index];
    }

    //商品项发生变化时触发
    function itemNumChange(value,item)
    {
        //更新cookie
        var cartGoodsIdList=cookie("cartGoodsIdList")||"";
        var itemNumList=cookie("itemNumList")||"";
        var index=-1;
        var idList=cartGoodsIdList.split(";");
        for(var i=0;i<idList.length;i++)
        {
            if(idList[i]==item.id)
            {
                index=i;
                break;
            }
        }
        var numList=itemNumList.split(";");
        numList[index]=value;

        itemNumList="";
        var count=0;
        for(var i=0;i<numList.length-1;i++)
        {
            count=count+Number(numList[i]);
            itemNumList=itemNumList+numList[i]+";";
        }
        itemNumList=itemNumList+numList[numList.length-1];
        count=count+Number(numList[numList.length-1]);

        var option={
            path:"/onlineSale",
            expires:7,
        };
        cookie("cartGoodsNum",count,option);
        cookie("itemNumList",itemNumList,option);

        //动态改变小计
        var id="price_"+item.id;
        document.getElementById(id).innerText="￥"+Number(value)*Number(item.goodsPrice);

        if(item.checked)
        {
            app.totalPrice=0;
            app.viewModel.list.forEach(function (subItem) {
                if(subItem.checked)
                    app.totalPrice=app.totalPrice+getGoodsNumber(subItem.id)*subItem.goodsPrice;
            });
        }
    }


    //复选框勾选状态发生改变时触发
    function itemStatusChange(status,item) {
        if(status)
        {
            app.totalPrice=app.totalPrice+getGoodsNumber(item.id)*item.goodsPrice;
        }
        else
        {
            app.totalPrice=app.totalPrice-getGoodsNumber(item.id)*item.goodsPrice;
        }
    }


    function removeFromCookie(item) {

        var cartGoodsIdList=cookie("cartGoodsIdList")||"";
        var itemNumList=cookie("itemNumList")||"";
        var cartGoodsNum=cookie("cartGoodsNum")||0;

        var numList=itemNumList.split(";");
        var idList=cartGoodsIdList.split(";");
        cartGoodsIdList="";
        itemNumList="";
        for(var i=0;i<idList.length;i++)
        {
            if(idList[i]!=item.id)
            {
                cartGoodsIdList+=idList[i]+";";
                itemNumList+=numList[i]+";";
            }
            else
            {
                cartGoodsNum=cartGoodsNum-Number(numList[i]);
            }
        }
        if(cartGoodsIdList.length>0)
        {
            cartGoodsIdList=cartGoodsIdList.substr(0,cartGoodsIdList.length-1);
            itemNumList=itemNumList.substr(0,itemNumList.length-1);
        }

        //设置为全局cookie，若不加这个参数则cookie为该页面的
        var option={
            path:"/onlineSale",
            expires:7,
        };

        cookie("cartGoodsNum",cartGoodsNum,option);
        cookie("cartGoodsIdList",cartGoodsIdList,option);
        cookie("itemNumList",itemNumList,option);
    }


    function removeConfirm(item) {
        app.$Modal.confirm({
            content: "<div style='margin-top: -16px;'><h3>移除商品</h3><br><p>确认将商品 <span style='color: red;'>"+item.goodsName+"</span> 从购物车移除吗？</p><div>",
            loading: true,
            closable:true,
            onOk: function () {
                removeFromCookie(item);
                app.$Modal.remove();
                app.viewModel.list=removeFromArray(app.viewModel.list,item);
            }
        });
    }


    //去结算
    function gotoSettlement() {
        var flag = false;
        var idList=[];
        var numList=[];
        app.purchaseModal="<h2 style='margin-top: -15px;'>您确认购买以下商品吗？</h2><br><ul style='list-style-type: none;font-size: 15px;'>";
        app.viewModel.list.forEach(function (item) {
            if (item.checked)
            {
                flag=true;
                idList.push(item.id);
                var num=getGoodsNumber(item.id);
                numList.push(num);
                app.purchaseModal+="<li style='line-height: 30px;'>"+item.goodsName+"  ，数目：<span style='color: red;'>"+num+"</span></li>";
            }

        });
        app.purchaseModal+="</ul>";
        if (!flag) {
            app.$Message.error('请选择需购买商品！');
            return;
        }
        if(app.haveLogin)
        {
            app.purchaseModal+="<br><h3>商品总价为：<span style='color: red;font-size: 20px;'> ￥"+app.totalPrice+" </span> </h3>";

            var list={
                idList:idList,
                numList:numList
            };
            app.$Modal.confirm({
                content: app.purchaseModal,
                loading: true,
                onOk: function () {
                    ajaxPostJSON("/onlineSale/myOrder/addOrder",list,function (res) {
                        if(res.code=="success")
                        {
                            app.viewModel.list.forEach(function (item) {
                                if (item.checked)
                                {
                                    removeFromCookie(item);
                                }
                            });
                            app.$Modal.remove();
                            setTimeout(function () {
                                window.location.href="/onlineSale/myOrder/";
                            },1000);

                        }

                    },null,false);
                }
            });
        }
        else//通过后端跳转到登录页面，因为登录后还得返回当前页
        {
            var form=document.createElement("form");//定义一个form表单
            form.action = "/onlineSale/myCart/gotoLogin";
            form.method = "post";
            form.style.display = "none";
            var opt = document.createElement("input");
            opt.name = "redirectUrl";
            opt.value = window.location;
            form.appendChild(opt);
            document.body.appendChild(form);//将表单放置在web中
            form.submit();//表单提交
        }
    }



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


</script>
</body>
</html>
