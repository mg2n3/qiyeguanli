package com.cg.mapper;

import com.cg.entity.User;
import org.apache.ibatis.annotations.*;
import org.springframework.web.bind.annotation.RequestParam;

@Mapper
public interface UserMapper {
    @Select("select * from yk_user where username=#{username} and password=#{password}")
    User login(@Param("username") String username, @Param("password") String password);
@Insert("insert into yk_user(username, password, email, role)values (#{employeeName},#{password},#{email},#{role})")
    void addUser(@Param("employeeName") String employeeName,@Param("password") String password,@Param("email") String email,@Param("role") Integer role);
    @Delete("delete from yk_user where id=#{id}")
    void deleteUser(Integer id);

    @Select("select password from yk_user where id=#{userId}")
    String findPassword(Integer userId);
    @Update("update yk_user set password=#{newPassword}  where  id=#{userId}")
    void updatePassword(@Param("newPassword")String newPassword,@Param("userId") Integer userId);
}
