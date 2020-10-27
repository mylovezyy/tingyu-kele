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
<title>菜单管理</title>
</head>
<body class="easyui-layout">


<div data-options="region:'west'" style="width:200px;padding:50px">
    <a id="add" href="javascript:void(0);" style="margin-bottom: 30px" class="easyui-linkbutton"
       data-options="iconCls:'icon-add'">新增菜单</a><br>
    <a id="edit" href="javascript:void(0);" style="margin-bottom: 30px" class="easyui-linkbutton"
       data-options="iconCls:'icon-edit'">编辑菜单</a><br>
    <a id="del" href="javascript:void(0);" style="margin-bottom: 30px" class="easyui-linkbutton"
       data-options="iconCls:'icon-remove'">删除菜单</a><br>
    <a id="flash" onclick="reloadMenu()" href="javascript:void(0);" style="margin-bottom: 30px"
       class="easyui-linkbutton"
       data-options="iconCls:'icon-reload'">刷新菜单</a><br>

</div>

<div data-options="region:'center'">

    <ul id="menuTree" class="ztree"></ul>

</div>

<div id="menuWindow" data-options="closed:true" title="新增菜单" class="easyui-window"
     style="width: 400px;height:350px;padding: 0px 30px">
    <form class="easyui-form" id="menuForm" method="post">
        <input name="mid" type="hidden">
        <div style="width: 100%;margin-top: 30px;">
            <input id="parentMenu" name="pid" class="easyui-combobox" style="width:100%;"
                   data-options="valueField:'mid',textField:'mname',label:'父菜单'">
        </div>

        <div style="width: 100%;margin-top: 30px">
            <input required data-options="label:'菜单名称'" style="width: 100%" class="easyui-textbox" name="mname">
        </div>
        <div style="margin-top: 30px;width: 100%">
            <input required data-options="label:'菜单地址'" style="width: 100%" class="easyui-textbox" name="url">
        </div>

        <div style="margin-top: 30px;width: 100%">
            <input required data-options="label:'菜单描述',showEye:false" style="width: 100%" class="easyui-textbox"
                   name="mdesc">
        </div>
        <div style="margin-top: 30px;width: 100%">
            <a onclick="saveOrUpdateMenu();" href="javascript:void(0)" style="width: 100%"
               class="easyui-linkbutton">提交</a>
        </div>
    </form>
</div>

<%--加载树--%>
<script type="text/javascript">

    var setting = {
        data: {
            simpleData: {
                enable: true,
                idKey: "mid",
                pIdKey: "pid"
            },
            key: {
                name: "mname",
                url: "xurl",

            }
        },
        async: {
            enable: true,
            url: "menu/list.do",
            /*预处理加载的数据*/
            dataFilter: ajaxDataFilter
        }
    };



    function ajaxDataFilter(treeId, parentNode, responseData) {
        if (responseData) {
            for (var i = 0; i < responseData.length; i++) {
                responseData[i].open = true;
            }
        }
        return responseData;
    }

    //初始化ztree
    $(function () {
        $(document).ready(function(){
            $.fn.zTree.init($("#menuTree"), setting);
        });
    })

</script>

<%--对菜单树进行增删改查--%>
<script>
    <%--    该方法是对父级菜单的初始化，之后=如果需要父级菜单，那么我们需要将combobox
            进行reload--%>
    $(function () {
        $("#parentMenu").combobox({
            url: "menu/list.do",
            loadFilter: function (data) {
                var parentData = {mid: 0, mname: "顶级菜单"};
                data.unshift(parentData);
                console.log(data)
                return data;
            }
        })
    })

    //添加或修改使用同一个表单，那么使用同一个方法，添加没有mid，修改有mid
    function saveOrUpdateMenu() {
        $("#menuForm").form('submit', {
            url: "menu/saveOrUpdateMenu.do",
            onsubmit: function () {
                return $("#menuForm").form('validate');
            },
            //验证之后提交，并回调
            success: function (data) {
                var json = JSON.parse(data);
                //    1重置表单
                $("#menuForm").form('reset');
                //    2.关闭wiundow
                $("#menuWindow").window("close");
                //    刷新菜单树
                reloadMenu();
                //    显示结果
                $.messager.alert("温馨提示", json.msg, 'info');

            }

        })
    }

    function reloadMenu() {
        var treeObj = $.fn.zTree.getZTreeObj("menuTree");
        treeObj.reAsyncChildNodes(null, "refresh");
    }


    $("#add").click(function () {


        $("#parentMenu").combobox("reload")

        /*重置表单*/
        // $("#menuForm").form("reset");
        $("#menuWindow").window({
            title: "新增菜单",
            closed: false,
        })

    });

    //编辑菜单
    $("#edit").click(function () {
        //获取树
        var treeObj = $.fn.zTree.getZTreeObj("menuTree");
        //获取选中的树节点
        var nodes = treeObj.getSelectedNodes();

        if (nodes.length == 0) {
            $.messager.alert("温馨提示", "请选择一个菜单", "info");
            return false
        }
        $("#parentMenu").combobox("reload")
        /*重置表单*/
        $("#menuForm").form("reset");
        //表单数据回写
        var menu = nodes[0];
        console.log(menu)
        $("#menuForm").form("load", menu);

        $("#menuWindow").window({
            title: "修改菜单",
            closed: false,
        })
    })

    $("#del").click(function () {
        var treeObj = $.fn.zTree.getZTreeObj("menuTree");
        //获取选中的树节点
        var nodes = treeObj.getSelectedNodes();

        if (nodes.length == 0) {
            $.messager.alert("温馨提示", "请选择一个菜单", "info");
            return false
        }

        $.messager.confirm("温馨提示", "您是否确认删除该菜单", function (r) {
            if (r) {
                var menu = nodes[0];
                $.post(
                    "menu/delMenuById.do",
                    {mid: menu.mid},
                    function (data) {
                        //刷新树
                        reloadMenu();
                        $.messager.alert("温馨提示", data.msg, 'info');
                    }
                )
                $.ajaxSettings.async = true;
            }

        })
    })

</script>

</body>
</html>
