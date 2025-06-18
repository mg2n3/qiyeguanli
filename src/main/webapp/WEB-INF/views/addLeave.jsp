<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>请假申请</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="assets/css/styles.css">
    <!-- 谷歌字体 -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <!-- 引入Quill CSS -->
    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">

    <style>
        /* 基础样式 */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #F5F5F5;
            margin: 0;
            padding: 20px;
        }
        .content {
            max-width: 800px; /* 限制最大宽度 */
            margin: 40px auto;
            background-color: #FFF;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .left-panel {
            display: flex;
            flex-direction: column;
            justify-content: center; /* 垂直居中 */
        }
        h1, .editor-title {
            color: #0C5DF4;
            text-align: center;
            margin-bottom: 20px; /* 增加底部间距 */
        }
        .form-group {
            margin-bottom: 15px;
            text-align: center; /* 使表单元素居中 */
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input[type="text"],
        .form-group select,
        .form-group input[type="date"],
        .form-group input[type="datetime-local"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box; /* 使padding不影响宽度 */
        }
        .date-group {
            display: flex;
            justify-content: space-between;
        }
        .date-group .form-group {
            flex: 1;
            text-align: left; /* 左对齐 */
        }
        .add-button {
            background-color: #0C5DF4;
            color: #FFF;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        .add-button:hover {
            background-color: #0b4c9d;
        }
        .back-button {
            background-color: #ccc;
            color: #FFF;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
            margin-bottom: 20px;
        }
        .back-button:hover {
            background-color: #aaa;
        }
    </style>
</head>
<body>
<div class="content">
    <div class="left-panel">
        <div class="form-group">
            <h1>请假申请</h1>
            <form action="${pageContext.request.contextPath}/leave/doAddLeave" method="post">
                <input type="hidden" id="employeeId" name="employeeId" value="${employee.employeeId}">
                <div class="form-group">
                    <label for="leaveType">请假类型:</label>
                    <select id="leaveType" name="leaveType" required>
                        <option value= >---请选择---</option>
                        <option value=0>病假</option>
                        <option value=1>事假</option>
                        <option value=2>年假</option>
                    </select>
                </div>
                <div class="date-group">
                    <div class="form-group">
                        <label for="startDate">请假开始时间:</label>
                        <input type="datetime-local" id="startDate" name="startDate" required>
                    </div>
                    <div class="form-group">
                        <label for="endDate">请假结束时间:</label>
                        <input type="datetime-local" id="endDate" name="endDate" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="reason">请假事由:</label>
                    <textarea id="reason" name="reason" rows="8" ></textarea>
                </div>
                <a href="${pageContext.request.contextPath}/leave/employeeLeave" class="back-button">返回请假列表</a>
                <button type="submit" class="add-button">提交申请</button>
            </form>
        </div> <!-- /.form-group -->
    </div> <!-- /.left-panel -->
</div> <!-- /.content -->

<script>
    document.querySelector('form').addEventListener('submit', function(event) {
        var startDate = new Date(document.getElementById('startDate').value);
        var endDate = new Date(document.getElementById('endDate').value);

        if (endDate <= startDate) {
            event.preventDefault();
            alert('截止日期必须大于起始时间！');
        }
    });
</script>
</body>
</html>