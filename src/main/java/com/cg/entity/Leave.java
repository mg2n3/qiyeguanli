package com.cg.entity;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
public class Leave {
    private Integer leaveId;
    private Integer employeeId;
    private Integer leaveType;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH-mm-ss")
    private Date startDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH-mm-ss")
    private Date endDate;


    private Integer status;
    private String reason;
    private String cheackName;
    private Integer departmentId;
}
