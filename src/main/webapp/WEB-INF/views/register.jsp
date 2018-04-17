<%--
  Created by IntelliJ IDEA.
  User: zqb
  Date: 2018/4/14
  Time: 19:31
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
    <title>优铺在线销售系统-注册</title>
    <link href="<%=basePath%>/static/iview/styles/iview.css" rel="stylesheet" type="text/css"/>
    <style>
        body{
            margin: 0 auto;
            background-color: #eeeeee;
        }
        .content
        {
            width: 1200px;
            margin: 0 auto;
        }
        .ivu-form-item-content
        {
            margin: 0 auto;
            text-align: center;
        }
        .ivu-input
        {
            height: 50px;
            font-size: 18px;
        }
        .ivu-radio-wrapper
        {
            font-size: 18px;
        }
        .ivu-checkbox-wrapper
        {
            font-size: 16px;
        }
        .layout-footer-center{
            text-align: center;
            font-size: 17px;
            margin-top: 25px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body onkeydown="keyLogin()">
<div class="content" id="app">
    <Row>
        <i-col span="6" offset="9" style="margin-top: 20px;margin-bottom: 20px;">
            <a href="/onlineSale/index">
                <img src="<%=basePath%>/upload/image/logo_with_text.png" style="height: 100px;width: auto;"/>
            </a>
        </i-col>
    </Row>
    <Row style="margin-bottom: 50px;">
        <i-col span="20" offset="2">
            <Card style="padding-bottom: 50px;">
                <h1 slot="title" style="margin-top: 20px;margin-bottom: 8px;">用户注册</h1>

                <Row>
                    <i-col span="12" offset="6">
                        <i-form ref="form" :model="userInfo" :rules="validate">
                            <Form-Item>
                                <%--<lable style="font-size: 18px;">用户类型：</lable>--%>
                                <Radio-Group v-model="userInfo.userType" ><%--@on-change="changeUserType($event)"--%>
                                    <Radio label="0">普通客户</Radio>
                                    <Radio label="1">商家用户</Radio>
                                </Radio-Group>
                            </Form-Item>
                            <Form-Item prop="userName">
                                <i-input type="text" v-model="userInfo.userName" placeholder="userName">

                                </i-input>
                            </Form-Item>

                            <Form-Item prop="userPassword">
                                <i-input type="password" v-model="userInfo.userPassword" placeholder="Password">

                                </i-input>
                            </Form-Item>

                            <Form-Item prop="confirmPassword">
                                <i-input type="password" v-model="userInfo.confirmPassword" placeholder="Confirm Password">

                                </i-input>
                            </Form-Item>
                            <Form-Item>
                                <Checkbox v-model="checkProtocol">我已阅读并同意<a target="_blank" href="#"> 优铺服务协议 </a>和<a target="_blank" href="#"> 优铺隐私声明 </a></Checkbox>
                            </Form-Item>

                            <Form-Item>
                                <i-button type="primary" @click="handleSubmit()" long style="font-size: 17px;" :disabled="!checkProtocol">注册</i-button>
                            </Form-Item>
                        </i-form>
                    </i-col>
                </Row>

                <Row>
                    <i-col span="12" offset="6" style="text-align: center;font-size: 16px;">
                        已有账号？<a :href="toLogin">立即登录</a>
                    </i-col>

                </Row>
            </Card>
        </i-col>
    </Row>
    <Footer class="layout-footer-center">
        <hr style="margin-bottom: 10px;"/>
        2014-2018 &copy; software engineering
    </Footer>
</div>
<script type="text/javascript" src="<%=basePath%>/static/js/jquery-2.0.0.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/common.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/iview/vue.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/iview/iview.min.js"></script>
<script type="text/javascript">
    //# sourceURL=register.js
    var app = new Vue({
        el: "#app",

        data: {
            userInfo:{
                userName:"",
                userPassword:"",
                confirmPassword:"",
                userType:"0",
            },
            checkProtocol:true,
            const: validatePwdCheck = function (rule, value, callback) {

                if (value === '') {
                    callback(new Error('请确认密码'));
                } else if (value !== app.userInfo.userPassword) {
                    callback(new Error('密码前后不一致!'));
                } else {
                    callback();
                }
            },
            toLogin:"/onlineSale/login",
            validate: {
                userName: [
                    { required: true, message: '用户名不能为空', trigger: 'blur' }
                ],
                userPassword: [
                    { required: true, message: '密码不能为空', trigger: 'blur' },
                    { type: 'string', min: 6, message: '密码长度不能少于6位', trigger: 'blur' }
                ],
                confirmPassword:[
                    {validator: validatePwdCheck}
                ]
            }
        }
    });

    function keyLogin() {
        if (event.keyCode==13)  //回车键的键值为13
        {
            handleSubmit();
        }
    }

    function handleSubmit()
    {
        app.$refs['form'].validate( function (valid) {
            if (valid)
            {
                var user={
                    userName:app.userInfo.userName,
                    userPassword:app.userInfo.userPassword,
                    userType:app.userInfo.userType
                };

                ajaxPost("/onlineSale/doRegister",user,function (res) {
                    if(res.code==="success")
                        window.location.href="/onlineSale/login"
                    else
                    {
                        app.userInfo.userName="";
                        app.userInfo.userPassword="";
                        app.userInfo.confirmPassword="";
                        app.userInfo.userType="0";
                    }
                },null,false);
            }
            else
            {
                app.$Message.error('请正确填写信息!');
            }
        })
    }

</script>
</body>
</html>
