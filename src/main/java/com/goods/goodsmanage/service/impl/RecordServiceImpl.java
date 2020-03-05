package com.goods.goodsmanage.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goods.goodsmanage.domain.Records;
import com.goods.goodsmanage.mapper.RecordMapper;
import com.goods.goodsmanage.service.GoodsService;
import com.goods.goodsmanage.service.RecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class RecordServiceImpl implements RecordService {
    @Autowired
    private RecordMapper recordMapper;
    @Autowired
    private GoodsService goodsService;

    @Transactional(propagation = Propagation.REQUIRED, readOnly = true)
    public PageInfo<Records> findBySplitPage2(Integer page, Integer size, String keyword) {
        List<Records> list = new ArrayList<Records>();
        PageHelper.startPage(page, size);
        list = recordMapper.findAll();
        for (Records records : list) {
            String goodsName = goodsService.queryGoods(records.getRecordsGoodsId());
            records.setGoodsName(goodsName);
        }
        PageInfo<Records> info = new PageInfo<Records>(list);
        return info;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public Integer addRecord(Records records) {
        Integer rs = recordMapper.saveRecord(records);
        return rs;
    }
}
