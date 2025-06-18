package com.cg.service;

import com.cg.entity.Attendance;

import java.util.List;

public interface AttendanceService {
    void addAttendance(String date, String checkInTime, String checkOutTime, Integer status, Integer employeeId,Integer departmentId);

    Attendance findAttendance(String date, Integer employeeId);

    List<Attendance> attendanceList(String date,Integer attendanceId,Integer departmentId);
}
