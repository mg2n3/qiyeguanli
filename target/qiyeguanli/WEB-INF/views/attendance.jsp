<%--
  Created by IntelliJ IDEA.
  User: 86135
  Date: 2025/1/3
  Time: 21:08
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
    <title>考勤管理</title>
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
        .status-normal { background-color: #DFF0D8; } /* 正常 - 浅绿色 */
        .status-late { background-color: #F2DEDE; } /* 迟到 - 浅红色 */
        .status-leave-early { background-color: #D9EDF7; } /* 早退 - 浅蓝色

        /* 日期选择框样式 */
        .search-container input[type="date"] {
            width: 200px; /* 调整输入框的宽度 */
            padding: 10px 15px; /* 内边距 */
            border: 1px solid #ccc; /* 边框颜色 */
            border-radius: 5px; /* 圆角边框 */
            background-color: #fff; /* 背景颜色 */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 阴影效果 */
            font-size: 16px; /* 字体大小 */
            color: #333; /* 字体颜色 */
            transition: border-color 0.3s ease; /* 平滑过渡效果 */
        }

        .search-container input[type="date"]:focus {
            border-color: var(--first-color); /* 聚焦时边框颜色变化 */
            outline: none; /* 移除默认的聚焦轮廓 */
        }

        .search-container input[type="date"]::placeholder {
            color: #aaa; /* 占位符颜色 */
        }

        .search-container button {
            padding: 10px 20px; /* 按钮内边距 */
            background-color: var(--first-color); /* 按钮背景颜色 */
            color: var(--white-color); /* 按钮文字颜色 */
            border: none; /* 无边框 */
            border-radius: 5px; /* 圆角边框 */
            cursor: pointer; /* 鼠标指针样式 */
            transition: background-color 0.3s ease; /* 平滑过渡效果 */
        }

        .search-container button:hover {
            background-color: darken(var(--first-color), 10%); /* 鼠标悬停时背景颜色变化 */
        }

    </style>
</head>
<body>
<div class="content">
    <% if (request.getAttribute("attendanceError") != null) { %>
    <div id="error-message"><%= request.getAttribute("attendanceError") %></div>
    <% } %>
    <h1>考勤管理</h1>
    <div class="search-container">
        <form action="${pageContext.request.contextPath}/attendance/searchAttendance" method="get">
            <input type="date" name="date" placeholder="日期">
            <select name="state">
                <option value="">所有状态</option>
                <option value="0">正常</option>
                <option value="1">迟到</option>
                <option value="2">早退</option>
            </select>
            <button type="submit">查询</button>
            <button type="button" class="reset-button" onclick="resetSearch()">重置</button>
        </form>
    </div>
    <div class="table-container">
        <table>
            <tr>
                <th>编号</th>
                <th>员工姓名</th>
                <th>打卡日期</th>
                <th>上班打卡</th>
                <th>下班打卡</th>
                <th>状态</th>
            </tr>
            <c:forEach var="attendance" items="${attendanceList}" varStatus="bianhao">
                <tr>
                    <td>${bianhao.index + 1}</td>
                    <td>
                        <c:forEach var="employee" items="${employeeList}">
                            <c:if test="${employee.employeeId == attendance.employeeId}">
                                ${employee.employeeName}<br>
                            </c:if>
                        </c:forEach>
                    </td>
                    <td><fmt:formatDate value="${attendance.date}" pattern="yyyy年MM月dd日"/></td>
                    <td><fmt:formatDate value="${attendance.checkInTime}" pattern="HH时mm分"/></td>
                    <td><fmt:formatDate value="${attendance.checkOutTime}" pattern="HH时mm分"/></td>
                    <td class="${attendance.state == 0 ? 'status-normal' : (attendance.state == 1 ? 'status-late' : 'status-leave-early')}">
                        <c:choose>
                            <c:when test="${attendance.state == 0}">正常</c:when>
                            <c:when test="${attendance.state == 1}">迟到</c:when>
                            <c:when test="${attendance.state == 2}">早退</c:when>
                        </c:choose>
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
    function resetSearch() {
        document.querySelectorAll('.search-container input[type="text"], .search-container select').forEach(input => {
            input.value = '';
        });
    }
</script>
</body>
</html>
