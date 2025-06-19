
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
    :root {
        --first-color: #5f6369;
        --bg-color: #F5F5F5;
        --white-color: #FFF;
        --body-font: 'Poppins', sans-serif;
        --normal-font-size: 1rem;
    }
    body {
        font-family: var(--body-font);
        font-size: var(--normal-font-size);
        background-color: #F9F2F6;
        padding: 2rem;
    }
    .content {
        display: flex;
        justify-content: center;
        min-height: 100vh;
        width: 100%;
        /* background-color: #5a6268; */
    }
    .form-container {
        background-color: #c0babacd;
        border-radius: 10px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        width: 800px;
        padding: 30px;
        transform: translateX(-350px);
    }
    h2 {
        text-align: center;
        margin-bottom: 20px;
        color: var(--first-color);
    }
    label {
        margin-top: 15px;
        margin-bottom: 5px;
        font-weight: 500;
    }
    select, input[type="number"], button {
        width: 100%;
        padding: 12px;
        border: 1px solid #ddd;
        border-radius: 6px;
        font-size: var(--normal-font-size);
    }
    button {
        background-color: var(--first-color);
        color: white;
        border: none;
        margin-top: 20px;
        font-weight: 600;
    }
    button:hover {
        background-color: #ccd0da;
    }
    .button-group {
        display: flex;
        gap: 10px;
    }
    .button-group button{
        margin: 80px;
    }
    .btn-back {
        background-color: #6c757d;
    }
    .btn-back:hover {
        background-color: #5a6268;
    }
    .tp{
        margin-right: 400px;
        background: url('<c:url value="/static/编辑薪资.jpg"/>');
        background-size: cover;
        filter: blur(0.5px); /* 虚化效果，5px 是模糊程度 */
        width: 600px;
    }
    .bq{
        margin: 30px;
    }
</style>
</head>
<body>
<div class="content">
    <div class="tp"></div>
    <div class="form-container">
        <h2>编辑薪资</h2>
        <form action="${pageContext.request.contextPath}/salary/update/${salaryDTO.salaryId}" method="post">
            <!-- CSRF Token -->
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <!-- Hidden ID -->
            <input type="hidden" name="salaryId" value="${salaryDTO.salaryId}" />

            <!-- 岗位 -->
            <div class="bq">
                <label for="positionId">岗位:</label>
                <select id="positionId" name="positionId" required>
                    <option value="">请选择岗位</option>
                    <c:forEach var="position" items="${positionList}">
                        <option value="${position.positionId}" <c:if test="${salaryDTO.positionId == position.positionId}">selected</c:if>>
                                ${position.positionName}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <!-- 部门 -->
            <div class="bq" >
                <label for="departmentId">部门:</label>
                <select id="departmentId" name="departmentId" required>
                    <option value="">请选择部门</option>
                    <c:forEach var="department" items="${departmentList}">
                        <option value="${department.departmentId}" <c:if test="${salaryDTO.departmentId == department.departmentId}">selected</c:if>>
                                ${department.departmentName}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <!-- 加班薪资 -->
            <div class="div"style="transform: translateX(32px);">
                <label for="overtimeSalary">加班薪资 (¥):</label>
                <input type="number" id="overtimeSalary" name="overtimeSalary"
                       value="${salaryDTO.overtimeSalary}" required step="0.01" min="0" placeholder="输入加班薪资" style="width: 670px;"/>
            </div>

            <!-- 考勤薪资 -->
            <div class="bq">
                <label for="attendanceSalary">考勤薪资 (¥):</label>
                <input type="number" id="attendanceSalary" name="attendanceSalary"
                       value="${salaryDTO.attendanceSalary}" required step="0.01" min="0" placeholder="输入考勤薪资"style="width: 670px;" />
            </div>

            <!-- 按钮 -->
            <div class="button-group">
                <button type="submit" class="btn-update"style="width: 200px;">更新薪资</button>
                <button type="button" class="btn-back" onclick="history.back()"style="width: 200px;">返回</button>
            </div>
        </form>
    </div>
</div>

<!-- 表单提交调试 -->
<script>
    $('form').on('submit', function () {
        console.log("提交内容：", {
            salaryId: $('input[name="salaryId"]').val(),
            positionId: $('#positionId').val(),
            departmentId: $('#departmentId').val(),
            overtimeSalary: $('#overtimeSalary').val(),
            attendanceSalary: $('#attendanceSalary').val()
        });
    });
</script>
</body>
</html>
