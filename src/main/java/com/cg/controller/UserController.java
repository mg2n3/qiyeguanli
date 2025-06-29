package com.cg.controller;

import com.cg.entity.Employee;
import com.cg.service.EmployeeService;
import com.cg.service.UserService;
import com.cg.entity.User;
import com.cg.util.Md5Util;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private EmployeeService employeeService;

    @RequestMapping(value = "/login")
    public String login(){
        return "login";
    }
    @RequestMapping(value = "/doLogin", method = RequestMethod.POST)
    public String login(HttpServletRequest request, Model model) {
        String no = request.getParameter("username");
        String password = request.getParameter("password");

        if (no == null || no.isEmpty() || password == null || password.isEmpty()) {
            model.addAttribute("loginError", "请输入账号和密码");
            return "/login";
        }

        // 登录验证
        User user = userService.login(no, password);
        if (user != null) {
            // 将登录用户放入 session
            request.getSession().setAttribute("user", user);

            // 查询该用户是否对应员工身份（通过 userId 查找员工表）
            Employee employee = employeeService.findByUserId(user.getId());
            if (employee != null) {
                // 是员工身份，放入 session
                request.getSession().setAttribute("employee", employee);
            }

            return "/home";
        } else {
            model.addAttribute("loginError", "用户名或密码错误");
            return "/login";
        }
    }
    @RequestMapping(value = "/logout", method = RequestMethod.POST)
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        // 清除session中的用户信息
        request.getSession().invalidate();
        return "/login"; // 退出后重定向到登录页面
    }

    @RequestMapping("/Main")
    public String Main(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");

        return "Main";
    }
    @RequestMapping("/updatePassword")
    public String updatePassword(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        return "updatePassword";
    }

    @RequestMapping("/doUpdatePassword")
    public String doUpdatePassword(HttpServletRequest request,@RequestParam("currentPassword") String currentPassword
    ,@RequestParam("newPassword") String newPassword
    ,@RequestParam("confirmPassword") String confirmPassword,Model model) {
        User user = (User) request.getSession().getAttribute("user");
        Integer userId=user.getId();
        currentPassword=Md5Util.getMD5String(currentPassword);
        String password = userService.findPassword(userId);
        if(currentPassword.equals(password)){
             if(newPassword.equals(confirmPassword)){
                    newPassword=Md5Util.getMD5String(newPassword);
                    userService.updatePassword(newPassword,userId);
                 model.addAttribute("Message", "密码更改成功");
             }else {
                 model.addAttribute("Message", "两次输入的密码不同");
             }
        }else{
            model.addAttribute("Message", "与原密码不同");
        }
        return "updatePassword";
    }

}
