<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>请假列表</title>
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

        /* 批准按钮样式 */
        .approve-button {
            padding: 8px 16px;
            background-color: #28a745; /* 绿色背景 */
            color: var(--white-color); /* 白色文字 */
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-weight: bold;
        }

        .approve-button:hover {
            background-color: #218838; /* 深绿色背景，鼠标悬浮时 */
        }

        /* 拒绝按钮样式 */
        .reject-button {
            padding: 8px 16px;
            background-color: #dc3545; /* 红色背景 */
            color: var(--white-color); /* 白色文字 */
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-weight: bold;
        }

        .reject-button:hover {
            background-color: #c82333; /* 深红色背景，鼠标悬浮时 */
        }

        /* 已批准文本样式 */
        .approved-text {
            padding: 8px 16px;
            background-color: #d4edda; /* 灰色背景 */
            color: var(--white-color); /* 白色文字 */
            border-radius: 5px;
            font-weight: bold;
        }

        /* 已拒绝文本样式 */
        .rejected-text {
            padding: 8px 16px;
            background-color: #f8d7da; /* 灰色背景 */
            color: var(--white-color); /* 白色文字 */
            border-radius: 5px;
            font-weight: bold;
        }
        .detail-button {
            padding: 8px 16px;
            background-color: #007bff; /* 蓝色背景 */
            color: var(--white-color); /* 白色文字 */
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-weight: bold;
        }

        .detail-button:hover {
            background-color: #0056b3; /* 深蓝色背景，鼠标悬浮时 */
        }

    </style>
</head>
<body>
<div class="content">
    <% if (request.getAttribute("leaveError") != null) { %>
    <div id="error-message"><%= request.getAttribute("leaveError") %></div>
    <% } %>
    <h1>历史请假记录</h1>

    <a href="${pageContext.request.contextPath}/leave/employeeLeave" class="back-button">返回</a>

    <div class="table-container">
        <table>
            <tr>
                <th>编号</th>
                <th>请假类型</th>
                <th>请假开始时间</th>
                <th>请假结束时间</th>
                <th>操作</th>
            </tr>
            <c:forEach var="leave" items="${leaveList}" varStatus="bianhao">
                <tr>
                    <td>${bianhao.index + 1}</td>
                    <td>
                        <c:choose>
                            <c:when test="${leave.leaveType == 0}">病假</c:when>
                            <c:when test="${leave.leaveType == 1}">事假</c:when>
                            <c:when test="${leave.leaveType == 2}">年假</c:when>
                        </c:choose>
                    </td>
                    <td><fmt:formatDate value="${leave.startDate}" pattern="yyyy年MM月dd日 HH时mm分"/></td>
                    <td><fmt:formatDate value="${leave.endDate}" pattern="yyyy年MM月dd日 HH时mm分"/></td>
                    <td>
                        <form action="${pageContext.request.contextPath}/leave/detailLeave?leaveId=${leave.leaveId}" method="post" class="inline-form">
                            <button type="submit" class="detail-button">详情</button>
                        </form>
                        <!-- 如果是未审核状态，显示通过和拒绝按钮 -->
                        <c:if test="${leave.status == 0 }">
                            <form action="${pageContext.request.contextPath}/leave/delete?leaveId=${leave.leaveId}" method="post" class="inline-form" onsubmit="return confirmDelete();">
                                <button type="submit" class="approve-button">取消申请</button>
                            </form>

                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
<script>
    function confirmDelete() {
        var confirmMessage = "确定要取消申请吗？";
        return confirm(confirmMessage);
    }
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