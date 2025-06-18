package com.cg.entity;

import lombok.Data;

import java.util.Date;
@Data
public class Attendance {
    private Integer attendanceId;
    private Integer employeeId;
    private Date date;
    private Date checkInTime;
    private Date checkOutTime;
    private Integer state;
    private Integer departmentId;
}
