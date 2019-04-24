package com.fuce.minhang_area.controller;

import com.alibaba.fastjson.JSON;
import com.fuce.minhang_area.DTO.LoginInfo;
import com.fuce.minhang_area.DTO.UserAddUpDTO;
import com.fuce.minhang_area.exception.BackendClientException;
import com.fuce.minhang_area.pojo.User;
import com.fuce.minhang_area.service.SysUserService;
import com.fuce.minhang_area.utils.AES;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

@RestController
@RequestMapping("/sys/user")
@Validated
@CrossOrigin
public class SysUserController {
    @Autowired
    private SysUserService sysUserService;
    //注入aes秘钥
    @Value("${token.aes.secret}")
    private String aesSecret;

    @GetMapping("/getById")
    public User getById(@RequestParam Integer id){
        User user = sysUserService.getById(id);
        return user;
    }
    @GetMapping("/getWithPage")
    public PageInfo getWithPage(@RequestParam(required = false,defaultValue = "1")Integer pageNum){
        Page<User>users = sysUserService.getWithPage(pageNum);
        PageInfo<User> pageInfo = users.toPageInfo();
        return pageInfo;
    }
    @PostMapping("/add")
    public Integer add(@RequestBody UserAddUpDTO userAddUpDTO){
        Integer userId = sysUserService.add(userAddUpDTO);
        return userId;
    }
    @PostMapping("/update")
    public void update(@RequestBody UserAddUpDTO userAddUpDTO){
        sysUserService.update(userAddUpDTO);
    }
    @GetMapping("/login")
    public String login(String loginname, String password) throws Exception {
        User user = sysUserService.getByUsername(loginname);
        if (user == null) {
            throw new BackendClientException("user isn't exist");
        }
        if (!user.getPassword().equals(password)) {
            throw new BackendClientException("password isn't match");
        }
        LoginInfo loginInfo = new LoginInfo(user.getId(), user.getLoginname(), user.getRole(), new Date());
        String loginInfoStr = JSON.toJSONString(loginInfo);//对象转换为字符串
        // String token = Base64.getEncoder().encodeToString(loginInfoStr.getBytes());//Base64转码
        String token = AES.encrypt(loginInfoStr,aesSecret);//AES加密
        return token;
    }
    @PostMapping("/delete")
    public void delete(@RequestParam Integer id) {
        sysUserService.delete(id);
    }

}
