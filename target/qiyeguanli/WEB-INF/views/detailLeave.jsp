<%--
  Created by IntelliJ IDEA.
  User: 86135
  Date: 2025/1/3
  Time: 8:35
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
    <title>请假详情</title>
</head>
<style>
    .back-button {
        display: inline-block;
        padding: 10px 20px;
        background-color: #424344;
        color: #ffffff;
        text-decoration: none;
        border-radius: 5px;
        transition: background-color 0.3s;
        font-weight: bold;
        margin-top: 20px;
    }
    .box{
        width: 100%;
        background: url(<c:url value='/static/请假详情.jpg'/> );
        background-size: cover;
    }

    .back-button:hover {
        background-color: #81858a;
    }
    body {
        font-family: 'Poppins', sans-serif;
        background-color:black;
        margin: 0;
        padding: 20px;
    }

    .content {
        max-width: 800px;
        margin: 0 auto;
        background-color: #ffffffd6;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    h1 {
        color: #0b0b0b;
        text-align: center;
        margin-bottom: 20px;
    }

    .leave-detail-container {
        margin-bottom: 20px;
    }

    .leave-detail {
        border: 1px solid #ddd;
        padding: 15px;
        border-radius: 5px;
    }

    p {
        margin: 0 0 10px 0;
        font-size: 16px;
        color: #333;
    }

    p strong {
        color: #333;
        font-weight: 600;
    }

    .back-button {
        display: inline-block;
        padding: 10px 20px;
        background-color: #080808;
        color: #ffffff;
        text-decoration: none;
        border-radius: 5px;
        transition: background-color 0.3s;
        font-weight: bold;
        margin-top: 20px;
        text-align: center;
    }

    .back-button:hover {
        background-color: #0056b3;
    }

    .action-buttons {
        text-align: center;
    }
    .status-pending {
        color: #ffc107; /* 橙色，代表未审核 */
    }

    .status-approved {
        color: #28a745; /* 绿色，代表已通过 */
    }

    .status-rejected {
        color: #dc3545; /* 红色，代表已拒绝 */
    }
</style>
<body>
<div class="box">
    <div class="content">
        <h1>请假详情</h1>
        <div class="leave-detail-container">
            <c:if test="${not empty leave}">
                <div class="leave-detail">
                    <p><strong>员工工号:</strong> ${leave.leaveId}</p>
                    <c:if test="${sessionScope.user.role == 3}">
                        <p><strong>请假员工:</strong>
                            <c:forEach var="employee" items="${employeeList}">
                                <c:if test="${employee.employeeId == leave.employeeId}">
                                    ${employee.employeeName}
                                </c:if>
                            </c:forEach>
                        </p>
                    </c:if>
                    <p><strong>请假类型:</strong>
                        <c:choose>
                            <c:when test="${leave.leaveType == 0}">病假</c:when>
                            <c:when test="${leave.leaveType == 1}">事假</c:when>
                            <c:when test="${leave.leaveType == 2}">年假</c:when>
                        </c:choose>
                    </p>
                    <p><strong>请假开始时间:</strong> <fmt:formatDate value="${leave.startDate}" pattern="yyyy-MM-dd' 'HH:mm"/></p>
                    <p><strong>请假结束时间:</strong> <fmt:formatDate value="${leave.endDate}" pattern="yyyy-MM-dd' 'HH:mm"/></p>
                    <p><strong>请假原因:</strong> ${leave.reason}</p>
                    <p><strong>状态:</strong>
                        <c:choose>
                            <c:when test="${leave.status == 0}">
                                <span class="status-pending">未审核</span>
                            </c:when>
                            <c:when test="${leave.status == 1}">
                                <span class="status-approved">通过</span>
                            </c:when>
                            <c:when test="${leave.status == 2}">
                                <span class="status-rejected">拒绝</span>
                            </c:when>
                        </c:choose>
                    </p>
                    <p><strong>审核人员:</strong>  ${leave.cheackName}</p>
                </div>

                <div class="action-buttons">
                    <c:if test="${sessionScope.user.role == 3}">
                        <a href="${pageContext.request.contextPath}/leave/List" class="back-button">返回请假列表</a>
                    </c:if>
                </div>
                <div class="action-buttons">
                    <c:if test="${sessionScope.user.role == 1}">
                        <a href="${pageContext.request.contextPath}/leave/employeeLeave" class="back-button">返回请假列表</a>
                    </c:if>
                </div>
            </c:if>
            <c:if test="${empty leave}">
                <p>未找到请假信息。</p>
            </c:if>
        </div>
    </div>
</div>
<script>

</script>
</body>
</html>
