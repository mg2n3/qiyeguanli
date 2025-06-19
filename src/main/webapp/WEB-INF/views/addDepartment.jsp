<%--
  Created by IntelliJ IDEA.
  User: 86135
  Date: 2025/1/2
  Time: 11:33
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
    <title>添加部门</title>
    <style>
        /* 谷歌字体 */
        @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap");

        /* CSS变量 */
        :root {
            --first-color: #f2ededbc;
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
            color: black;
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
            min-height: calc(100vh - 4rem);
            overflow: auto;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .form-container {
            background-color: var(--white-color);
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 700px;
            height: 800px;
            padding: 20px;
            text-align: center;
            transition: transform 0.3s ease;
            background: url('<c:url value="/static/添加部门.jpg"/>');
        }
        .form-container:hover {
            transform: translateY(-10px);
        }
        label {
            display: block;
            margin-top: 10px;
            color: black;
        }
        input[type="text"], button {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .box1{
            display: flex;
        }
        .box3{
            margin-top: 400px;
        }
        .box3 button{
            margin-right: 30px;

        }
        button {
            background-color: var(--first-color);
            color: var(--white-color);
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: darken(var(--first-color), 10%);
        }
    </style>
</head>
<body>
<div class="content">
    <div class="form-container">
        <h2>添加部门</h2>
        <form action="${pageContext.request.contextPath}/department/addDepartment" method="post" onsubmit="return confirmAddPosition();">
            <div class="box2">
                <div class="box1"><label for="departmentName">部门名称:</label></div>
                <div class="box1"><input type="text" id="departmentName" name="departmentName" required><br></div>
            </div>

            <div class="box2">
                <div class="box1"><label for="departmentCode">部门编码:</label></div>
                <div class="box1"><input type="text" id="departmentCode" name="departmentCode" required><br></div>
            </div>

            <div class="box3">
                <button type="submit" class="add-button" style="width: 200px;color: black;">新增部门</button>
                <button type="button" class="add-button" onclick="historyBack()" style="width: 200px;color: black;">返回</button>
            </div>
        </form>
    </div>

</div>


<script>
    function historyBack() {
        window.history.back();
    }
    function confirmAddPosition() {
        var departmentName = document.getElementById('departmentName').value;
        var departmentCode = document.getElementById('departmentCode').value;

        if (departmentName.trim() === '' || departmentCode.trim() === '') {
            alert("部门名称和部门编码不能为空，请重新输入。");
            return false; // 阻止表单提交
        }
        return confirm("确定要添加这个部门吗？"); // 弹出确认对话框
    }
</script>
</body>
</html>
