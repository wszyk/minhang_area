package com.area.server.minhangareaserver.service.impl;

import com.area.server.minhangareaserver.dao.UserMapper;
import com.area.server.minhangareaserver.pojo.User;
import com.area.server.minhangareaserver.service.SysUserService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional
@EnableAutoConfiguration
public class SysUserServiceImpl implements SysUserService {

    @Autowired
    private UserMapper userMapper;


    @Override
    public List<Map<String, Object>> getDataList(Integer page, Integer pageSize) {
        return userMapper.getDataList(page, pageSize);
    }

    @Override
    public Integer getDataCount() {
        return userMapper.getDataCount();
    }

    /**
     * 保存用户
     * @param user
     */
    @Override
    public void saveData(User user) {
        userMapper.saveData(user);
    }

    @Override
    public void editData(User user) {
        userMapper.editData(user);
    }

    @Override
    public User getDataById(int dataId) {
        return userMapper.getDataById(dataId);
    }

    @Override
    public void deleteDataById(int id) {
        userMapper.deleteDataById(id);
    }

    @Override
    public User getUserByName(String loginName) {
        return userMapper.getUserByName(loginName);
    }
}
