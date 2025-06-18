<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加岗位</title>
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
            width: 300px;
            padding: 20px;
            text-align: center;
            transition: transform 0.3s ease;
        }
        .form-container:hover {
            transform: translateY(-10px);
        }
        label {
            display: block;
            margin-top: 10px;
            color: var(--first-color);
        }
        input[type="text"], button {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
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
        <h2>添加岗位</h2>
        <form action="${pageContext.request.contextPath}/position/addPosition" method="post" onsubmit="return confirmAddPosition();">
            <label for="positionName">岗位名称:</label>
            <input type="text" id="positionName" name="positionName" required><br>

            <label for="code">岗位编码:</label>
            <input type="text" id="code" name="code" required><br>

            <button type="submit" class="add-button">新增岗位</button>
            <button type="button" class="add-button" onclick="historyBack()">返回</button>
        </form>
    </div>

</div>


<script>
    function historyBack() {
        window.history.back();
    }
    function confirmAddPosition() {
        var positionName = document.getElementById('positionName').value;
        var positionCode = document.getElementById('positionCode').value;

        if (positionName.trim() === '' || positionCode.trim() === '') {
            alert("岗位名称和岗位编码不能为空，请重新输入。");
            return false; // 阻止表单提交
        }

        return confirm("确定要添加这个岗位吗？"); // 弹出确认对话框
    }
</script>
</body>
</html>