package com.area.server.minhangareaserver.service;

import com.area.server.minhangareaserver.pojo.User;

import java.util.List;
import java.util.Map;

public interface SysUserService {

    List<Map<String, Object>> getDataList(Integer page, Integer pageSize);
    Integer getDataCount();

    void saveData(User user);

    void editData(User user);

    User getDataById(int dataId);

    void deleteDataById(int id);

    User getUserByName(String loginName);
}
