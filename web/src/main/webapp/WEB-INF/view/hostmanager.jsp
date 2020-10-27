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
<table id="hostDataGrid"></table>


<div id="hostTb" style="padding:2px 5px;">
    <form id="hostSearchForm" action="host/list.do" method="post">
        <input class="easyui-textbox" name="hname" prompt="请输入姓名(可不写)" style="width:110px">
        <select data-options="editable:false," class="easyui-combobox" name="status" panelHeight="auto"
                style="width:100px">
            <option value="">状态</option>
            <option value="0">禁用</option>
            <option value="1">正常</option>
        </select>
        <select data-options="editable:false" class="easyui-combobox" name="strong" panelHeight="auto"
                style="width:100px">
            <option value="">权重</option>
            <option value="0">权重降序</option>
            <option value="1">权重升序</option>
        </select>
        <select data-options="editable:false" class="easyui-combobox" name="ordernumber" panelHeight="auto"
                style="width:120px">
            <option value="">订单排序</option>
            <option value="0">订单量降序</option>
            <option value="1">订单量升序</option>
        </select>
        <select data-options="editable:false" class="easyui-combobox" name="hpstar" panelHeight="auto"
                style="width:100px">
            <option value="">星推荐</option>
            <option value="1">是</option>
            <option value="0">否</option>
        </select>
        <select data-options="editable:false" class="easyui-combobox" name="hpdiscount" panelHeight="auto"
                style="width:100px">
            <option value="">折扣</option>
            <option value="9">9折</option>
            <option value="8">8折</option>
            <option value="7">7折</option>
            <option value="6">6折</option>
        </select>
        <a href="javascript:void(0);" onclick="hostSearch();" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
    </form>
</div>

<div id="header">
    <a class="easyui-linkbutton" onclick="openHostWindow()" data-options="iconCls:'icon-add',plain:true">添加</a>
    <a class="easyui-linkbutton" onclick="hostPowerSeting()" data-options="iconCls:'icon-tip',plain:true">权限设置</a>
    <a id="hostPowerSet" class="easyui-linkbutton" onclick="chanageHostStatus()" data-options="iconCls:'icon-lock',plain:true">启用/禁用</a>
</div>

<%--新增主持人对话框--%>
<div id="hostWindow" data-options="closed:true" title="新增主持人" class="easyui-window"
     style="width: 400px;padding: 30px 30px">
    <form class="easyui-form" id="hostForm" method="post">
        <div style="width: 100%">
            <input required data-options="label:'姓名'" style="width: 100%" class="easyui-textbox" name="hname">
        </div>
        <div style="margin-top: 30px;width: 100%">
            <input required data-options="label:'手机号'" style="width: 100%" class="easyui-textbox" name="hphone">
        </div>

        <div style="margin-top: 30px;width: 100%">
            <input required data-options="label:'密码',showEye:false" style="width: 100%" class="easyui-passwordbox"
                   name="hpwd">
        </div>
        <div style="margin-top: 30px;width: 100%">
            <a onclick="insertHost();" href="javascript:void(0)" style="width: 100%" class="easyui-linkbutton">提交</a>
        </div>
    </form>
</div>


<%--主持人权限设置窗口--%>
<div id="hostPowerWindow" data-options="modal:true,closed:true" class="easyui-window" style="height: 300px;width: 500px;padding: 30px 30px">
    <form id="hostPowerForm" method="post" >
        <%--隐藏域，打开窗口将选中主持人id设置--%>
        <input id="hostids" type="hidden" name="hostids">

        <div style="width: 90%">
            <label style="margin-right: 20px">星推荐&nbsp;&nbsp;&nbsp;</label>
            <input class="easyui-radiobutton" data-options="labelWidth:40,labelPosition:'after'" name="hpstar" value="1" label="是">
            <input class="easyui-radiobutton" data-options="labelWidth:40,labelPosition:'after'" name="hpstar" value="0" label="否">
        </div>
        <div style="margin-top: 20px;width: 90%">
            <label style="margin-right: 20px">星推荐有效期</label>
            <input name="hpstartBegindate" class="easyui-datebox" style="width: 30%">-
            <input name="hpstarEnddate" class="easyui-datebox" style="width: 30%">
        </div>

        <div style="margin-top: 20px;width: 90%">
            <label style="margin-right: 20px">自添订单</label>
            <input class="easyui-radiobutton" data-options="labelWidth:60,labelPosition:'after'" name="hpOrderPower" value="1" label="允许">
            <input class="easyui-radiobutton" data-options="labelWidth:60,labelPosition:'after'" name="hpOrderPower" value="0" label="不允许">
        </div>
        <div style="margin-top: 20px;width: 90%">
            <label style="margin-right: 20px">星推荐有时间</label>
            <input data-options="showSeconds:true,min:'08:30:00',max:'18:00:00'" value="08:30:00"  name="hpstarBegintime"  class="easyui-timespinner" style="width: 30%">-
            <input data-options="showSeconds:true,max:'18:00:00'" value="18:00:00"  name="hpstarEndtime" class="easyui-timespinner" style="width: 30%">
        </div>
        <div style="margin-top: 20px;width: 80%">
            <input required data-options="label:'折扣'" style="width: 100%" class="easyui-textbox" name="hpdiscount">
        </div>
        <div style="margin-top: 20px;width: 90%">
            <label style="margin-right: 20px">折扣时间</label>
            <input name="hpDisStarttime" class="easyui-datebox" style="width: 30%">-
            <input name="hpDisEndtime" class="easyui-datebox" style="width: 30%">
        </div>
        <div style="margin-top: 20px;width: 80%">
            <input required data-options="label:'价格'" style="width: 100%" class="easyui-textbox" name="hpprice">
        </div>
        <div style="margin-top: 20px;width: 80%">
            <input required data-options="label:'管理费'" style="width: 100%" class="easyui-textbox" name="hpcosts">
        </div>

        <div style="margin-top: 20px;width: 90%">
            <a onclick="hostPowerSet();" href="javascript:void(0)" style="width: 100%" class="easyui-linkbutton" >提交</a>
        </div>
    </form>
