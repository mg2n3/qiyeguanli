<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- ===== 引入 ===== -->
<%--    <link rel="stylesheet" href="assets/css/styles.css">--%>
    <title>企业员工管理系统主页</title>
    <style>
        /*===== 谷歌字体 =====*/
        @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap");

        /*===== css变量 =====*/
        :root{
            --nav-width: 92px;
            /*===== 自定义颜色 =====*/
            --first-color: #0C5DF4;
            --bg-color: #12192C;
            --sub-color: #B6CEFC;
            --white-color: #FFF;
            /*===== 规定字体  =====*/
            --body-font: 'Poppins', sans-serif;
            --normal-font-size: 1rem;
            --small-font-size: .875rem;
            /*===== 设置z-index =====*/
            --z-fixed: 100;
        }

        /*===== 基础规定 =====*/
        *,::before,::after{
            box-sizing: border-box;
        }
        body{
            position: relative;
            margin: 0;
            padding: 2rem 0 0 6.75rem;
            font-family: var(--body-font);
            font-size: var(--normal-font-size);
            transition: .5s;
        }
        h1{
            margin: 0;
        }
        ul{
            margin: 0;
            padding: 0;
            list-style: none;
        }
        a{
            text-decoration: none;
        }

        /*===== 左侧 nav =====*/
        .l-navbar{
            position: fixed;
            top: 0;
            left: 0;
            width: var(--nav-width);
            height: 100vh;
            background-color: var(--bg-color);
            color: var(--white-color);
            padding: 1.5rem 1.5rem 2rem;
            transition: .5s;
            z-index: var(--z-fixed);
        }

        /*===== NAV =====*/
        .nav{
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            overflow: hidden;
        }
        .nav__brand{
            display: grid;
            grid-template-columns: max-content max-content;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }
        .nav__toggle{
            font-size: 1.25rem;
            padding: .75rem;
            cursor: pointer;
        }
        .nav__logo{
            color: var(--white-color);
            font-weight: 600;
        }

        .nav__link{
            display: grid;
            grid-template-columns: max-content max-content;
            align-items: center;
            column-gap: .75rem;
            padding: .75rem;
            color: var(--white-color);
            border-radius: .5rem;
            margin-bottom: 1rem;
            transition: .3s;
            cursor: pointer;
        }
        .nav__link:hover{
            background-color: var(--first-color);
        }
        .nav__icon{
            font-size: 1.25rem;
        }
        .nav__name{
            font-size: var(--small-font-size);
        }

        /*菜单控件*/
        .expander{
            width: calc(var(--nav-width) + 9.25rem);
        }

        /*给body增加边距*/
        .body-pd{
            padding: 2rem 0 0 16rem;
        }

        /*选中的菜单状态*/
        .active{
            background-color: var(--first-color);
        }

        .collapse{
            grid-template-columns: 20px max-content 1fr;
        }
        .collapse__link{
            justify-self: flex-end;
            transition: .5s;
        }
        .collapse__menu{
            display: none;
            padding: .75rem 2.25rem;
        }
        .collapse__sublink{
            color: var(--sub-color);
            font-size: var(--small-font-size);
        }
        .collapse__sublink:hover{
            color: var(--white-color);
        }

        .showCollapse{
            display: block;
        }

        .rotate{
            transform: rotate(180deg);
        }
        .content {
            position: relative;
            width: 100%;
            height: calc(100vh - 80px);
            overflow: auto;
        }

        iframe {
            width: 100%;
            height: 100%;
            border: none;
        }
    </style>
