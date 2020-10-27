<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--配置项目路径--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>Tingyu登录页面</title>
    <base href="<%=basePath%>">
    <%--    引入js文件--%>
    <link rel="stylesheet" href="static/easyui/themes/default/easyui.css">
    <link rel="stylesheet" href="static/easyui/themes/icon.css">

    <script type="text/javascript" src="static/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="static/easyui/locale/easyui-lang-zh_CN.js"></script>

</head>
<body>

<%--ting域主持人登录界面--%>

<form id="loginForm" method="post" action="admin/login.do">

    <div style="width: 402px;margin: auto;height: 100%;margin-top: 50px;">
        <div class="easyui-panel" title="欢迎登录ting域" style="width:100%;max-width:400px;padding:30px 60px;">
            <span style="color: red;">${errMsg}</span>

            <div style="margin-bottom:20px">
                <input class="easyui-textbox" name="aname" value="admin" style="width:100%"
                       data-options="label:'用户名:',required:true,missingMessage:'账号不能为空'">
            </div>
            <div style="margin-bottom:20px">
                <input class="easyui-passwordbox" name="apwd" value="123" style="width:100%"
                       data-options="label:'密码:',required:true,missingMessage:'密码不能为空'">
            </div>


            <%--            <div style="text-align:center;padding:5px 0">--%>
            <%--                <a class="easyui-linkbutton" onclick="loginFun()" href="javascript:void(0)" style="width:200px">登录</a>--%>
            <%--            </div>--%>
            <div style="margin-top: 30px;width: 100%">
                <a onclick="loginFun()" href="javascript:void(0)" style="height:40px;width: 100%"
                   class="easyui-linkbutton">登录</a>
            </div>

        </div>
    </div>
</form>


<script type="text/javascript">
    function loginFun() {
        var isValid = $("#loginForm").form('validate');
        if (isValid) {
            $("#loginForm").submit();
        }
    }
</script>


</body>
</html>
