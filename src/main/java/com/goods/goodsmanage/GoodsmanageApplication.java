package com.goods.goodsmanage;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.goods.goodsmanage.mapper")
public class GoodsmanageApplication {

    public static void main(String[] args) {
        SpringApplication.run(GoodsmanageApplication.class, args);
    }

}
