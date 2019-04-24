package com.fuce.minhang_area;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.fuce.minhang_area.dao")
public class MinhangAreaApplication {

    public static void main(String[] args) {
        SpringApplication.run(MinhangAreaApplication.class, args);
    }

}
