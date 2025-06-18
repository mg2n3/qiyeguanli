<%--
  Created by IntelliJ IDEA.
  User: 86135
  Date: 2025/1/6
  Time: 12:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        /* 使用Flexbox布局实现每行两个图表 */
        .chart-row {
            display: flex;
            justify-content: space-around; /* 使两个图表之间有间隔 */
            margin-bottom: 20px; /* 每行之间的间距 */
        }

        /* 信息框样式 */
        .info-box {
            border: 1px solid #ccc; /* 边框颜色 */
            padding: 15px; /* 内边距 */
            margin: 10px 0; /* 外边距 */
            text-align: center; /* 文本居中 */
            width: 200px; /* 宽度 */
            display: inline-block; /* 行内块元素 */
            background-color: #f9f9f9; /* 背景颜色 */
            border-radius: 8px; /* 圆角边框 */
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 阴影效果 */
            font-size: 16px; /* 字体大小 */
            color: #333; /* 字体颜色 */
            transition: transform 0.3s ease; /* 平滑过渡效果 */
        }

        .info-box:hover {
            transform: translateY(-5px); /* 鼠标悬停时上移 */
            box-shadow: 0 6px 10px rgba(0, 0, 0, 0.2); /* 鼠标悬停时阴影加深 */
        }

        /* 每个图表及其信息框的容器 */
        .chart-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin: 0 20px; /* 每个容器之间的间距 */
        }
    </style>
    <!-- 引入ECharts -->
    <script src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
</head>
<body>
<h1>数据展示</h1>
<div class="chart-row">
    <div class="chart-container">
        <div class="info-box" id="employeeAttendanceInfo">员工打卡统计</div>
        <div id="employeeAttendanceChart" style="width: 800px;height:400px;"></div>
    </div>
</div>

<script type="text/javascript">
    // 获取从后端传递的数据
    var employeeListJson = '${employeeListJson}';
    var leaveListJson = '${leaveListJson}';
    var attendanceListJson='${attendanceListJson}';
    var departmentListJson = '${departmentListJson}'; // 获取部门列表的JSON数据

    // 解析JSON数据
    var employeeList = JSON.parse(employeeListJson);
    var leaveList = JSON.parse(leaveListJson);
    var attendanceList = JSON.parse(attendanceListJson);
    var departmentList = JSON.parse(departmentListJson); // 解析部门列表

    // 初始化员工打卡统计图表
    var employeeAttendanceChart = echarts.init(document.getElementById('employeeAttendanceChart'));

    // 统计每个员工的正常出勤和异常出勤次数
    var employeeAttendanceData = [];
    employeeList.forEach(function(employee) {
        var employeeId = employee.employeeId;
        var normalAttendanceCount = 0; // 正常出勤次数
        var abnormalAttendanceCount = 0; // 异常出勤次数

        // 遍历出勤记录，统计正常和异常出勤次数
        attendanceList.forEach(function(attendance) {
            if (attendance.employeeId === employeeId) {
                if (attendance.state === 0) {
                    normalAttendanceCount++;
                } else {
                    abnormalAttendanceCount++;
                }
            }
        });

        employeeAttendanceData.push({
            name: employee.employeeName,
            normal: normalAttendanceCount,
            abnormal: abnormalAttendanceCount
        });
    });

    // 对员工出勤数据按正常出勤次数降序排序
    employeeAttendanceData.sort(function(a, b) {
        return b.normal - a.normal;
    });

    // 提取员工名字和出勤数据
    var employeeNames = employeeAttendanceData.map(item => item.name);
    var normalAttendanceValues = employeeAttendanceData.map(item => item.normal);
    var abnormalAttendanceValues = employeeAttendanceData.map(item => item.abnormal);

    var employeeAttendanceOption = {
        title: {
            text: '员工打卡统计'
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data: ['正常出勤', '异常出勤']
        },
        xAxis: {
            type: 'category',
            data: employeeNames,
            axisLabel: {
                interval: 0, // 不间隔显示X轴标签
                rotate: 45 // X轴标签倾斜45度
            }
        },
        yAxis: {
            type: 'value'
        },
        series: [
            {
                name: '正常出勤',
                type: 'line',
                data: normalAttendanceValues,
                itemStyle: {
                    color: 'green'
                },
                lineStyle: {
                    color: 'green'
                },
                areaStyle: {
                    color: 'rgba(0, 255, 0, 0.3)'
                }
            },
            {
                name: '异常出勤',
                type: 'line',
                data: abnormalAttendanceValues,
                itemStyle: {
                    color: 'red'
                },
                lineStyle: {
                    color: 'red'
                },
                areaStyle: {
                    color: 'rgba(255, 0, 0, 0.3)'
                }
            }
        ]
    };

    employeeAttendanceChart.setOption(employeeAttendanceOption);
</script>
</body>
</html>