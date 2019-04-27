package com.fuce.minhang_area.service;

import com.fuce.minhang_area.DTO.UserAddUpDTO;
import com.fuce.minhang_area.pojo.User;
import com.github.pagehelper.Page;

public interface SysUserService {
    User getById(Integer id);

    Integer add(UserAddUpDTO userAddUpDTO);

    void update(UserAddUpDTO userAddUpDTO);

    User getByUsername(String loginname);


    void delete(Integer id);

    Page<User> searchWithPage(String keyword);
}
