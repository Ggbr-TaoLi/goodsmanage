package com.goods.goodsmanage.service.impl;

import com.goods.goodsmanage.mapper.TypeMapper;
import com.goods.goodsmanage.service.TypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class TypeServiceImpl implements TypeService {

    @Autowired
    private TypeMapper typeMapper;

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public String queryType(int id) {
        String goodsType = typeMapper.queryType(id);
        return goodsType;
    }

}
