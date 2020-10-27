<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--配置项目路径--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>Tingyu首页面</title>
    <link rel="stylesheet" type="text/css" href="static/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="static/easyui/themes/icon.css">
    <%-- <link rel="stylesheet" href="static/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">--%>
    <link rel="stylesheet" href="static/ztree/css/metroStyle/metroStyle.css" type="text/css">
    <script type="text/javascript" src="static/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="static/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="static/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="static/ztree/js/jquery.ztree.core.js"></script>

</head>
<body class="easyui-layout">
<div data-options="region:'north',split:true" class="easyui-layout" style="height:100px;">

    <div data-options="region:'west',border:false"
         style="width:25%;height:100%;background-image:url('static/img/bg.png')">
        <img src="static/img/logo.png" style="margin-top: 30px">
    </div>
    <div data-options="region:'center',border:false"
         style="width:50%;height:100%;padding:5px;background-image:url('static/img/bg.png')">
        <span style="font-size: 30px;color: white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;欢迎来到ting域后台页面</span>
    </div>
    <div data-options="region:'east',border:false"
         style="width:25%;height:100%;background-image:url('static/img/bg.png')">
        <div style="color:white;position: absolute;bottom: 10px;right: 20px">
            你好，${admin.aname} <a style="color: white" href="">退出</a>
        </div>
    </div>
</div>
<div data-options="region:'west',split:true" style="width:200px;">
    <ul id="menuTree" class="ztree"></ul>
</div>

<div data-options="region:'center'" style="padding:5px;background:#eee;">
    <%--        选项卡--%>
    <div id="tt" class="easyui-tabs" fit="true">
        <div title="欢迎页面" style="padding:20px;display:none;">
            欢迎使用Ting域主持人管理系统
        </div>
    </div>
</div>
<div data-options="region:'south',split:true" style="height:0px;"></div>


</div>
<script>
    var setting = {
        data: {
            simpleData: {
                enable: true,
                idKey: "mid",
                pIdKey: "pid"
            },
            key: {
                name: "mname",
                url: "xurl"
            }
        },
        async: {
            enable: true,
            url: "menu/selectMenuByUser.do",
            /*预处理加载的数据*/
            dataFilter: ajaxDataFilter
        },
        callback: {
            onClick: zTreeOnCheck
        }
    };

    //设置ztree节点点击事件
    function zTreeOnCheck(event, treeId, treeNode) {

        console.log(treeNode)
        if ($("#tt").tabs('exists', treeNode.mname)) {
            $("#tt").tabs('select', treeNode.mname)
        } else {
            $("#tt").tabs('add', {
                title: treeNode.mname,
                content: "<iframe style='width:100%;height: 100%;border: 0' src='" + treeNode.url + "'>",
                closable: true
            })
        }
    }


    function ajaxDataFilter(treeId, parentNode, responseData) {
        if (responseData) {
            for (var i = 0; i < responseData.length; i++) {
                responseData[i].open = true;
            }
        }
        return responseData;
    };



    $(function () {
        $.fn.zTree.init($("#menuTree"), setting);
    })


</script>

</body>
</html>
