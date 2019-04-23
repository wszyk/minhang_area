package com.area.server.minhangareaserver;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.area.server.minhangareaserver.dao")
public class MinhangareaserverApplication {

    public static void main(String[] args) {
        SpringApplication.run(MinhangareaserverApplication.class, args);
    }

}
