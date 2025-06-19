<%--
  Created by IntelliJ IDEA.
  User: 86135
  Date: 2025/1/2
  Time: 16:38
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: 86135
  Date: 2025/1/2
  Time: 11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>员工管理</title>
    <style>
        /*===== 谷歌字体 =====*/
        @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap");
        /*===== CSS变量 =====*/
        :root {
            --first-color: #f9f1f1fa;
            --bg-color: #090909be;
            --sub-color: #B6CEFC;
            --white-color: #FFF;
            /*===== 字体 =====*/
            --body-font: 'Poppins', sans-serif;
            --normal-font-size: 1rem;
            --small-font-size: .875rem;
        }

        /*===== 基础规定 =====*/
        *, ::before, ::after {
            box-sizing: border-box;
        }
        body {
            position: relative;
            margin: 0;
            padding: 2rem;
            font-family: var(--body-font);
            font-size: var(--normal-font-size);
            background-color: var(--bg-color);
            transition: .5s;
        }
        h1 {
            margin: 0;
            text-align: center;
            color: var(--bg-color);
        }
        ul {
            margin: 0;
            padding: 0;
            list-style: none;
        }
        a {
            text-decoration: none;
        }

        .content {
            position: relative;
            margin-left: 80px;
            width: 90%;
            min-height: calc(100vh - 4rem); /* 减去顶部和底部的padding */
            overflow: auto;
            display: flex;
            flex-direction: column;
            align-items: center;
            background:url(<c:url value='/static/员工管理.jpg'/>)
        }

        .header-container {

            display: flex;
            justify-content: space-between;
            width: 100%;
            max-width: 1200px;
            margin-bottom: 20px;
            align-items: center;
        }

        .search-container {
            display: flex;
            align-items: center;
            gap: 10px; /* 添加间距 */
        }

        .search-container input[type="text"],
        .search-container select {
            width: 200px; /* 调整输入框和选择框的宽度 */
            padding: 8px 12px;
            margin-right: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .search-container button {
            padding: 8px 16px;
            background-color: var(--first-color);
            color: var(--white-color);
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .search-container button:hover {
            background-color: darken(var(--first-color), 10%);
        }

        .add-button-container {
            display: flex;
            align-items: center;
        }

        .add-button {
            padding: 8px 16px;
            background-color: var(--first-color);
            color: var(--bg-color);
            border: none;
            border-radius: 5px;
            cursor: pointer;
            display: flex;
            align-items: center;
            transition: background-color 0.3s ease;
            font-weight: bold; /* 加粗按钮文本 */
            position: relative; /* 为伪元素定位 */
            padding-left: 20px; /* 为伪元素内容预留空间 */
        }

        .add-button:hover {
            background-color: darken(var(--first-color), 10%);
        }

        .add-button::before {
            content: "+ "; /* 在按钮前添加加号符号 */
            font-weight: bold; /* 使加号符号加粗 */
            position: absolute; /* 绝对定位 */
            left: 10px; /* 距离左边的距离 */
        }

        .add-button i {
            margin-right: 5px;
            font-size: 1.2em;

        }

        .table-container {
            width: 100%;
            max-width: 1200px;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: var(--first-color);
            color: var(--bg-color);
        }

        tr:hover {
            background-color: #c5c0c0;
        }
        button{
            color:var(--bg-color);
        }

        .inline-form {
            display: inline-block;
            margin-right: 5px;
        }

        .delete-button, .edit-button {
            padding: 8px 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-weight: bold;
            margin-left: 5px; /* 添加间距 */
        }

        .delete-button {
            background-color: #dc35461b; /* 红色背景 */
            color: var(--bg-color); /* 白色文字 */
        }

        .delete-button:hover {
            background-color: #c82333; /* 深红色背景，鼠标悬浮时 */
        }

        .edit-button {
            background-color: #06431468; /* 绿色背景 */
            color: var(--bg-color);
        }

        .edit-button:hover {
            background-color: #218838; /* 深绿色背景，鼠标悬浮时 */
        }
    </style>
</head>
<body>
<div class="content">
    <!-- <% if (request.getAttribute("employeeError") != null) { %>
    <div id="error-message"><%= request.getAttribute("employeeError") %></div>
    <% } %> -->
    <h1>员工管理</h1>
    <div class="header-container">
        <div class="add-button-container">
            <form action="${pageContext.request.contextPath}/employee/add" method="post" class="inline-form" id="addPositionForm">
                <button type="submit" class="add-button">
                    <i class="ion-ios-add"></i> 新增员工
                </button>
            </form>
        </div>
        <div class="search-container">
            <form action="${pageContext.request.contextPath}/employee/searchEmployee" method="get">
                <input type="text" name="employeeName" placeholder="员工姓名">
                <input type="text" name="phone" placeholder="员工电话">
                <!-- <%--                <select name="status">--%>
<%--                    <option value="">所有状态</option>--%>
<%--                    <option value="1">正常</option>--%>
<%--                    <option value="0">停用</option>--%>
<%--                </select>--%> -->
                <button type="submit" style="color: #0f0f0f;">查询</button>
                <button type="button" class="reset-button" onclick="resetSearch()"style="color: #0f0f0f;">重置</button>
            </form>
        </div>
    </div>
    <div class="table-container">
        <table>
            <tr>
                <th>员工编号</th>
                <th>员工名称</th>
                <th>员工电话</th>
                <th>员工所属部门</th>
                <th>员工岗位</th>
                <!-- <%--                <th>状态</th>--%> -->
                <th>加入时间</th>
                <th>操作</th>
            </tr>
            <c:forEach var="employee" items="${employeeList}" varStatus="bianhao">
                <tr>
                    <td>${bianhao.index + 1}</td>
                    <td>${employee.employeeName}</td>
                    <td>${employee.phone}</td>
                    <td>
                        <c:forEach var="department" items="${departmentList}">
                            <c:if test="${department.departmentId == employee.departmentId}">
                                ${department.departmentName}<br>
                            </c:if>
                        </c:forEach>
                    </td>
                    <td>
                        <c:forEach var="position" items="${positionList}">
                            <c:if test="${position.positionId == employee.positionId}">
                                ${position.positionName}<br>
                            </c:if>
                        </c:forEach>
                    </td>
                    <!-- <%--                    <td>--%>
<%--                        <c:choose>--%>
<%--                            <c:when test="${employee.status == 0}">正常</c:when>--%>
<%--                            <c:when test="${employee.status == 1}">停用</c:when>--%>
<%--                        </c:choose>--%>
<%--                    </td>--%> -->
                    <td><fmt:formatDate value="${employee.hireDate}" pattern="yyyy年MM月dd日"/></td>
                    <td>
                        <form action="${pageContext.request.contextPath}/employee/updateEmployee?employeeId=${employee.employeeId}" method="post" class="inline-form">
                            <button type="submit" class="edit-button">修改</button>
                        </form>
                        <form action="${pageContext.request.contextPath}/employee/deleteEmployee?employeeId=${employee.employeeId}" method="post" class="inline-form" onsubmit="return confirmDelete();">
                            <button type="submit" class="delete-button">删除</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
<script>
    window.onload = function () {
        var errorMessage = document.getElementById('error-message');
        if (errorMessage) {
            alert(errorMessage.textContent);
        }
    };
    function confirmDelete() {
        var confirmMessage = "确定要删除该员工吗？";
        return confirm(confirmMessage);
    }
    function resetSearch() {
        document.querySelectorAll('.search-container input[type="text"], .search-container select').forEach(input => {
            input.value = '';
        });
    }
</script>
</body>
</html>
