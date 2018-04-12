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
            line-height: 400px;
            text-align: center;
            color: #fff;
            font-size: 20px;
            background: #506b9e;
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
    </style>

</head>
<body>
<div class="layout" v-cloak id="app">
    <Layout>
        <jsp:include page="header.jsp"/>

        <Content class="layout-content-center">
            <Row>
                <i-col offset="2" span="20">
                    <Carousel v-model="value2" autoplay autoplay-speed="3000" loop>
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
                <i-col span="5" offset="2" style="margin-top: 30px;">
                    <Card>
                        <img src="<%=basePath%>/upload/image/test.jpg" class="goods-item-img">
                        <div class="goods-item-description">
                            <span>你好是大V按时大Vad深V</span>
                        </div>
                    </Card>
                </i-col>
                <i-col  span="5" style="margin-top: 30px;">
                    <Card>
                        <img src="<%=basePath%>/upload/image/test.jpg" class="goods-item-img">
                        <div class="goods-item-description">
                            <span>你好是大V按时大Vad深V</span>
                        </div>
                    </Card>
                </i-col>
                <i-col  span="5" style="margin-top: 30px;">
                    <Card>
                        <img src="<%=basePath%>/upload/image/test.jpg" class="goods-item-img">
                        <div class="goods-item-description">
                            <span>你好是大V按时大Vad深V</span>
                        </div>
                    </Card>
                </i-col>
                <i-col  span="5" style="margin-top: 30px;">
                    <Card>
                        <img src="<%=basePath%>/upload/image/test.jpg" class="goods-item-img">
                        <div class="goods-item-description">
                            <span>你好是大V按时大Vad深V</span>
                        </div>
                    </Card>
                </i-col>

                <i-col span="5" offset="2" style="margin-top: 30px;">
                    <Card>
                        <img src="<%=basePath%>/upload/image/test.jpg" class="goods-item-img">
                        <div class="goods-item-description">
                            <span>你好是大V按时大Vad深V</span>
                        </div>
                    </Card>
                </i-col>
                <i-col  span="5" style="margin-top: 30px;">
                    <Card>
                        <img src="<%=basePath%>/upload/image/test.jpg" class="goods-item-img">
                        <div class="goods-item-description">
                            <span>你好是大V按时大Vad深V</span>
                        </div>
                    </Card>
                </i-col>
                <i-col  span="5" style="margin-top: 30px;">
                    <Card>
                        <img src="<%=basePath%>/upload/image/test.jpg" class="goods-item-img">
                        <div class="goods-item-description">
                            <span>你好是大V按时大Vad深V</span>
                        </div>
                    </Card>
                </i-col>
                <i-col  span="5" style="margin-top: 30px;">
                    <Card>
                        <img src="<%=basePath%>/upload/image/test.jpg" class="goods-item-img">
                        <div class="goods-item-description">
                            <span>你好是大V按时大Vad深V</span>
                        </div>
                    </Card>
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
            value2:0,
        },
        method:{

        }
    });
</script>
</body>
</html>
