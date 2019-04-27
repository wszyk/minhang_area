package com.fuce.minhang_area.service.impl;

import com.fuce.minhang_area.DTO.UserAddUpDTO;
import com.fuce.minhang_area.dao.UserMapper;
import com.fuce.minhang_area.pojo.User;
import com.fuce.minhang_area.service.SysUserService;
import com.github.pagehelper.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
@EnableAutoConfiguration
public class SysUserServiceImpl implements SysUserService {

    @Autowired
    private UserMapper userMapper;

    @Value("${user.pageSize}")
    private Integer userPageSize;
    @Override
    public User getById(Integer id) {
        return userMapper.getById(id);
    }

    //封装添加商品的方法
    private User setUserWithDTO(UserAddUpDTO userAddUpDTO){
        User user = new User();
        user.setId(userAddUpDTO.getId());
        user.setDescription(userAddUpDTO.getDescription());
        user.setRole(userAddUpDTO.getRole());
        user.setLoginname(userAddUpDTO.getLoginname());
        user.setPassword(userAddUpDTO.getPassword());
        return user;
    }

    @Override
    public Integer add(UserAddUpDTO userAddUpDTO) {
        User user = setUserWithDTO(userAddUpDTO);
        userMapper.insert(user);
        return user.getId();
    }

    @Override
    public void update(UserAddUpDTO userAddUpDTO) {
        User user = setUserWithDTO(userAddUpDTO);
        user.setId(userAddUpDTO.getId());
        userMapper.updateByPrimaryKey(user);
    }

    @Override
    public User getByUsername(String loginname) {
        return userMapper.getByLoginname(loginname);
    }

    @Override
    public void delete(Integer id) {
        userMapper.deleteByPrimaryKey(id);
    }

    @Override
    public Page<User> searchWithPage(String keyword) {
        return userMapper.searchWithPage(keyword);
    }

}
