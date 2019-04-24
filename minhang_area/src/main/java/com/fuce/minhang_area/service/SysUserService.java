package com.fuce.minhang_area.service;

import com.fuce.minhang_area.DTO.UserAddUpDTO;
import com.fuce.minhang_area.pojo.User;
import com.github.pagehelper.Page;

import java.util.List;

public interface SysUserService {
    User getById(Integer id);

    Page<User> getWithPage(Integer pageNum);

    Integer add(UserAddUpDTO userAddUpDTO);

    void update(UserAddUpDTO userAddUpDTO);

    User getByUsername(String loginname);


    void delete(Integer id);
}
