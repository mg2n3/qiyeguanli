<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑薪资</title>
    <!-- jquery -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-3.6.1.js"></script>
    <!-- layer -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layer/theme/default/layer.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/layer/layer.js"></script>
    <!-- common可删 -->
    <%--    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/common.css"/>--%>
    <%--    <script type="text/javascript" src="${pageContext.request.contextPath}/static/common.js"></script>--%>
    <!-- 引入bootstrap -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/bootstrap/css/bootstrap.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap/js/bootstrap.js"></script>
    <!-- 引入bootstrap-select -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-select/css/bootstrap-select.css"/>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/bootstrap-select/js/bootstrap-select.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/bootstrap-select/js/bootstrap-select-ext.js"></script>
    <!-- popper(新增) -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/popper.js"></script>
    <style>
        /* 谷歌字体 */
        @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap");

        /* CSS变量 */
        :root {
            --first-color: #0C5DF4;
            --bg-color: #F5F5F5;
            --sub-color: #B6CEFC;
            --white-color: #FFF;
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
        .content {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }
        .form-container {
            background-color: var(--white-color);
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            width: 400px;
            padding: 30px;
            transition: transform 0.3s ease;
        }
        .form-container:hover {
            transform: translateY(-5px);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: var(--first-color);
        }
        label {
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
            color: #333;
            font-weight: 500;
        }
        select, input[type="number"], button {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-family: var(--body-font);
            font-size: var(--normal-font-size);
        }
        button {
            background-color: var(--first-color);
            color: white;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 600;
            margin-top: 20px;
            padding: 12px;
        }
        button:hover {
            background-color: #0a4bc8;
            transform: scale(1.02);
        }
        .button-group {
            display: flex;
            gap: 10px;
        }
        .btn-back {
            background-color: #6c757d;
        }
        .btn-back:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
<div class="content">
    <div class="form-container">
        <h2>编辑薪资</h2>
        <form action="${pageContext.request.contextPath}/salary/update/${salaryDTO.salaryId}" method="post">
            <!-- 添加CSRF令牌 -->
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

            <!-- 确保有隐藏的salaryId字段 -->
            <input type="hidden" name="salaryId" value="${salaryDTO.salaryId}">

            <label for="positionId">岗位:</label>
            <select id="positionId" name="positionId" required>
                <option value="">请选择岗位</option>
                <c:forEach var="position" items="${positionList}">
                    <option value="${position.id}"
                        ${salaryDTO.positionId == position.id ? 'selected' : ''}>
                            ${position.positionName}
                    </option>
                </c:forEach>
            </select>

            <label for="departmentId">部门:</label>
            <select id="departmentId" name="departmentId" required>
                <option value="">请选择部门</option>
                <c:forEach var="department" items="${departmentList}">
                    <option value="${department.id}"
                        ${salaryDTO.departmentId == department.id ? 'selected' : ''}>
                            ${department.departmentName}
                    </option>
                </c:forEach>
            </select>

            <label for="overtimeSalary">加班薪资 (¥):</label>
            <input type="number" id="overtimeSalary" name="overtimeSalary"
                   value="${salaryDTO.overtimeSalary}" required step="0.01" min="0" placeholder="输入加班薪资">

            <label for="attendanceSalary">考勤薪资 (¥):</label>
            <input type="number" id="attendanceSalary" name="attendanceSalary"
                   value="${salaryDTO.attendanceSalary}" required step="0.01" min="0" placeholder="输入考勤薪资">

            <div class="button-group">
                <button type="submit" class="btn-update">更新薪资</button>
                <button type="button" class="btn-back" onclick="history.back()">返回</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>