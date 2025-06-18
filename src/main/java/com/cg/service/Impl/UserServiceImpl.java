package com.cg.service.Impl;

import com.cg.service.UserService;
import com.cg.entity.User;
import com.cg.mapper.UserMapper;
import com.cg.util.Md5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;
    @Override
    public User login(String username,String password) {
        password= Md5Util.getMD5String(password);
        return userMapper.login(username,password);
    }

    @Override
    public void addUser(String employeeName, String password, String email, Integer role) {
         userMapper.addUser(employeeName,password,email,role);
    }

    @Override
    public void deleteUser(Integer Id) {
        userMapper.deleteUser(Id);
    }

    @Override
    public String findPassword(Integer userId) {
        return userMapper.findPassword(userId);
    }

    @Override
    public void updatePassword(String newPassword,Integer userId) {
        userMapper.updatePassword(newPassword,userId);
    }


}
