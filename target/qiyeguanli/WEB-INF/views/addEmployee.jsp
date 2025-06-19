<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加员工</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <style>
        .sign-up-form {
            width: 600px;
            margin: 50px auto;
            padding: 40px;
            /* border: 1px solid #ccc; */
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            background-color: #13131397;

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
            border-color: #e8e9eb;
        }

        .btn, .add-button {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: #363739;
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
            background-color: #61738a;
        }
        .box{
            display: flex;
            background-color: #b8b6b3a5;
        }

        .action-buttons {
            text-align: center;

        }
        .action-buttons button{
            width: 200px;
            margin-left: 300px;
        }

        .input-field select {
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            background: url('data:image/svg+xml;utf8,<svg fill="%23666" height="30" viewBox="0 0 24 24" width="30" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>') no-repeat right 10px center;
            background-size: 15px;
        }
        .boimg{
            width: 10px;
        }
        .tj{
            width: 200px;
            border-radius: 10px;
            transform: translateY(51px)translateX(50px);
        }

        @-moz-document url-prefix() {
            .input-field select {
                background: none;
            }
        }
    </style>
</head>
<body>
<div class="box">
    <div class="boimg"><img src="<c:url value="/static/新增员工.jpg"/>"style="width: 500px;"></div>
    <form action="${pageContext.request.contextPath}/employee/addEmployee" method="post" class="sign-up-form" onsubmit="return validateForm()">
        <h2 class="title" style="color: #fff;">添加员工</h2>
        <div class="input-field">
            <i class="fas fa-user"></i>
            <input type="text" id="employeeName" name="employeeName" placeholder="员工姓名" required />
        </div>
        <div class="input-field">
            <i class="fas fa-phone"></i>
            <input type="text" id="phone" name="phone" placeholder="电话" />
        </div>
        <div class="input-field">
            <i class="fas fa-building"></i>
            <select id="department" name="departmentId" required>
                <option value="">请选择部门</option>
                <c:forEach items="${departmentList}" var="department">
                    <option value="${department.departmentId}">${department.departmentName}</option>
                </c:forEach>
            </select>
        </div>
        <div class="input-field">
            <i class="fas fa-calendar-alt"></i>
            <input type="date" id="hireDate" name="hireDate" placeholder="入职日期" required />
        </div>
        <div class="input-field">
            <i class="fas fa-briefcase"></i>
            <select id="position" name="positionId" required>
                <option value="">请选择岗位</option>
                <c:forEach items="${positionList}" var="position">
                    <option value="${position.positionId}">${position.positionName}</option>
                </c:forEach>
            </select>
        </div>
        <div class="input-field">
            <i class="fas fa-envelope"></i>
            <input type="email" id="email" name="email" placeholder="邮箱" required />
        </div>
        <div class="action-buttons">
            <div class="tj"><input type="submit" class="btn" value="添 加" /></div>
            <button type="button" class="add-button" onclick="historyBack()">返回</button>
        </div>
    </form>

</div>

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