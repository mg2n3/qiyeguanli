<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加薪资</title>
    <!-- jquery -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-3.6.1.js"></script>
    <!-- layer -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layer/theme/default/layer.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/layer/layer.js"></script>
    <!-- common可删 -->
    <%--    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/common.css"/>--%>
    <%--    <script type="text/javascript" src="${pageContext.request.contextPath}/static/common.js"></script>--%>
    <!-- 引入bootstrap -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/bootstrap/css/bootstrap.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap/js/bootstrap.js"></script>
    <!-- 引入bootstrap-select -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-select/css/bootstrap-select.css"/>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/bootstrap-select/js/bootstrap-select.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/bootstrap-select/js/bootstrap-select-ext.js"></script>
    <!-- popper(新增) -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/popper.js"></script>
    <style>
        /* 谷歌字体 */
        @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap");

        /* CSS变量 */
        :root {
            --first-color: #121213;
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
            background-color: #FFF;
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
            margin-top: 30px;
            margin-left: 200px;
            display: flex;
            position: relative;
        }
        .box1{
            display: flex;
            margin: 30px;
        }
        .box3{
            margin-left: 50px;
            width: 70%;
        }
        .box4{
            margin-left: 80px;
            width: 70%;

        }
        .form-container {
            /* margin-left: 400px; */
            /* margin-top: 30px; */
            background-color: #0000004d;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
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
        select, input[type="number"], button {
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
            margin-top: 15px;
            width: 15%;
            margin: 20px;
        }
        button:hover {
            background-color: #63666b;
        }

        #hz5{
            /* background-color: aqua; */
            margin-left: 5px;

        }
        #hz5 img{
            width: 100%;
        }
        .hz6{
            /* background-color: #fc0c0c4d; */
            width: 50%;

        }
    </style>
</head>
<body>
<div class="bj">
    <div class="content">
        <div id="hz5"><img src="<c:url value="/static/bj1.jpg"/>" style="width: 400px;"></div>
        <div class="hz6">
            <div class="form-container">
                <h2>添加薪资</h2>
                <form action="${pageContext.request.contextPath}/salary/add" method="post">
                    <div class="box1">
                        <div class="box2">
                            <label for="positionId">岗位:</label>
                        </div>
                        <div class="box4">
                            <select id="positionId" name="positionId" required>
                                <option value="">请选择岗位</option>
                                <c:forEach var="position" items="${positionList}">
                                    <option value="${position.positionId}">${position.positionName}</option>
                                </c:forEach>
                            </select>
                        </div>

                    </div>
                    <div class="box1">
                        <div class="box2">
                            <label for="departmentId">部门:</label>
                        </div>

                        <div class="box4">
                            <select id="departmentId" name="departmentId" required>
                                <option value="">请选择部门</option>
                                <c:forEach var="department" items="${departmentList}">
                                    <option value="${department.departmentId}">${department.departmentName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="box1">
                        <div class="box2">
                            <label for="baseSalary">基本薪资:</label>
                        </div>
                        <div class="box3"><input type="number" id="baseSalary" name="baseSalary" step="0.01" required></div>
                    </div>
                    <div class="box1">
                        <div class="box2">
                            <label for="overtimeSalary">加班薪资:</label>
                        </div>
                        <div class="box3"><input type="number" id="overtimeSalary" name="overtimeSalary" step="0.01" required></div>
                    </div>
                    <div class="box1">
                        <div class="box2">
                            <label for="attendanceSalary">考勤薪资:</label>
                        </div>
                        <div class="box3"><input type="number" id="attendanceSalary" name="attendanceSalary" step="0.01" required></div>
                    </div>
                    <div class="box1">
                        <div class="box2">
                            <label for="bonus">奖金:</label>
                        </div>
                        <div class="box4"><input type="number" id="bonus" name="bonus" step="0.01" required></div>
                    </div>
                    <button type="submit" class="add-button">添加薪资</button>
                    <button type="button" class="add-button" onclick="history.back()">返回</button>
                </form>
            </div>
        </div>

    </div>

</div>

</body>
</html>