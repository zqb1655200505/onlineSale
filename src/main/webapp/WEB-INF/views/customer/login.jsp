<%--
  Created by IntelliJ IDEA.
  User: zqb
  Date: 2018/4/3
  Time: 17:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path ;
%>
<html>
<head>
    <title>登录</title>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/css/login/normalize.css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/css/login/default.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/css/login/styles.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/static/css/login/login.css" >

</head>
<body onkeydown="keyLogin()">


<script type="text/javascript" src="<%=basePath%>/static/js/jquery-2.0.0.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/common.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/vue/vue.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/iview/iview.min.js"></script>
<script type="text/javascript">
    var app = new Vue({
        el: "#app",

        data: {
            value2:0,
        }
    });

    function keyLogin() {

    }
</script>
</body>
</html>
