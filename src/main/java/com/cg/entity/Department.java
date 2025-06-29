package com.cg.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
public class Department {
    private Integer id;
    private Integer departmentId;
    private String departmentName;
    private String departmentCode;
    private Date createTime;
    private BigDecimal departmentSalary;
}
