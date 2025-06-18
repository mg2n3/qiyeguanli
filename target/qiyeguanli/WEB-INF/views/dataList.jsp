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
            padding: 10px; /* 内边距 */
            margin: 10px 0; /* 外边距 */
            text-align: center; /* 文本居中 */
            width: 200px; /* 宽度 */
            display: inline-block; /* 行内块元素 */
        }

        /* 每个图表及其信息框的容器 */
        .chart-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin: 0 20px; /* 每个容器之间的间距 */
        }
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
        <div class="info-box" id="leaveInfo">今日请假人数: 0</div>
        <div id="leaveChart" style="width: 400px;height:300px;"></div>
    </div>
    <div class="chart-container">
        <div class="info-box" id="departmentInfo">员工总数量: 0</div>
        <div id="departmentLeaveChart" style="width: 400px;height:300px;"></div>
    </div>
    <div class="chart-container">
        <div class="info-box" id="attendanceInfo">本月出勤总次数: 0</div>
        <div id="attendanceChart" style="width: 400px;height:300px;"></div>
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

    // 计算今日请假人数
    var todayLeaveCount = 0;
    leaveList.forEach(function(item) {
        var startLeaveDate = new Date(item.startDate);
        var endLeaveDate = new Date(item.endDate);
        var today = new Date();
        if (today >= startLeaveDate && today <= endLeaveDate) {
            todayLeaveCount++;
        }
    });
    document.getElementById('leaveInfo').innerText = '今日请假人数: ' + todayLeaveCount;

    // 计算员工总数量
    var totalEmployeeCount = employeeList.length;
    document.getElementById('departmentInfo').innerText = '员工总数量: ' + totalEmployeeCount;

    // 计算本月出勤总次数
    var today = new Date();
    var firstDayOfMonth = new Date(today.getFullYear(), today.getMonth(), 1);
    var lastDayOfMonth = new Date(today.getFullYear(), today.getMonth() + 1, 0);
    var firstDayOfMonthStr = firstDayOfMonth.toISOString().split('T')[0];
    var lastDayOfMonthStr = lastDayOfMonth.toISOString().split('T')[0];

    var totalAttendanceCount = 0;
    attendanceList.forEach(function(attendance) {
        var attendanceDate = new Date(attendance.date);
        var formattedAttendanceDate = attendanceDate.toISOString().split('T')[0];
        if (formattedAttendanceDate >= firstDayOfMonthStr && formattedAttendanceDate <= lastDayOfMonthStr) {
            if (attendance.state === 0) {
                totalAttendanceCount++;
            }
        }
    });
    document.getElementById('attendanceInfo').innerText = '本月出勤总次数: ' + totalAttendanceCount;

    // 初始化请假图表
    var leaveChart = echarts.init(document.getElementById('leaveChart'));

    // 获取今天的日期
    var today = new Date();
    var todayDate = today.getFullYear() + '-' + (today.getMonth() + 1).toString().padStart(2, '0') + '-' + today.getDate().toString().padStart(2, '0');

    // 统计每种请假类型的数量
    var leaveTypeCounts = [
        { name: '病假', value: 0 },
        { name: '事假', value: 0 },
        { name: '年假', value: 0 }
    ];

    leaveList.forEach(function(item) {
        // 将请假的开始日期和结束日期转换为Date对象
        var startLeaveDate = new Date(item.startDate);
        var endLeaveDate = new Date(item.endDate);

        // 判断今天的日期是否在请假的开始日期和结束日期之间
        if (today >= startLeaveDate && today <= endLeaveDate) {
            if (item.leaveType === 0) {
                leaveTypeCounts[0].value++;
            } else if (item.leaveType === 1) {
                leaveTypeCounts[1].value++;
            } else if (item.leaveType === 2) {
                leaveTypeCounts[2].value++;
            }
        }
    });

    var leaveOption = {
        title: {
            text: '今日请假类型统计'
        },
        tooltip: {
            trigger: 'item',
            formatter: '{a} <br/>{b} : {c} ({d}%)'
        },
        series: [ {
            name: '请假类型',
            type: 'pie',
            radius: '55%',
            data: leaveTypeCounts,
            itemStyle: {
                emphasis: {
                    shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
            }
        }]
    };
    leaveChart.setOption(leaveOption);

    // 初始化部门员工数量图表
    var departmentEmployeeChart = echarts.init(document.getElementById('departmentLeaveChart'));

    // 统计每个部门的员工数量
    var departmentEmployeeCounts = {};

    employeeList.forEach(function(employee) {
        var departmentId = employee.departmentId;
        if (!departmentEmployeeCounts[departmentId]) {
            departmentEmployeeCounts[departmentId] = 0;
        }
        departmentEmployeeCounts[departmentId]++;
    });

    // 将部门ID转换为部门名称
    var departmentEmployeeData = [];
    departmentList.forEach(function(department) {
        if (departmentEmployeeCounts[department.departmentId]) {
            departmentEmployeeData.push({
                name: department.departmentName,
                value: departmentEmployeeCounts[department.departmentId]
            });
        }
    });

    var departmentEmployeeOption = {
        title: {
            text: '部门员工数量'
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
            }
        },
        xAxis: {
            type: 'category',
            data: departmentEmployeeData.map(item => item.name)
        },
        yAxis: {
            type: 'value',
            axisLabel: {
                formatter: '{value}'
            },
            min: 0, // 设置 y 轴的最小值
            max: Math.max(...departmentEmployeeData.map(item => item.value)) , // 设置 y 轴的最大值
            interval: 1 // 设置 y 轴的刻度间隔为 1
        },
        series: [{
            name: '员工数量',
            type: 'bar',
            data: departmentEmployeeData.map(item => item.value),
            itemStyle: {
                emphasis: {
                    shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
            }
        }]
    };
    departmentEmployeeChart.setOption(departmentEmployeeOption);
    // 初始化出勤情况图表
    var attendanceChart = echarts.init(document.getElementById('attendanceChart'));

    // 获取本月第一天和最后一天的日期
    var today = new Date();
    var firstDayOfMonth = new Date(today.getFullYear(), today.getMonth(), 1);
    var lastDayOfMonth = new Date(today.getFullYear(), today.getMonth() + 1, 0);
    var firstDayOfMonthStr = firstDayOfMonth.getFullYear() + '-' + (firstDayOfMonth.getMonth() + 1).toString().padStart(2, '0') + '-' + firstDayOfMonth.getDate().toString().padStart(2, '0');
    var lastDayOfMonthStr = lastDayOfMonth.getFullYear() + '-' + (lastDayOfMonth.getMonth() + 1).toString().padStart(2, '0') + '-' + lastDayOfMonth.getDate().toString().padStart(2, '0');

    // 统计出勤情况
    var attendanceData = {};
    employeeList.forEach(function(employee) {
        var employeeId = employee.employeeId;
        attendanceData[employeeId] = {
            name: employee.employeeName,
            attendance: 0,
            absence: 0,
            attendanceDates: []  // 存储具体的出勤日期
        };
    });

    attendanceList.forEach(function(attendance) {
        var attendanceDate = new Date(attendance.date);
        var formattedAttendanceDate = attendanceDate.toISOString().split('T')[0]; // 获取年月日格式的日期字符串
        var employeeId = attendance.employeeId;
        if (formattedAttendanceDate >= firstDayOfMonthStr && formattedAttendanceDate <= lastDayOfMonthStr) {
            if (attendance.state === 0) {
                attendanceData[employeeId].attendance++;
                attendanceData[employeeId].attendanceDates.push(formattedAttendanceDate);  // 添加具体的出勤日期
            } else {
                attendanceData[employeeId].absence++;
            }
        }
    });

    // 准备图表数据
    var attendanceChartSeriesData = [
        { name: '正常', value: 0, itemStyle: { color: '#32CD32' } },
        { name: '异常', value: 0, itemStyle: { color: '#c82333' } }
    ];

    for (var employeeId in attendanceData) {
        attendanceChartSeriesData[0].value += attendanceData[employeeId].attendance;
        attendanceChartSeriesData[1].value += attendanceData[employeeId].absence;
    }

    var attendanceChartOption = {
        title: {
            text: '本月员工打卡情况'
        },
        tooltip: {
            trigger: 'item',
            formatter: '{a} <br/>{b} : {c} ({d}%)'
        },
        series: [
            {
                name: '打卡情况',
                type: 'pie',
                radius: '55%',
                data: attendanceChartSeriesData,
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }
        ]
    };
    attendanceChart.setOption(attendanceChartOption);

</script>
</body>
</html>