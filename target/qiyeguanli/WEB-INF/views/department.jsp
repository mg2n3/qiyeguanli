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
    <title>部门管理</title>
    <style>
        /*===== 谷歌字体 =====*/
        @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap");
        /*===== CSS变量 =====*/
        :root {
            --first-color: #0C5DF4;
            --bg-color: #F5F5F5;
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
            color: var(--first-color);
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
            width: 100%;
            min-height: calc(100vh - 4rem); /* 减去顶部和底部的padding */
            overflow: auto;
            display: flex;
            flex-direction: column;
            align-items: center;
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
            color: var(--white-color);
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
            color: var(--white-color);
        }

        tr:hover {
            background-color: #f1f1f1;
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
            background-color: #dc3545; /* 红色背景 */
            color: var(--white-color); /* 白色文字 */
        }

        .delete-button:hover {
            background-color: #c82333; /* 深红色背景，鼠标悬浮时 */
        }

        .edit-button {
            background-color: #28a745; /* 绿色背景 */
            color: var(--white-color); /* 白色文字 */
        }

        .edit-button:hover {
            background-color: #218838; /* 深绿色背景，鼠标悬浮时 */
        }
    </style>
</head>
<body>
<div class="content">
    <% if (request.getAttribute("departmentError") != null) { %>
    <div id="error-message"><%= request.getAttribute("departmentError") %></div>
    <% } %>
    <h1>部门管理</h1>
    <div class="header-container">
        <div class="add-button-container">
            <form action="${pageContext.request.contextPath}/department/add" method="post" class="inline-form" id="addPositionForm">
                <button type="submit" class="add-button">
                    <i class="ion-ios-add"></i> 新增部门
                </button>
            </form>
        </div>
        <div class="search-container">
            <form action="${pageContext.request.contextPath}/department/searchDepartment" method="get">
                <input type="text" name="departmentCode" placeholder="部门编码">
                <input type="text" name="departmentName" placeholder="部门名称">
                <button type="submit">查询</button>
                <button type="button" class="reset-button" onclick="resetSearch()">重置</button>
            </form>
        </div>
    </div>
    <div class="table-container">
        <table>
            <tr>
                <th>部门编号</th>
                <th>部门编码</th>
                <th>部门名称</th>
                <th>创建时间</th>
                <th>操作</th>
            </tr>
            <c:forEach var="department" items="${departmentList}" varStatus="bianhao">
                <tr>
                    <td>${bianhao.index + 1}</td>
                    <td>${department.departmentCode}</td>
                    <td>${department.departmentName}</td>
                    <td><fmt:formatDate value="${department.createTime}" pattern="yyyy年MM月dd日"/></td>
                    <td>
                        <form action="${pageContext.request.contextPath}/department/updateDepartment?departmentId=${department.departmentId}" method="post" class="inline-form">
                            <button type="submit" class="edit-button">修改</button>
                        </form>
                        <form action="${pageContext.request.contextPath}/department/deleteDepartment?departmentId=${department.departmentId}" method="post" class="inline-form" onsubmit="return confirmDelete();">
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
        var confirmMessage = "确定要删除该部门吗？";
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