</div>






<script>
    // 权限修改
function hostPowerSeting() {

    var rows = $("#hostDataGrid").datagrid("getChecked");
    if(rows.length==0){
        $.messager.alert("温馨提示","请至少选择一行","info");
        return false;
    }
    var hnames=[];
    var hids=[];
    $.each(rows,function (index,host) {
        hnames.push(host.hname);
        hids.push(host.hid);
    })
    $("#hostids").val(hids.toString())

    $("#hostPowerWindow").window({
        title:hnames.toString()+"设置权限",
        closed:false

    });
}
function hostPowerSet() {
    //注意，这里在提交数据的时候，我们前端页面的数据和后台页面数据 的数据类型不匹配们就是字符串类型的时间
    //而后台是localdate类型，不能直接进行转换，需要给实体类当中的时间类型数据给注解精选转化
    //之后我们还需要在springmvc.xml中添加数据类型的转换
    $("#hostPowerForm").form('submit',{
        url:"hostPower/hostPowerSet.do",
        onsubmit:function () {
            return $("#hostPowerForm").form('validate')
        },
        success:function (data) {
            var jsonData=JSON.parse(data);
            //1.表单重置
            $("#hostPowerForm").form("reset");
            //2.关闭表单
            $("#hostPowerWindow").window("close");
            //重载datagrid表单
            $("#hostDataGrid").datagrid("load");
            //弹框显示结果
            $.messager.alert("温馨提示",jsonData.msg,"info")
        }

    })

}



















<%--    启用禁用状态修改--%>
function chanageHostStatus() {

    var rows= $("#hostDataGrid").datagrid('getChecked');

    if (rows.length == 0) {
        $.messager.alert("温馨提示", "至少选中一行数据", 'warning');
        return false;
    }
    if (rows.length > 1) {
        $.messager.alert("温馨提示", "每次操作一个主持人", 'warning');
        return false;
    }
    var row=rows[0];
    $.ajax({
        type:"post",
        url:"host/chanageHostStatus.do",
        data:"hid="+row.hid+"&status="+row.status,
        success:function (data) {

            $.messager.alert("温馨提示",data.msg,'info');


            $("#hostDataGrid").datagrid("reload");
        },
        async: true,
        processData: false,

    })

}



    function hostSearch() {
        var formData = $("#hostSearchForm").serializeJSON();
        console.log(formData)
        //这时当我们是对数据进行筛选时这时只需要对之前的分页查询精选再次加载即可，load方法
        $("#hostDataGrid").datagrid('load', formData)
    }

    //打开添加host的页面
    function  openHostWindow() {

        $("#hostWindow").window('open');

    }
    //增加js的用户
    function insertHost() {
        $("#hostForm").form('submit',{
            url:"host/insertHost.do",
            onsubmit:function () {
                return $(this).form('validate');
            },
            success:function (data) {
                console.log(data)
                var obj= JSON.parse(data)
                console.log(obj)
                $.messager.alert("温馨提示",obj.msg,'info');
                $("#hostForm").form('reset');
                $("#hostWindow").window('close');
                $("#hostDataGrid").datagrid("reload");
            }
        })

    }



    function changeHostStrong(object,hid){
        var strong=$(object).val()
            $.ajax({
                type:"post",
                url:"host/changeStrong.do",
                data:"strong="+strong+"&hid="+hid,
                success:function (data) {
                    $.messager.alert("温馨提示",data.msg,'info');
                    $("#hostDataGrid").datagrid("reload");
                }
            })

    }


    $('#hostDataGrid').datagrid({
        //分页条
        pagination: true,
        toolbar: "#header",
        header: "#hostTb",
        // 选择时不会直接选中，需要点击复选框才行
        checkOnSelect: false,
        //可多选
        selectOnCheck: false,
        /*选中是颜色改变，只有一个改变*/
        singleSelect: true,
        //有条纹的
        striped: true,

        //请求地址
        url: 'host/selectPage.do',
        columns: [[
            {field: 'hid', title: '选中', width: 100, checkbox: true},
            {
                field: 'strong', title: '权重', width: 100, formatter: function (value, row, index) {
                    return '<input onchange="changeHostStrong(this,'+row.hid+');" style="width:50px" value='+value+'>';
                    // return '<input onchange="changeHostStrong(this,' + row.hid + ');" style="width: 100%" value="' + value + '">';
                }
            },
            {field: 'hname', title: '主持人姓名', width: 100},
            {field: 'hphone', title: '主持人电话', width: 100},
            {
                field: 'starttime', title: '注册时间', width: 100, formatter: function (value, row, index) {
                    console.log(value)
                    return value.year + '-' + value.monthValue + '-' + value.dayOfMonth
                }
            },
            {
                field: 'status', title: '状态', width: 100, formatter: function (value, row, index) {
                    return value == 0 ? "<span style=\"color:#ff0000\">禁用</span>" : "<span style=\"color:#008000\">启用</span>"
                }
            },
            {field: 'ordernumber', title: '订单数量', width: 100},
            {field: 'hprice', title: '价格', width: 100},
            {field: 'hpdiscount', title: '折扣', width: 100},
            {
                field: 'hpstar', title: '是否星推', width: 100, formatter: function (value, row, index) {
                    return value == 0 ? "<span style=\"color:red\">否</span>" : "<span style=\"color:green\">是</span>"
                }
            },


        ]]
    });
</script>
</body>
</html>
