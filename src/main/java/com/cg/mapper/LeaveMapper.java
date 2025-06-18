package com.cg.mapper;

import com.cg.entity.Leave;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface LeaveMapper {

    List<Leave> leaveList(@Param("leaveType")Integer leaveType,@Param("status") Integer status,@Param("employeeId") Integer employeeId,@Param("departmentId") Integer departmentId);
    @Update("update yk_leave set status=#{status},check_name=#{username} where leave_id=#{leaveId}")
    void editLeave(@Param("leaveId")Integer leaveId,@Param("status") Integer status,@Param("username") String username);
    @Select("select * from yk_leave where leave_id=#{leaveId}")
    Leave findLeaveById(Integer leaveId);
    @Insert("INSERT into yk_leave(employee_id, leave_type, start_date, end_date, reason, status,department_id) values (#{employeeId},#{leaveType},#{startDate},#{endDate},#{reason},#{status},#{departmentId})")
    void addLeave(@Param("employeeId")Integer employeeId,@Param("leaveType") Integer leaveType,@Param("startDate") String startDate,@Param("endDate") String endDate,@Param("reason") String reason,@Param("status") Integer status,@Param("departmentId") Integer departmentId);
  @Delete("delete from yk_leave where leave_id=#{leaveId}")
    void deleteLeave(Integer leaveId);
}
