<%--
  Created by IntelliJ IDEA.
  User: lc
  Date: 2018/10/1
  Time: 10:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <title>员工列表页面</title>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap/css/bootstrap.min.css"/>
    <script src="${APP_PATH}/static/js/jquery.min.js"></script>
    <script src="${APP_PATH}/static/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>

<%--员工修改模态框--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<%--员工添加模态框--%>
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-2 col-md-offset-9">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <%--显示表格信息--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all">
                        </th>
                        <th>#</th>
                        <th>empName</th>
                        <th>empGender</th>
                        <th>empEmail</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <div class="col-md-6" id="page_info_area">
        </div>
        <div class="col-md-6" id="page_nav_area">
        </div>
    </div>
</div>

<script type="text/javascript">
    var totalRecord,currentPage
    $(function () {
        // 默认打开首页跳转到pn=1
        to_page(1)
    })
    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                // console.log(result)
                // 1.解析并显示员工信息
                build_emps_table(result)
                // 2.解析并显示分页信息
                build_page_info(result)
                build_page_nav(result)
            }
        })
    }
    function build_emps_table(result) {
        $("#emps_table tbody").empty()
        var emps = result.extend.pageInfo.list
        $.each(emps, function (index, item) {
            var checkBoxId = $("<td><input type='checkbox' class='check_item'></td>")
            var empIdTd = $("<td></td>").append(item.empId)
            var empNameTd = $("<td></td>").append(item.empName)
            var genderTd = $("<td></td>").append(item.gender == "M" ? "男" : "女")
            var emailTd = $("<td></td>").append(item.email)
            var deptNameTd = $("<td></td>").append(item.department.deptName)
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append(
                $("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑")
            // 为编辑按钮添加属性，属性值为当前员工id
            editBtn.attr("edit-id",item.empId)
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append(
                $("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除")
            // 为删除按钮添加属性，属性值为当前员工id
            delBtn.attr("del-id",item.empId)
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn)
            $("<tr></tr>").append(checkBoxId).append(empIdTd).append(empNameTd).append(genderTd).append(emailTd).append(deptNameTd).append(btnTd)
                .appendTo("#emps_table tbody")
        })
    }
    function build_page_info(result) {
        $("#page_info_area").empty()
        $("#page_info_area").append($("<p></p>").append("当前" + result.extend.pageInfo.pageNum + "页，总" + result.extend.pageInfo.pages
            + "页，总" + result.extend.pageInfo.total + "条记录"))
        totalRecord = result.extend.pageInfo.total
        currentPage = result.extend.pageInfo.pageNum
    }
    function build_page_nav(result) {
        $("#page_nav_area").empty()
        var ul = $("<li></li>").addClass("pagination")
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"))
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"))
        // 如果是第一页，则不能点击首页和上一页
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled")
            prePageLi.addClass("disabled")
        }else { // 如果能点击添加点击事件
            firstPageLi.click(function () {
                to_page(1)
            })
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1)
            })
        }
        ul.append(firstPageLi).append(prePageLi)
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"))
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"))
        // 如果是最后一页，则不能点击末页和下一页
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled")
            lastPageLi.addClass("disabled")
        }else { // 如果能点击，那么添加点击事件
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1)
            })
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages)
            })
        }
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item))
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active")
            }
            // 给数字按钮添加点击事件
            numLi.click(function () {
                // 传入页码
                to_page(item)
            })
            ul.append(numLi)
        })
        ul.append(nextPageLi).append(lastPageLi)
        var navEle = $("<nav></nav>").append(ul)
        $("#page_nav_area").append(navEle)
    }
    // 重置表单方法
    function reset_form(ele) {
        // 重置表单数据
        $(ele)[0].reset()
        // 重置表单样式
        $(ele).find("*").removeClass("has-error has-success")
        $(ele).find(".help-block").text("")
    }
    $("#emp_add_modal_btn").click(function () {
        // 重置表单,包括清空表单数据以及表单样式
        reset_form("#empAddModal form")
        //$("#empAddModal form")[0].reset()
        // 发送ajax请求查出并显示部门信息
        getDepts("#dept_add_select")
        $("#empAddModal").modal({
            backdrop: "static"
        })
    })
    function getDepts(ele) {
        // 这里要清空之前的，否则每次点击就会循环一次部门信息
        $(ele).empty()
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId)
                    optionEle.appendTo(ele)
                })
            }
        })
    }
    // 校验表单提交数据方法
    function validate_add_form() {
        // 拿到要校验的数据，使用正则表达式校验
        var empName = $("#empName_add_input").val()
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/
        if (!regName.test(empName)){
            // alert("用户名是2-5位或字符串6-16位")
            show_validate_msg("#empName_add_input","error","用户名是2-5位或字符串6-16位")
            return false
        }else{
            show_validate_msg("#empName_add_input","success","")
        }
        var email = $("#email_add_input").val()
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
        if (!regEmail.test(email)){
            // alert("邮箱格式不正确")
            show_validate_msg("#email_add_input","error","邮箱格式不正确")
            return false
        }else{
            show_validate_msg("#email_add_input","success","")
        }
        return true
    }
    function show_validate_msg(ele,status,msg){
        // 清空之前添加的类
        $(ele).parent().removeClass("has-success has-error")
        $(ele).next("span").text("")
        if("success" == status){
            $(ele).parent().addClass("has-success")
            $(ele).next("span").text(msg)
        }else if("error" == status){
            $(ele).parent().addClass("has-error")
            $(ele).next("span").text(msg)
        }
    }
    // 校验用户名是否可用
    // 因为这里是change() 有改动才执行下面的方法，所以如果不重置表单，就不会执行验证用户名是否重复，而如果上一次填充成功，
    // 就会ajax-va=success，那么就会依次执行提交，所以要重置表单
    $("#empName_add_input").change(function () {
        // 发送Ajax校验用户名是否重复
        var empName = this.value
        $.ajax({
            url: "${APP_PATH}/checkUser",
            data: "empName=" + empName,
            type: "POST",
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg("#empName_add_input","success","用户名可用")
                    $("#emp_save_btn").attr("ajax-va","success")
                }else {
                    show_validate_msg("#empName_add_input","error",result.extend.va_msg)
                    $("#emp_save_btn").attr("ajax-va","error")
                }
            }
        })
    })

    $("#emp_save_btn").click(function () {
        // 校验表单提交数据
        if(!validate_add_form()){
            return false
        }
        // 判断用户名是否重复，如果重复给当前按钮添加一个属性，然后如果有这个属性直接return一个false
        if ($(this).attr("ajax-va") == "error") {
            return false
        }
        $.ajax({
            url: "${APP_PATH}/emp",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success: function (result) {
                if (result.code == 100) {
                    // 员工保存成功，自动关闭模态框，来到最后一页
                    $("#empAddModal").modal("hide")
                    to_page(totalRecord)
                }else {
                    if (undefined == result.extend.errorFields.empName){
                        // 显示名称错误信息
                        show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName)
                    }
                    if (undefined == result.extend.errorFields.email) {
                        // 显示邮箱错误信息
                        show_validate_msg("#email_add_input","error",result.extend.errorFields.email)
                    }
                }
            }
        })
    })
    // 给编辑按钮绑定弹出模态框事件
    // 这里绑定事件要使用on，不能用click，因为click不能给动态元素绑定事件，而编辑按钮是跟随ajax动态显示的
    $(document).on("click",".edit_btn",function () {
        // 查询员工显示员工信息
        getEmp($(this).attr("edit-id"))
        // 查询部门显示部门信息
        getDepts("#empUpdateModal select")
        // 弹出模态框
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"))
        $("#empUpdateModal").modal({
            backdrop: "static"
        })
    })

    // 根据id查询员工信息
    function getEmp(id) {
        $.ajax({
            url: "${APP_PATH}/emp/" + id,
            type: "GET",
            success: function (result) {
                var empData = result.extend.emp
                $("#empName_update_static").text(empData.empName)
                $("#email_update_input").val(empData.email)
                $("#empUpdateModal input[name=gender]").val([empData.gender])
                $("#empUpdateModal select").val([empData.dId])
            }
        })
    }
    // 点击更新员工信息
    $("#emp_update_btn").click(function () {
        // 校验邮箱
        var email = $("#email_update_input").val()
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
        if (!regEmail.test(email)){
            // alert("邮箱格式不正确")
            show_validate_msg("#email_update_input","error","邮箱格式不正确")
            return false
        }else{
            show_validate_msg("#email_update_input","success","")
        }
        // 发送ajax请求
        $.ajax({
            url: "${APP_PATH}/emp/" + $(this).attr("edit-id"),
            type: "PUT",
            data: $("#empUpdateModal form").serialize(),
            success: function (result) {
                // 关闭对话框
                $("#empUpdateModal").modal("hide")
                // 回到本页面
                to_page(currentPage)
            }
        })
    })
    // 单个删除
    $(document).on("click",".delete_btn",function () {
        // 弹出是否确认删除模态框
        var empName = $(this).parents("tr").find("td:eq(2)").text()
        var empId = $(this).attr("del-id")
        if (confirm("确认删除【" + empName + "】的吗——？")) {
            $.ajax({
                url: "${APP_PATH}/emp/" + empId,
                type: "DELETE",
                success: function (result) {
                    to_page(currentPage)
                }
            })
        }
    })
    // 全选，全不选功能
    $("#check_all").click(function () {
        // 自定义属性获取属性值用attr，非自定义属性获取属性值用prop
        $(this).prop("checked")
        $(".check_item").prop("checked",$(this).prop("checked"))
    })
    $(document).on("click",".check_item",function () {
        var flag = $(".check_item:checked").length == $(".check_item").length
        $("#check_all").prop("checked",flag)
    })
    // 点击全部删除，批量删除
    $("#emp_delete_all_btn").click(function () {
        var empNames = ""
        var del_idstr = ""
        $.each($(".check_item:checked"),function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ","
            // 组装员工id
            del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-"
        })
        // 去除最后一个多余的逗号
        empNames = empNames.substring(0,empNames.length-1)
        del_idstr = del_idstr.substring(0,del_idstr.length-1)
        if(confirm("确认要删除【" + empNames + "】吗？")){
            // 执行Ajax请求
            $.ajax({
                url: "${APP_PATH}/emp/" + del_idstr,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg)
                    to_page(currentPage)
                }
            })
        }
    })
</script>

</body>
</html>
