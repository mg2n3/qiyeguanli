package com.cg.interceptor;

import com.cg.entity.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session=request.getSession();
        //判断session中是否有用户信息
        User user= (User) session.getAttribute("user");
        if(user!=null){
            //如果有，说明用户已经登录，可以访问资源
            return true;
        }
        //如果没有，则说明未登录，跳转到登录页面
        response.sendRedirect(request.getContextPath()+"/user/login");
        return false;
    }
}