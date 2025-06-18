<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的薪资</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 40px;
        }

        .salary-card {
            max-width: 600px;
            margin: auto;
            background: #ffffff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .salary-card h2 {
            text-align: center;
            color: #0C5DF4;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 16px;
        }

        th, td {
            text-align: left;
            padding: 12px 15px;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #f0f2f5;
            width: 40%;
            color: #333;
        }

        td {
            color: #444;
        }

        .highlight {
            color: #28a745;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="salary-card">
    <h2>我的薪资详情</h2>
    <table>
        <tr><th>员工姓名</th><td>${employee.employeeName}</td></tr>
        <tr><th>部门</th><td>${department.departmentName}（${department.departmentSalary} 元）</td></tr>
        <tr><th>岗位</th><td>${position.positionName}（${position.positionSalary} 元）</td></tr>
        <tr><th>加班薪资</th><td>${salary.overtimeSalary} 元</td></tr>
        <tr><th>考勤薪资</th><td>${salary.attendanceSalary} 元</td></tr>
        <tr><th>合计薪资</th><td class="highlight">${totalSalary} 元</td></tr>
    </table>
</div>
</body>
</html>
