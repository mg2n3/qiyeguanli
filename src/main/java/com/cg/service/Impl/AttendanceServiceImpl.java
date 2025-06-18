package com.cg.service.Impl;

import com.cg.entity.Attendance;
import com.cg.mapper.AttendanceMapper;
import com.cg.service.AttendanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AttendanceServiceImpl implements AttendanceService {
    @Autowired
    AttendanceMapper attendanceMapper;

    @Override
    public void addAttendance(String date, String checkInTime, String checkOutTime, Integer status, Integer employeeId,Integer departmentId) {
        attendanceMapper.addAttendance(date,checkInTime,checkOutTime,status,employeeId,departmentId);
    }

    @Override
    public Attendance findAttendance(String date, Integer employeeId) {
        return attendanceMapper.findAttendance(date,employeeId);
    }

    @Override
    public List<Attendance> attendanceList(String date, Integer attendanceId,Integer departmentId) {
        return attendanceMapper.attendanceList(date,attendanceId,departmentId);
    }

}
