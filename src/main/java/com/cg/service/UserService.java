package com.cg.service;

import com.cg.entity.User;

public interface UserService {
    User login(String username, String password);

    void addUser(String employeeName, String password, String email, Integer role);

    void deleteUser(Integer Id);

    String findPassword(Integer userId);

    void updatePassword(String newPassword,Integer userId);
}
