package com.goods.goodsmanage.service;

import com.github.pagehelper.PageInfo;
import com.goods.goodsmanage.domain.Records;

public interface RecordService {
    PageInfo<Records> findBySplitPage2(Integer page, Integer size, String keyword);
    Integer addRecord(Records records);
}
