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
<table id="companyDataGrid"></table>


<div id="header">
    <a class="easyui-linkbutton" onclick="openCompanyWindow()" data-options="iconCls:'icon-add',plain:true">添加</a>
    <a class="easyui-linkbutton" onclick="addCompanyWindow()" data-options="iconCls:'icon-tip',plain:true">编辑</a>
    <a class="easyui-linkbutton" onclick="getAllThePlanner()" data-options="iconCls:'icon-lock',plain:true">策划师列表</a>
    <a class="easyui-linkbutton" onclick="changeCompanyStatus()"
       data-options="iconCls:'icon-lock',plain:true">禁用启用账号</a>
    <a class="easyui-linkbutton" onclick="openStatus()" data-options="iconCls:'icon-lock',plain:true">账号审核</a>
</div>

<div id="hostTb" style="padding:2px 5px;">
    <form id="companySearchForm" class="easyui-form" action="host/list.do" method="post">
        <input class="easyui-textbox" name="cname" prompt="公司名称(可不写)" style="width:110px">
        <select data-options="editable:false," class="easyui-combobox" name="status" panelHeight="auto"
                style="width:100px">
            <option value="">账号状态</option>
            <option value="0">未审核</option>
            <option value="1">正常</option>
            <option value="2">禁用</option>
        </select>
        <select data-options="editable:false" class="easyui-combobox" name="ordernumber" panelHeight="auto"
                style="width:100px">
            <option value="">订单排序</option>
            <option value="0">订单降序</option>
            <option value="1">订单升序</option>
        </select>

        <a href="javascript:void(0);" onclick="companySearch();" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
        <a href="javascript:void(0);" onclick="resetForm();" class="easyui-linkbutton" iconCls="icon-reload">重置</a>
    </form>
</div>


<%--新增修改婚庆公司窗口--%>
<div id="companyWindow" data-options="closed:true" class="easyui-window"
     style="height: 300px; width: 400px;padding: 30px 30px">
    <form id="companyForm" class="easyui-form" method="post">
        <input name="cid" type="hidden">
        <div style="width: 100%">
            <input required data-options="label:'公司名称'" style="width: 100%" class="easyui-textbox" name="cname">
        </div>
        <div style="margin-top: 20px;width: 100%">
            <input required data-options="label:'公司法人'" style="width: 100%" class="easyui-textbox" name="ceo">
        </div>

        <div style="margin-top: 20px;width: 100%">
            <input id="cpwd" required data-options="label:'密码',showEye:false" style="width: 100%"
                   class="easyui-passwordbox" name="cpwd">
        </div>
        <div style="margin-top: 20px;width: 100%">
            <input id="cpwd1" validType="equals['#cpwd']" required data-options="label:'确认密码',showEye:false"
                   style="width: 100%" class="easyui-passwordbox" name="cpwd1">
        </div>
        <div style="margin-top: 20px;width: 100%">
            <input required data-options="label:'邮箱',validType:'email'" style="width: 100%" class="easyui-textbox"
                   name="cmail">
        </div>
        <div style="margin-top: 20px;width: 100%">
            <input required data-options="label:'手机'" style="width: 100%" class="easyui-textbox" name="cphone">
        </div>
        <div style="margin-top: 20px;width: 100%">
            <a onclick="saveOrUpdateCompany();" href="javascript:void(0)" style="width: 100%" class="easyui-linkbutton">提交</a>
        </div>
    </form>
</div>


<%--策划师列表窗口--%>
<div id="plannerWindow" data-options="closed:true" data-options="modal:true" class="easyui-window"
     style="width: 80%;height: 60%">

    <%--策划师表格--%>
    <table id="plannerDatagrid" class="easyui-datagrid" data-options="pagination:true"
           style="width: 100%;height: 100%"></table>

</div>


