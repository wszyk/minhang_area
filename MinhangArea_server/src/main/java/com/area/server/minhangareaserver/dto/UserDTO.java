package com.area.server.minhangareaserver.dto;

import com.area.server.minhangareaserver.pojo.User;

public class UserDTO extends User {
    private String areaname;

    public String getAreaname() {
        return areaname;
    }

    public void setAreaname(String areaname) {
        this.areaname = areaname;
    }
}
