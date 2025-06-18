package com.cg.mapper;

import com.cg.entity.Employee;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface EmployeeMapper {
    @Select("select employee_name from yk_employee where employee_id=#{username}")
    String findByEmployeeId(String no);

    List<Employee> employeeList(@Param("employeeName")String employeeName,@Param("phone") String phone,@Param("status") Integer status,@Param("departmentId")Integer departmentId);
    @Select("select * from yk_employee where employee_name=#{employeeName}")
    Employee findEmployeeByName(String employeeName);
@Insert("insert into yk_employee( employee_name, phone,department_id ,hire_date, status, position_id, email,user_id)values (#{employeeName},#{phone},#{departmentId},#{hireDate},#{status},#{positionId},#{email},#{userId}) ")
    void addEmployee(@Param("employeeName")String employeeName,@Param("phone") String phone,@Param("departmentId") Integer departmentId,@Param("hireDate") String hireDate,@Param("status") Integer status,@Param("positionId") Integer positionId,@Param("email") String email,@Param("userId") Integer userId);
 @Select("select * from yk_employee where employee_id=#{employeeId}")
    Employee findEmployeeById(Integer employeeId);
    @Select("select count(*) from yk_employee where employee_name=#{employeeName}")
    int findByName(String employeeName);
  @Update("update yk_employee set employee_name=#{employeeName},phone=#{phone},department_id=#{departmentId},hire_date=#{hireDate},status=#{status},position_id=#{positionId},email=#{email} where employee_id=#{employeeId}")
    void editEmployee(@Param("employeeName")String employeeName,@Param("phone") String phone,@Param("departmentId") Integer departmentId,@Param("hireDate") String hireDate,@Param("status") Integer status,@Param("positionId") Integer positionId,@Param("email") String email,@Param("employeeId") Integer employeeId);
   @Delete("delete from yk_employee where employee_id=#{employeeId}")
    void deleteEmployee(Integer employeeId);
    @Select("select * from yk_employee where user_id=#{userId}")
    Employee findEmployeeByUserId(Integer userId);
    @Select("select count(* )from yk_employee where position_id=#{positionId}")
    int findEmployeeByPosition(Integer positionId);
    @Select("select count(*) from yk_employee where department_id=#{departmentId}")
    int findEmployeeByDepartment(Integer departmentId);
}
