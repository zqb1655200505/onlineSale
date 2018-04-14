<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path;
%>
<html>
<head>
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
            height: 230px;
        }

        .goods-item-description
        {
            background-color: #2baee9;
            font-size: 20px;
            padding: 10px;
            width: 100%;
            height: 100px;
        }
        .ivu-page-next .ivu-icon
        {
            line-height: 2;
        }
        .ivu-page-prev .ivu-icon
        {
            line-height: 2;
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
        <jsp:include page="header.jsp"/>

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
                            <div class="demo-carousel">
                                <a :href="item.link">
                                    <img :src="item.image" style="width: 100%;height: 100%;">
                                </a>
                            </div>
                        </Carousel-item>

                    </Carousel>
                </i-col>
            </Row>

            <Row :gutter="64">
                <i-col v-for="(item,index) in goodsList" v-if="index%4==0" span="5" offset="2" style="margin-top: 30px;">
                    <Card>
                        <img src="<%=basePath%>/upload/image/test.jpg" class="goods-item-img">
                        <div class="goods-item-description">
                            <span>{{item.description}}{{index}}</span>
                        </div>
                    </Card>
                </i-col>
                <i-col v-else span="5" style="margin-top: 30px;">
                    <Card>
                        <img src="<%=basePath%>/upload/image/test.jpg" class="goods-item-img">
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
        refresh() ;
    };

    function refresh() {
        <%--ajaxGet("${ctx}/science/infoInstitution/list?pageNo=" + app.page.no + "&pageSize=" + app.page.size--%>
            <%--, function (d) {--%>
                <%--app.goodsList = d.data.list;--%>
                <%--app.page.total = d.data.total;--%>
            <%--}, null, false);--%>
        app.goodsList.splice(0,app.goodsList.length);
        for(var i=0;i<app.page.size;i++)
        {
            var item={
                description:"aas搭嘎第三方八十多分",
                image:""
            };
            app.goodsList.push(item);
        }
        app.seckillList.splice(0,app.seckillList.length);

        for(var i=0;i<app.page.size;i++)
        {
            var item={
                description:"aas搭嘎第三方八十多分",
                link:"#",
                image:"<%=basePath%>/upload/image/test.jpg"
            };
            app.seckillList.push(item);
        }
    }

    $(document).ready(function () {
       refresh();
    });
</script>
</body>
</html>
