package com.cg.mapper;

import com.cg.entity.Department;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface DepartmentMapper {
    List<Department> departmentList(@Param("departmentName") String departmentName, @Param("departmentCode") String departmentCode);

    @Select("select * from yk_department where department_name=#{departmentName}")
    Department findDepartmentByName(String departmentName);

    @Insert("insert into yk_department(department_name,  department_code,create_time)  values (#{departmentName},#{departmentCode},now())")
    void addDepartment(@Param("departmentName") String departmentName, @Param("departmentCode") String departmentCode);

    @Select("select * from yk_department where department_id=#{departmentId}")
    Department findDepartmentById(Integer departmentId);

    @Select("select count(*) from yk_department where department_name=#{departmentName} and department_id !=#{departmentId} ")
    int findByName(@Param("departmentName") String departmentName, @Param("departmentId") Integer departmentId);

    @Update("update yk_department set department_name = #{departmentName},department_code=#{departmentCode} where department_id =#{departmentId}")
    void editDepartment(@Param("departmentName") String departmentName, @Param("departmentCode") String departmentCode, @Param("departmentId") Integer departmentId);

    @Delete("delete  from  yk_department where department_id=#{departmentId}")
    void deleteDepartment(Integer departmentId);

    Department getDepartmentById(@Param("id") Integer id);

}
