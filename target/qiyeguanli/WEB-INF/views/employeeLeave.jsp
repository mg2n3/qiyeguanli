<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>员工请假系统</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background-color: #f7f7f7;
            min-height: 100vh;
        }
        h1 {
            margin-top: 20px;
            color: #333;
            text-align: center;
        }
        .container {
            width: 90%;
            max-width: 1200px;
            display: flex;
            justify-content: space-between;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            border-radius: 8px;
            margin-top: 20px;
        }
        .card {
            flex: 1;
            background-color: #007bff;
            color: white;
            border-radius: 8px;
            padding: 30px;
            margin: 10px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            height: 300px;
        }
        .card img {
            width: 100px;
            margin-bottom: 20px;
        }
        .card h2 {
            margin: 0 0 10px 0;
            font-size: 24px;
        }
        .card p {
            margin: 0;
            font-size: 16px;
            line-height: 1.6;
        }
        .half-button {
            background-color: #0056b3;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            margin-top: 20px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s, transform 0.3s;
        }
        .half-button:hover {
            background-color: #004080;
            transform: translateY(-2px);
        }
        @media (max-width: 600px) {
            .container {
                flex-direction: column;
            }
            .card {
                margin-bottom: 20px;
            }
        }
    </style>
</head>
<body>
<h1>员工请假系统</h1>
<div class="container">
    <div class="card">
        <h2>请假申请</h2>
        <p>请假申请功能</p>
        <form action="${pageContext.request.contextPath}/leave/addLeave?employeeId=${employee.employeeId}" method="post">
            <button type="submit" class="half-button">请假申请</button>
        </form>
    </div>
    <div class="card">
        <h2>申请历史</h2>
        <p>查看自己的请假申请历史记录。</p>
        <form action="${pageContext.request.contextPath}/leave/History??employeeId=${employee.employeeId}" method="post">
            <button type="submit" class="half-button">申请历史</button>
        </form>
    </div>
</div>
</body>
</html>