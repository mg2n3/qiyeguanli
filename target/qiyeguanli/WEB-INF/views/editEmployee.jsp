<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑员工</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <style>
        .sign-up-form {
            width: 400px;
            margin: 50px auto;
            padding: 40px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }

        .sign-up-form .title {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
        }

        .input-field {
            position: relative;
            margin-bottom: 20px;
        }

        .input-field i {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
        }

        .input-field input, .input-field select {
            width: 100%;
            padding: 10px 10px 10px 35px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .input-field input:focus, .input-field select:focus {
            border-color: #0C5DF4;
        }

        .btn, .add-button {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: #0C5DF4;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 10px;
        }

        .add-button {
            background-color: #f4f4f4;
            color: #333;
        }

        .add-button:hover {
            background-color: #eaeaea;
        }

        .btn:hover {
            background-color: #0B4B9A;
        }

        .action-buttons {
            text-align: center;
        }

        .input-field select {
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            background: url('data:image/svg+xml;utf8,<svg fill="%23666" height="30" viewBox="0 0 24 24" width="30" xmlns="http://www.w3.org/2000/svg"><path  d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>') no-repeat right 10px center;
            background-size: 15px;
        }

        @-moz-document url-prefix() {
            .input-field select {
                background: none;
            }
        }
    </style>
</head>
<body>
<form action="${pageContext.request.contextPath}/employee/doUpdateEmployee" method="post" class="sign-up-form" onsubmit="return validateForm()">
    <h2 class="title">编辑员工</h2>
    <input type="hidden" id="employeeId" name="employeeId" value="${employee.employeeId}">
    <div class="input-field">
        <i class="fas fa-user"></i>
        <input type="text" id="employeeName" name="employeeName" placeholder="员工姓名" required value="${employee.employeeName}">
    </div>
    <div class="input-field">
        <i class="fas fa-phone"></i>
        <input type="text" id="phone" name="phone" placeholder="电话" value="${employee.phone}">
    </div>
    <div class="input-field">
        <i class="fas fa-building"></i>
        <select id="department" name="departmentId" required>
            <option value="">请选择部门</option>
            <c:forEach items="${departmentList}" var="department">
                <option value="${department.departmentId}" ${employee.departmentId == department.departmentId ? 'selected' : ''}>${department.departmentName}</option>
            </c:forEach>
        </select>
    </div>
    <div class="input-field">
        <i class="fas fa-calendar-alt"></i>
        <input type="date" id="hireDate" name="hireDate" value="<fmt:formatDate value='${employee.hireDate}' pattern='yyyy-MM-dd'/>">
    </div>
<%--    <div class="input-field">--%>
<%--        <i class="fas fa-toggle-on"></i>--%>
<%--        <select id="status" name="status" required>--%>
<%--            <option value="">请选择状态</option>--%>
<%--            <option value="1" ${employee.status == 1 ? 'selected' : ''}>正常</option>--%>
<%--            <option value="0" ${employee.status == 0 ? 'selected' : ''}>停用</option>--%>
<%--        </select>--%>
<%--    </div>--%>
    <div class="input-field">
        <i class="fas fa-briefcase"></i>
        <select id="position" name="positionId" required>
            <option value="">请选择岗位</option>
            <c:forEach items="${positionList}" var="position">
                <option value="${position.positionId}" ${employee.positionId == position.positionId ? 'selected' : ''}>${position.positionName}</option>
            </c:forEach>
        </select>
    </div>
    <div class="input-field">
        <i class="fas fa-envelope"></i>
        <input type="email" id="email" name="email" placeholder="邮箱" required value="${employee.email}">
    </div>
    <div class="action-buttons">
        <input type="submit" class="btn" value="更 新" />
        <button type="button" class="add-button" onclick="historyBack()">返回</button>
    </div>
</form>

<script>
    function historyBack() {
        window.history.back();
    }

    function validateForm() {
        // 在这里添加表单验证逻辑
        // 如果验证失败，返回 false 阻止表单提交
        return true;
    }
</script>

</body>
</html>