package com.cg.entity;

import lombok.Data;

import java.util.Date;
@Data
public class Employee {
    private Integer employeeId;
    private String employeeName;
    private Integer userId;
    private String phone;
    private Integer departmentId;
    private Date hireDate;//入职日期
    private Integer status;
    private Integer positionId;
    private String email;
}
