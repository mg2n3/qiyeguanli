<%--
  Created by IntelliJ IDEA.
  User: 86135
  Date: 2025/1/1
  Time: 18:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>统计页面</title>
    <!-- 引入 ECharts -->
    <script src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: #f4f4f4;
        }
        .container {
            max-width: 1200px;
            margin: auto;
            padding: 20px;
        }
        .chart-container {
            display: flex;
            justify-content: space-around;
            margin-top: 20px;
        }
        .chart {
            width: 500px;
            height: 400px;
            margin: 10px;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .total-events {
            text-align: center;
            margin-bottom: 20px;
            font-size: 1.2em;
            color: #555;
        }
        .chart-title {
            text-align: center;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>欢迎使用企业员工管理系统</h1>
</div>
</body>
</html>
