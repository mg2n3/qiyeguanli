<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>薪资管理</title>
    <style>
        /* 谷歌字体 */
        @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap");

        /* CSS变量 */
        :root {
            --first-color: #0C5DF4;
            --bg-color: #F5F5F5;
            --sub-color: #B6CEFC;
            --white-color: #FFF;
            --error-color: #ff0000;
            /* 字体 */
            --body-font: 'Poppins', sans-serif;
            --normal-font-size: 1rem;
            --small-font-size: .875rem;
        }

        /* 基础规定 */
        *, ::before, ::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: var(--body-font);
            font-size: var(--normal-font-size);
            background-color: var(--bg-color);
            padding: 2rem;
        }
        h1 {
            margin: 0 0 20px 0;
            text-align: center;
            color: var(--first-color);
        }
        ul {
            list-style: none;
        }
        a {
            text-decoration: none;
        }

        .content {
            width: 100%;
            min-height: calc(100vh - 4rem);
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            max-width: 1200px;
            margin-bottom: 20px;
        }

        .button-group {
            display: flex;
            gap: 10px;
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
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: var(--first-color);
            color: var(--white-color);
            font-weight: 600;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .action-button {
            padding: 6px 12px;
            background-color: var(--first-color);
            color: var(--white-color);
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-size: var(--small-font-size);
            font-weight: 500;
        }

        .edit-button {
            background-color: #28a745;
        }

        .delete-button {
            background-color: #dc3545;
        }

        .action-button:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }

        .search-form {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            background: white;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 1200px;
        }

        .search-form select, .search-form button {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-family: var(--body-font);
        }

        .search-form button {
            background-color: var(--first-color);
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .search-form button:hover {
            background-color: #0a4bc8;
        }

        .notification {
            padding: 10px 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            width: 100%;
            max-width: 1200px;
            text-align: center;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .action-cell {
            display: flex;
            gap: 8px;
        }
    </style>
</head>
<body>
<div class="content">
    <h1>薪资管理</h1>

    <!-- 通知消息 -->
    <c:if test="${not empty success}">
        <div class="notification success">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="notification error">${error}</div>
    </c:if>

    <div class="header-section">
        <a href="${pageContext.request.contextPath}/salary/add" class="action-button">添加薪资</a>

        <!-- 搜索表单 -->
        <form class="search-form" action="${pageContext.request.contextPath}/salary/search" method="get">
            <select name="positionId">
                <option value="">所有岗位</option>
                <c:forEach var="position" items="${positionList}">
                    <option value="${position.positionId}"
                            <c:if test="${param.positionId == position.positionId}">selected</c:if>>
                            ${position.positionName}
                    </option>
                </c:forEach>
            </select>

            <select name="departmentId">
                <option value="">所有部门</option>
                <c:forEach var="department" items="${departmentList}">
                    <option value="${department.departmentId}"
                            <c:if test="${param.departmentId == department.departmentId}">selected</c:if>>
                            ${department.departmentName}
                    </option>
                </c:forEach>
            </select>


            <button type="submit">搜索</button>
        </form>
    </div>

    <div class="table-container">
        <table>
            <tr>
                <th>薪资ID</th>
                <th>岗位ID</th>
                <th>部门ID</th>
                <th>加班薪资</th>
                <th>考勤薪资</th>
                <th>创建时间</th>
                <th>操作</th>
            </tr>
            <c:forEach var="salary" items="${salaryList}">
                <tr>
                    <td>${salary.salaryId}</td>
                    <td>${salary.positionId}</td>
                    <td>${salary.departmentId}</td>
                    <td>${salary.overtimeSalary}</td>
                    <td>${salary.attendanceSalary}</td>
                    <td>
                        <!-- 使用日期格式化 -->
                        <fmt:formatDate value="${salary.createTimeAsDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/salary/edit/${salary.salaryId}" class="edit-button">编辑</a>
                        <form action="${pageContext.request.contextPath}/salary/delete/${salary.salaryId}" method="post" style="display:inline;">
                            <button type="submit" class="delete-button" onclick="return confirm('确定删除吗？')">删除</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
</body>
</html>
