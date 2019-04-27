package com.fuce.minhang_area.dao;

import com.fuce.minhang_area.pojo.User;
import com.github.pagehelper.Page;
import org.apache.ibatis.annotations.Param;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    User getById(@Param("id") Integer id);

    Page<User> selectWithPage();

    User getByLoginname(@Param("loginname") String loginname);

    Page<User> searchWithPage(@Param("keyword") String keyword);
}