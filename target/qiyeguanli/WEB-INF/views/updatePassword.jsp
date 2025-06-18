<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>更改密码</title>
    <link rel="stylesheet" href="styles.css">
</head>
<style>
    /* 定义表单容器的样式 */
    .password-change-container {
        width: 300px;
        margin: 50px auto;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        background-color: #f9f9f9;
    }

    /* 定义表单组的样式 */
    .form-group {
        margin-bottom: 15px;
    }

    /* 定义标签的样式 */
    label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }

    /* 定义输入框的样式 */
    input[type="password"] {
        width: 100%;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }

    /* 定义提交按钮的样式 */
    .submit-button {
        width: 100%;
        padding: 10px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .submit-button:hover {
        background-color: #0056b3;
    }
</style>
<body>
<% if (request.getAttribute("Message") != null) { %>
<script>
    window.onload = function () {
        alert('<%= request.getAttribute("Message") %>');
    };
</script>
<% } %>
<div class="password-change-container">
    <h2>更改密码</h2>
    <form action="${pageContext.request.contextPath}/user/doUpdatePassword" method="post">
        <div class="form-group">
            <label for="currentPassword">当前密码:</label>
            <input type="password" id="currentPassword" name="currentPassword" minlength="6" required>
        </div>
        <div class="form-group">
            <label for="newPassword">新密码:</label>
            <input type="password" id="newPassword" name="newPassword" minlength="6" required>
        </div>
        <div class="form-group">
            <label for="confirmPassword">确认新密码:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" minlength="6" required>
        </div>
        <button type="submit" class="submit-button">提交</button>
    </form>
</div>
</body>
</html>