<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--配置项目路径--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<html>
<head>

    <base href="<%=basePath%>">
    <link rel="stylesheet" type="text/css" href="static/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="static/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="static/ztree/css/metroStyle/metroStyle.css">
    <script type="text/javascript" src="static/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="static/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="static/ztree/js/jquery.ztree.core.js"></script>
    <script type="text/javascript" src="static/jquery.serializejson/jquery.serializejson.min.js"></script>


</head>

</head>
<body>
<table id="adminDataGrid"></table>

<div id="header">
    <a class="easyui-linkbutton" onclick="addCompanyWindow()" data-options="iconCls:'icon-tip',plain:true">编辑</a>

    <a class="easyui-linkbutton" onclick="openStatus()" data-options="iconCls:'icon-cancel',plain:true">删除</a>
</div>

</body>
<%--管理员adminDataGrid初始化--%>
<script type="text/javascript">
    $('#adminDataGrid').datagrid({
        //分页条
        // pagination: true,
        toolbar: "#header",

        // 选择时不会直接选中，需要点击复选框才行
        checkOnSelect: false,
        //可多选
        selectOnCheck: true,
        /*选中是颜色改变，只有一个改变*/
        singleSelect: true,
        //有条纹的
        striped: true,


        //请求地址
        url: 'admin/selectAllAdmin.do',
        columns: [[
            {field: 'aid', checkbox: true},

            {field: 'aname', title: '姓名', width: 100},


            {field: 'aphone', title: '手机', width: 100},

            {
                field: 'starttime', title: "开通时间", width: 100, formatter: function (value, row, index) {
                    console.log(value)
                    return value.year + '-' + value.monthValue + '-' + value.dayOfMonth
                }
            },
            {field: 'rname', title: '权限', width: 100},





        ]]
    });

</script>
</html>
