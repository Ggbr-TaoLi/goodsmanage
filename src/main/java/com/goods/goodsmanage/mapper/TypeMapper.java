package com.goods.goodsmanage.mapper;

import org.springframework.stereotype.Repository;

@Repository

public interface TypeMapper {
//        @Select("select * from type where type_Id = #{id}")
    String queryType(int id);
}
