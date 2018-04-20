<%--
  Created by IntelliJ IDEA.
  User: zqb
  Date: 2018/4/17
  Time: 15:26
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
    <link href="<%=basePath%>/static/iview/styles/iview.css" rel="stylesheet" type="text/css"/>
    <link href="<%=basePath%>/static/bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="<%=basePath%>/static/css/header.css" rel="stylesheet" type="text/css"/>
</head>
<body>
    <div v-cloak id="app">
        <i-form ref="form" :model="goods" :rules="validate" :label-width="100">
            <div style="padding:20px;">
                <Form-item label="商品名称：" prop="goodsName">
                    <i-Input v-model="goods.goodsName" type="text"  maxlength="255"></i-Input>

                </Form-item>


                <Form-item label="商品图片：" prop="goodsPic">
                    <%--<i-Input v-model="goods.goodsPic" type="text" maxlength="255" ></i-Input>--%>
                    <div style="width: 130px;height: 150px;">
                        <Upload style="width: 100%;height: 100%;"
                                accept="image/*"
                                :before-upload="handleBeforeUploadPic"
                                :show-upload-list="false">
                            <i-Button type="ghost" style="width: 130%;height: 100%;" v-if="!hasPic"><Icon type="ios-plus-empty" size="100"></Icon></i-Button>
                            <img :src="photo.src" style="width: 100%;height: 100%;" v-else/>
                        </Upload>
                    </div>
                </Form-item>

                <Form-item label="商品数量：" prop="goodsNum">
                    <i-Input v-model="goods.goodsNum" type="number" min="0" ></i-Input>
                    <%--<Input-Number v-model="goods.goodsNum" min="0"></Input-Number>--%>
                </Form-item>

                <Form-item label="商品单价：" prop="goodsPrice">
                    <i-Input v-model="goods.goodsPrice" type="number"></i-Input>
                </Form-item>

                <Form-item label="商品信息：" prop="goodsDescription">
                    <i-Input v-model="goods.goodsDescription" type="textarea" :rows="5" ></i-Input>
                </Form-item>


            </div>
        </i-form>
    </div>
<script type="text/javascript" src="<%=basePath%>/static/js/jquery-2.0.0.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/iview/vue.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/iview/iview.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/common.js"></script>
<script type="text/javascript">
    //# sourceURL=goodsForm.js

    var app = new Vue({
        el: "#app",

        data: {
            goods: {
                id: "${goods.id}",
                goodsName: "${goods.goodsName}",
                goodsPic:"${goods.goodsPic}",
                goodsNum: "${goods.goodsNum}",
                goodsDescription:"${goods.goodsDescription}",
                goodsPrice:"${goods.goodsPrice}"
            },

            hasPic:parent.app.hasPic,
            photo:{
                src:"${goods.goodsPic}",
                file:null,
            },

            // 验证规则
            validate: {
                goodsName:[{required: true, message: '商品名称不能为空', trigger: 'blur' }],
                goodsNum:[{required: true, message: '商品数量不能为空', trigger: 'blur' }],
                goodsPrice:[{required: true, message: '商品价格不能为空', trigger: 'blur' }],
            }

        }
    });



    //此函数放在app内部无作用，原因不明
    function handleBeforeUploadPic(file)
    {
        if (file.size > 10485760) {
            app.$Message.warning("照片大小超过限制");
            return false;
        }
        if (file.type.indexOf("image") != 0) {
            app.$Message.warning("文件类型不支持");
            return false;
        }
        var reader = new FileReader();
        reader.onload = function (e) {
            app.photo.src = e.target.result;
            app.photo.file = file;
        };
        reader.readAsDataURL(file);
        app.hasPic=true;
        return false;
    }

    // 提交表单
    function submit() {

        app.$refs["form"].validate(function (valid) {
            if (valid)
            {
                var formdata=new FormData();
                if(app.photo.file!=null)
                {
                    formdata.append('uploadFile', app.photo.file);
                }
                formdata.append("goods",JSON.stringify(app.goods));
                $.ajax({
                    type : 'post',
                    url : "/onlineSale/myStore/save",
                    data : formdata,
                    cache : false,
                    processData : false, // 不处理发送的数据，因为data值是Formdata对象，不需要对数据做处理
                    contentType : false, // 不设置Content-type请求头
                    success : function(rep)
                    {
                        if(rep.code=="success")
                        {
                            if ("${goods.id}" == "")
                            {
                                app.goods.goodsName="";
                                app.goods.goodsDescription="";
                                app.goods.goodsNum="";
                                app.goods.goodsPic="";
                                app.goods.goodsPrice="";
                            }
                            parent.app.$Message.success(rep.message);
                            parent.changePage(1);
                        }
                        else //显示错误信息
                        {
                            parent.app.$Message.error(rep.message);
                        }
                        parent.app.editModal.show = false;
                    },
                    error : function()
                    {
                        app.$Message.error("请求出错");
                    }
                });
            }
            else
            {
                //假装提交
                parent.app.editModal.loading = false;
                setTimeout("parent.app.editModal.loading = true", 100);

                app.$Message.error('请正确填写信息!');
            }
            parent.app.editModal.loading = false;
        });

    }
</script>
</body>



</html>