</head>
<body id="body-pd">
<div class="l-navbar" id="navbar">
    <nav class="nav">
        <div>
            <div class="nav__brand">
                <ion-icon name="menu-outline" class="nav__toggle" id="nav-toggle"></ion-icon>
                <a href="#" class="nav__logo">${sessionScope.user.username}</a>
            </div>
            <div class="nav__list">
                <a href="#" class="nav__link active" onclick="loadMainPage()">
                    <ion-icon name="home-outline" class="nav__icon"></ion-icon>
                    <span class="nav__name">主页</span>
                </a>
                <c:if test="${sessionScope.user.role == 1}">
                    <a href="#" class="nav__link" onclick="clockIn()">
                        <ion-icon name="briefcase-outline" class="nav__icon"></ion-icon>
                        <span class="nav__name">打卡</span>
                    </a>
                    <a href="#" class="nav__link" onclick="loadLeavePage()">
                        <ion-icon name="time-outline" class="nav__icon"></ion-icon>
                        <span class="nav__name">请假</span>
                    </a>
                </c:if>
                <!-- 导航链接 -->
                <c:if test="${sessionScope.user.role == 3||sessionScope.user.role == 2}">
                    <a href="#" class="nav__link" onclick="loadEmployeeManagementPage()">
                        <ion-icon name="people-outline" class="nav__icon"></ion-icon>
                        <span class="nav__name">员工管理</span>
                    </a>
                    <a href="#" class="nav__link" onclick="loadLeaveManagementPage()">
                        <ion-icon name="time-outline" class="nav__icon"></ion-icon>
                        <span class="nav__name">请假管理</span>
                    </a>
                    <a href="#" class="nav__link" onclick="loadAttendanceStatisticsPage()">
                        <ion-icon name="clipboard-outline" class="nav__icon"></ion-icon>
                        <span class="nav__name">考勤列表</span>
                    </a>
                    <!-- 新增薪资管理导航项 -->
                    <a href="#" class="nav__link" onclick="loadSalaryManagementPage()">
                        <ion-icon name="cash-outline" class="nav__icon"></ion-icon>
                        <span class="nav__name">薪资管理</span>
                    </a>
                </c:if>

                <!-- 导航链接 -->
                <c:if test="${sessionScope.user.role == 2}">
                    <a href="#" class="nav__link" onclick="ManangeStatisticsPage()">
                        <ion-icon name="stats-chart-outline" class="nav__icon"></ion-icon>
                        <span class="nav__name">数据统计</span>
                    </a>
                </c:if>

                <c:if test="${sessionScope.user.role == 3}">
                    <a href="#" class="nav__link" onclick="loadDepartmentManagementPage()">
                        <ion-icon name="business-outline" class="nav__icon"></ion-icon>
                        <span class="nav__name">部门管理</span>
                    </a>
                    <a href="#" class="nav__link" onclick="loadPositionManagementPage()">
                        <ion-icon name="briefcase-outline" class="nav__icon"></ion-icon>
                        <span class="nav__name">岗位管理</span>
                    </a>

                    <a href="#" class="nav__link" onclick="loadStaffStatisticsPage()">
                        <ion-icon name="stats-chart-outline" class="nav__icon"></ion-icon>
                        <span class="nav__name">数据统计</span>
                    </a>
                </c:if>
                <c:if test="${not empty sessionScope.employee}">
                    <a href="#" class="nav__link" onclick="loadMySalaryPage()">
                        <ion-icon name="cash-outline" class="nav__icon"></ion-icon>
                        <span class="nav__name">我的薪资</span>
                    </a>
                </c:if>
                <a href="#" class="nav__link" onclick="loadSettingsPage()">
                    <ion-icon name="settings-outline" class="nav__icon"></ion-icon>
                    <span class="nav__name">设置</span>
                </a>

            </div>
        </div>
        <a href="#" action="${pageContext.request.contextPath}/user/logout" class="nav__link">
            <ion-icon name="log-out-outline" class="nav__icon"></ion-icon>
            <span class="nav__name">退出登录</span>
        </a>
    </nav>
</div>
<div class="content">
    <!-- 在这里添加iframe -->
    <iframe src="" frameborder="0" width="100%" height="100%" id="contentFrame"></iframe>
</div>
<!-- ===== 引入icon ===== -->
<script src="https://unpkg.com/ionicons@5.1.2/dist/ionicons.js"></script>

