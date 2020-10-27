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
    <title>新人管理页面</title>
</head>
<body>
<table id="marriedPersonDataGrid"></table>

<div id="marriedManagerBar" style="padding:2px 5px;">
    <form id="marriedManagerForm" class="easyui-form" action="host/list.do" method="post">
        <input class="easyui-textbox" name="pname" prompt="姓名" style="width:110px">
        <input class="easyui-textbox" name="phone" prompt="电话" style="width:110px">

        <a href="javascript:void(0);" onclick="marriedSearch();" class="easyui-linkbutton" iconCls="icon-search">搜索</a>

    </form>
</div>


<script>

    function marriedSearch(){
        var formData=$("#marriedManagerForm").serializeJSON();
        $('#marriedPersonDataGrid').datagrid("load",formData);
    }

    $('#marriedPersonDataGrid').datagrid({
        //分页条
        pagination: true,
        // 选择时不会直接选中，需要点击复选框才行
        checkOnSelect: false,
        //可多选
        selectOnCheck: true,
        /*选中是颜色改变，只有一个改变*/
        singleSelect: true,
        //有条纹的
        striped: true,

        toolbar:"#marriedManagerBar",

        //请求地址
        url: 'married/marriedManagerData.do',
        columns: [[
            {field: 'pid', title: "编号"},
            {field: 'pname', title: '新人姓名', width: 100},

            {field: 'phone', title: '新人手机', width: 100},
            {field: 'pmail', title: '新人邮箱', width: 100},

            {
                field: 'marrydate', title: "注册时间", width: 100, formatter: function (value, row, index) {
                    console.log(value)
                    return value.year + '-' + value.monthValue + '-' + value.dayOfMonth
                }
            },
            {
                field: 'regdate', title: "结婚时间", width: 100, formatter: function (value, row, index) {
                    console.log(value)
                    return value.year + '-' + value.monthValue + '-' + value.dayOfMonth
                }
            },


            {
                field: 'status', title: '状态', width: 100, formatter: function (value, row, index) {
                    if (value == 1) {
                        return "<span style=\"color:green\">正常</span>";
                    } else if (value == 2) {
                        return "<span style=\"color:red\">禁用</span>";
                    }

                }
            }


        ]]
    });
</script>
</body>
</html>
