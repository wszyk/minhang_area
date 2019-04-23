package com.area.server.minhangareaserver.dao;

import com.area.server.minhangareaserver.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);



    List<Map<String, Object>> getDataList(@Param("page")  Integer page,
                                          @Param("pageSize")  Integer pageSize);

    Integer getDataCount();

    void saveData(User user);

    void editData(User user);

    User getDataById(int dataId);

    void deleteDataById(int id);

    User getUserByName(String loginName);
}