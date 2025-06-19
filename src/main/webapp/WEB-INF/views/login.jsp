<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <!-- 粒子动画 -->
    <script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>

    <!-- 免费 Font Awesome 图标 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>

    <title>用户登录</title>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body, input {
            font-family: 'Poppins', sans-serif;
        }

        #particles-js {
            position: fixed;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at center, #0f2027, #203a43, #2c5364);
            z-index: -1;
        }

        .login-container {
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-box {
            width: 400px;
            padding: 40px 30px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            box-shadow: 0 0 30px rgba(0, 255, 255, 0.2);
            backdrop-filter: blur(12px);
            position: relative;
            animation: floatUp 2s ease-out forwards;
        }

        .login-box h2 {
            color: #00ffff;
            text-align: center;
            margin-bottom: 30px;
            text-shadow: 0 0 10px #00ffff;
        }

        .input-field {
            position: relative;
            margin-bottom: 25px;
        }

        .input-field i {
            position: absolute;
            top: 50%;
            left: 15px;
            transform: translateY(-50%);
            color: #00ffff;
            pointer-events: none;
        }

        .input-field input {
            width: 100%;
            padding: 12px 15px 12px 45px;
            border: none;
            border-radius: 30px;
            background: rgba(255, 255, 255, 0.2);
            color: #fff;
            outline: none;
            transition: all 0.3s ease;
        }

        .input-field input:focus {
            box-shadow: 0 0 10px #00ffff;
            background: rgba(255, 255, 255, 0.25);
        }

        .input-field input::placeholder {
            color: #ddd;
        }

        .btn {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 30px;
            background: linear-gradient(to right, #04befe, #4481eb);
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            cursor: pointer;
            box-shadow: 0 0 15px #00bfff;
            transition: all 0.3s ease-in-out;
        }

        .btn:hover {
            transform: scale(1.03);
            box-shadow: 0 0 25px #00ffff, 0 0 35px #00ffff;
        }

        #error-message {
            background: rgba(255, 0, 0, 0.25);
            color: #fff;
            padding: 10px;
            border-radius: 10px;
            margin-bottom: 15px;
            text-align: center;
        }

        @keyframes floatUp {
            0% {
                opacity: 0;
                transform: translateY(30px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
<div id="particles-js"></div>

<div class="login-container">
    <div class="login-box">
        <h2>用户登录</h2>

        <% if (request.getAttribute("loginError") != null) { %>
        <div id="error-message"><%= request.getAttribute("loginError") %></div>
        <% } %>

        <form action="${pageContext.request.contextPath}/user/doLogin" method="post">
            <div class="input-field">
                <i class="fas fa-user"></i>
                <input type="text" name="username" placeholder="用户名/工号" required />
            </div>
            <div class="input-field">
                <i class="fas fa-lock"></i>
                <input type="password" name="password" placeholder="密码（默认123456）" required />
            </div>
            <input type="submit" value="登 录" class="btn" />
        </form>
    </div>
</div>

<!-- 粒子效果配置 -->
<script>
    particlesJS("particles-js", {
        particles: {
            number: { value: 90, density: { enable: true, value_area: 800 } },
            color: { value: "#00ffff" },
            shape: { type: "circle" },
            opacity: { value: 0.3 },
            size: { value: 4, random: true },
            line_linked: {
                enable: true,
                distance: 150,
                color: "#00ffff",
                opacity: 0.4,
                width: 1
            },
            move: {
                enable: true,
                speed: 2,
                direction: "none",
                random: false,
                straight: false,
                out_mode: "out"
            }
        },
        interactivity: {
            detect_on: "canvas",
            events: {
                onhover: { enable: true, mode: "repulse" },
                onclick: { enable: true, mode: "push" }
            },
            modes: {
                repulse: { distance: 100, duration: 0.4 },
                push: { particles_nb: 4 }
            }
        },
        retina_detect: true
    });
</script>
</body>
</html>
