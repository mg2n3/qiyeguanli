package com.cg.service;

import com.cg.entity.Leave;

import java.util.List;

public interface LeaveService {
    List<Leave> leaveList(Integer leaveType, Integer status,Integer employeeId,Integer departmentId);

    void editLeave(Integer leaveId, Integer status, String username);

    Leave findLeaveById(Integer leaveId);

    void addLeave(Integer employeeId, Integer leaveType, String startDate, String endDate, String reason, Integer status,Integer departmentId);

    void deleteLeave(Integer leaveId);
}
