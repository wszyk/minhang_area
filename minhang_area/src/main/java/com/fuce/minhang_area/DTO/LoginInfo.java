package com.fuce.minhang_area.DTO;

import com.fuce.minhang_area.utils.Constant;

import java.util.Date;

public class LoginInfo {
    private Integer id;
    private String loginname;
    private Integer role;

    private Date issuedAt;
    private Date expirationTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLoginname() {
        return loginname;
    }

    public void setLoginname(String loginname) {
        this.loginname = loginname;
    }

    public Integer getRole() {
        return role;
    }

    public void setRole(Integer role) {
        this.role = role;
    }

    public Date getIssuedAt() {
        return issuedAt;
    }

    public void setIssuedAt(Date issuedAt) {
        this.issuedAt = issuedAt;
    }

    public Date getExpirationTime() {
        return expirationTime;
    }

    public void setExpirationTime(Date expirationTime) {
        this.expirationTime = expirationTime;
    }

    public LoginInfo(Integer id, String loginname, Integer role, Date issuedAt) {
        this.id = id;
        this.loginname = loginname;
        this.role = role;
        this.issuedAt = issuedAt;

        long issuedAtTimestamp = issuedAt.getTime();//当前时间戳
        long expirationTimestamp = issuedAtTimestamp + Constant.expireDuration *60*1000;//过期时间  分钟转为毫秒
        this.expirationTime = new Date(expirationTimestamp);//设置过期时间


    }
}
