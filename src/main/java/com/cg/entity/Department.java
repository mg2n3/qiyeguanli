package com.cg.entity;

import lombok.Data;

import java.util.Date;

@Data
public class Department {
    private Integer departmentId;
    private String departmentName;
    private String departmentCode;
    private Date createTime;
}