<!-- ===== 引入js ===== -->
<script>
    /*===== 新增薪资管理页面加载函数 =====*/
    function loadSalaryManagementPage() {
        const url = "${pageContext.request.contextPath}/salary/List";
        document.getElementById('contentFrame').src = url;
    }
    /*===== EXPANDER MENU  =====*/
    const showMenu = (toggleId, navbarId, bodyId) => {
        const toggle = document.getElementById(toggleId),
            navbar = document.getElementById(navbarId),
            bodypadding = document.getElementById(bodyId)

        if (toggle && navbar) {
            toggle.addEventListener('click', () => {
                navbar.classList.toggle('expander')

                bodypadding.classList.toggle('body-pd')
            })
        }
    }
    showMenu('nav-toggle', 'navbar', 'body-pd')
    /*===== LINK ACTIVE  =====*/
    const linkColor = document.querySelectorAll('.nav__link')

    function colorLink() {
        linkColor.forEach(l => l.classList.remove('active'))
        this.classList.add('active')
    }

    linkColor.forEach(l => l.addEventListener('click', colorLink))

    /*===== COLLAPSE MENU  =====*/
    const linkCollapse = document.getElementsByClassName('collapse__link')
    var i

    for (i = 0; i < linkCollapse.length; i++) {
        linkCollapse[i].addEventListener('click', function () {
            const collapseMenu = this.nextElementSibling
            collapseMenu.classList.toggle('showCollapse')

            const rotate = collapseMenu.previousElementSibling
            rotate.classList.toggle('rotate')
        })
    }
    function ManangeStatisticsPage() {
        const url = "${pageContext.request.contextPath}/data/manageData";
        document.getElementById('contentFrame').src = url;
    }

    function loadSettingsPage() {
        const url = "${pageContext.request.contextPath}/user/updatePassword";
        document.getElementById('contentFrame').src = url;
    }

    function clockIn() {
        const url = "${pageContext.request.contextPath}/attendance/Clock";
        document.getElementById('contentFrame').src = url;
    }

    function loadLeavePage() {
        const url = "${pageContext.request.contextPath}/leave/employeeLeave";
        document.getElementById('contentFrame').src = url;
    }

    function loadEmployeeManagementPage() {
        const url = "${pageContext.request.contextPath}/employee/List";
        document.getElementById('contentFrame').src = url;
    }

    function loadDepartmentManagementPage() {
        const url = "${pageContext.request.contextPath}/department/List";
        document.getElementById('contentFrame').src = url;
    }

    function loadPositionManagementPage() {
        const url = "${pageContext.request.contextPath}/position/List";
        document.getElementById('contentFrame').src = url;
    }

    function loadLeaveManagementPage() {
        const url = "${pageContext.request.contextPath}/leave/List";
        document.getElementById('contentFrame').src = url;
    }

    function loadStaffStatisticsPage() {
        const url = "${pageContext.request.contextPath}/data/List";
        document.getElementById('contentFrame').src = url;
    }

    function loadAttendanceStatisticsPage() {
        const url = "${pageContext.request.contextPath}/attendance/List";
        document.getElementById('contentFrame').src = url;
    }

    // 加载薪资管理页面
    function loadSalaryManagementPage() {
        const url = "${pageContext.request.contextPath}/salary/list";
        document.getElementById('contentFrame').src = url;
    }

    // 加载事件管理页面
    function loadMainPage() {
        const url = "${pageContext.request.contextPath}/user/Main";
        document.getElementById('contentFrame').src = url;
    }

    /*
    退出
    */
    // 获取退出链接元素
    const logoutLink = document.querySelector('a[action]');
    // 为退出链接添加点击事件监听器
    logoutLink.addEventListener('click', function (e) {
        e.preventDefault(); // 阻止默认行为
        // 创建一个表单元素用于提交退出请求
        const form = document.createElement('form');
        form.setAttribute('action', this.getAttribute('action'));
        form.setAttribute('method', 'post');
        // 将表单添加到页面中并提交
        document.body.appendChild(form);
        form.submit();
    });
    // 页面加载完成后默认加载主页
    window.onload = function() {
        loadMainPage();
    };
    function loadMySalaryPage() {
        const url = "${pageContext.request.contextPath}/employee/salary";
        document.getElementById('contentFrame').src = url;
    }

</script>
</body>
</html>
