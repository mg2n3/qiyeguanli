package com.cg.mapper;

import com.cg.entity.Position;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface PositionMapper {
    List<Position> positionList(@Param("code") String code, @Param("positionName") String positionName, @Param("status") Integer status);

    @Select("select * from yk_position where position_name=#{positionName}")
    Position findPositionByName(String positionName);

    @Insert("insert into yk_position(position_name,code,create_time) values(#{positionName},#{code},now()) ")
    void addposition(@Param("positionName") String positionName, @Param("code") String code);

    @Select("select * from yk_position where position_id=#{positionId}")
    Position findPositionById(Integer positionId);

    @Select("select count(*) from yk_position where position_name=#{positionName} and position_id !=#{positionId}")
    int findByName(String positionName, Integer positionId);

    @Update("update yk_position set position_name=#{positionName},status=#{status},code=#{code} where position_id=#{positionId}")
    void editPosition(@Param("positionName") String positionName, @Param("status") Integer status, @Param("code") String code, @Param("positionId") Integer positionId);

    @Delete("delete from yk_position where position_id=#{positionId}")
    void deleteposition(Integer positionId);

    Position getPositionById(@Param("id") Integer id);

}
