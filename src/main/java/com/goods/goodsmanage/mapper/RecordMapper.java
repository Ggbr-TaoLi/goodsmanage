package com.goods.goodsmanage.mapper;

import com.goods.goodsmanage.domain.Records;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RecordMapper {

    List<Records> findAll();
    Integer saveRecord(Records records);
}
