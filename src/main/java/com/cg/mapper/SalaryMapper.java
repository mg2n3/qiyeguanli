package com.cg.mapper;

import com.cg.entity.Salary;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface SalaryMapper {
    // 移除所有 SQL 注解，只保留方法声明

    int countByPositionAndDepartment(
            @Param("positionId") Integer positionId,
            @Param("departmentId") Integer departmentId
    );

    // Mapper 接口中改为：
    int countOtherByPositionAndDepartment(
            @Param("salaryId") Integer salaryId,
            @Param("positionId") Integer positionId,
            @Param("departmentId") Integer departmentId
    );


    List<Salary> findByPositionAndDepartment(
            @Param("position") String position,
            @Param("department") String department
    );

    int addSalary(Salary salary);
    void deleteSalary(@Param("salaryId") Integer salaryId);
    Salary getSalaryById(@Param("salaryId") Integer salaryId);

    List<Salary> getSalariesByPositionAndDepartment(
            @Param("positionId") Integer positionId,
            @Param("departmentId") Integer departmentId
    );

    // SalaryMapper.java
    void updateSalary(Salary salary); // 确保接收完整对象
    List<Salary> getAllSalaries();
}
