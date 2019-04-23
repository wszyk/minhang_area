package com.area.server.minhangareaserver.dao;

import com.area.server.minhangareaserver.pojo.Area;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AreaMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Area record);

    int insertSelective(Area record);

    Area selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Area record);

    int updateByPrimaryKey(Area record);

    List<Area> getAllDataList();

    Area getDataById(Integer areaid);

    Integer getDataCount();

    List<Area> getDataList(@Param("page") int page,@Param("pageSize") int pageSize);

    void saveData(Area area);

    void editData(Area area);

    void deleteDataById(int id);
}