<script>
    <%--    模糊查询--%>

    function companySearch() {
        var formdata = $("#companySearchForm").serializeJSON();
        $("#companyDataGrid").datagrid("load", formdata)
    }

    function  resetForm() {
        $("#companySearchForm").form("reset");

    }


    function openStatus() {

        var rows = $("#companyDataGrid").datagrid("getChecked");
        if (rows.length == 0) {
            $.messager.alert("温馨提示", "请选择一家公司", "warning");
            return false;
        }
        var company = rows[0];
        if (company.status != 0) {
            $.messager.alert("温馨提示", "公司已审核", "info");
            return false;
        }

        $.messager.confirm("温馨提示", "是否确认改变状态", function (r) {
            if (r) {
                $.post("company/changeCompanyStatus.do",
                    {cid: company.cid, status: company.status},
                    function (data) {
                        $("#companyDataGrid").datagrid("reload");

                        $.messager.alert("温馨提示", data.msg, "info")
                    }
                )
            }

        })


    }


    <%--    禁用启用--%>

    function changeCompanyStatus() {
        var rows = $("#companyDataGrid").datagrid("getChecked");
        if (rows.length == 0) {
            $.messager.alert("温馨提示", "请选择一家公司", "warning");
            return false;
        }
        var company = rows[0];
        $.messager.confirm("温馨提示", "是否确认改变状态", function (r) {
            if (r) {
                $.post("company/changeCompanyStatus.do",
                    {cid: company.cid, status: company.status},
                    function (data) {
                        $("#companyDataGrid").datagrid("reload");

                        $.messager.alert("温馨提示", data.msg, "info")
                    }
                )
            }

        })


    }


    function getAllThePlanner() {
        var rows = $("#companyDataGrid").datagrid("getChecked");
        if (rows.length == 0) {
            $.messager.alert("温馨提示", "请选择一家公司", "warning");
            return false;
        }
        $("#plannerWindow").window({
            title: "策划师表",
            closed: false
        });


        $('#plannerDatagrid').datagrid({
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

            //请求地址
            url: 'planner/selectAllPlanner.do?cid=' + rows[0].cid,
            columns: [[
                {field: 'nid', title: "编号"},
                {field: 'nname', title: '婚庆公司名称', width: 100},

                {field: 'nphone', title: '法人手机', width: 100},

                {
                    field: 'addtime', title: "开通时间", width: 100, formatter: function (value, row, index) {
                        console.log(value)
                        return value.year + '-' + value.monthValue + '-' + value.dayOfMonth
                    }
                },
                {field: 'ordernumber', title: '订单数量', width: 100},

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

    }


    function openCompanyWindow() {
        $("#companyWindow").window({
            title: "新增婚庆公司",
            closed: false

        })

    }


    function addCompanyWindow() {
        var rows = $("#companyDataGrid").datagrid("getChecked");
        if (rows.length == 0) {
            $.messager.alert("温馨提示", "请选择一家公司", "warning");
            return false;
        }
        $("#companyWindow").window({
            title: "修改婚庆公司",
            closed: false
        });
        var company = rows[0];
        company.cpwd1 = company.cpwd;

        $("#companyForm").form("load", company);


    }


    function saveOrUpdateCompany() {
        $("#companyForm").form('submit', {
            url: "company/saveOrUpdate.do",
            onsubmit: function () {
                return $("#companyForm").form("validate");
            },
            success: function (data) {
                //    重置表单$("#companyForm").form
                $("#companyForm").form("reset");
                //    关闭window
                $("#companyWindow").window("close");
                //    刷新数据
                $("#companyDataGrid").datagrid("load");

                //    回显结果
                $.messager.alert("温馨提示", JSON.parse(data).msg, "info")

            },
        })
    }


    $('#companyDataGrid').datagrid({
        //分页条
        pagination: true,
        toolbar: "#header",
        header: "#hostTb",
        // 选择时不会直接选中，需要点击复选框才行
        checkOnSelect: false,
        //可多选
        selectOnCheck: true,
        /*选中是颜色改变，只有一个改变*/
        singleSelect: true,
        //有条纹的
        striped: true,

        //请求地址
        url: 'company/companyPage.do',
        columns: [[
            {field: 'cid', checkbox: true},

            {field: 'cname', title: '婚庆公司名称', width: 100},
            {field: 'ceo', title: '公司法人', width: 100},
            {field: 'cphone', title: '法人手机', width: 100},
            {field: 'cmail', title: '邮箱', width: 100},
            {
                field: 'starttime', title: "开通时间", width: 100, formatter: function (value, row, index) {
                    console.log(value)
                    return value.year + '-' + value.monthValue + '-' + value.dayOfMonth
                }
            },
            {field: 'ordernumber', title: '订单数量', width: 100},

            {
                field: 'status', title: '状态', width: 100, formatter: function (value, row, index) {
                    if (value == 0) {
                        return "<span style=\"color:orangered\">未审核</span>";
                    } else if (value == 1) {
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
