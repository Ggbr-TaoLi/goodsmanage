package com.goods.goodsmanage.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.goods.goodsmanage.domain.Goods;
import com.goods.goodsmanage.mapper.GoodsMapper;
import com.goods.goodsmanage.service.GoodsService;
import com.goods.goodsmanage.service.TypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class GoodsServiceImpl implements GoodsService {
    @Autowired
    private GoodsMapper goodsMapper;
    @Autowired
    private TypeService typeService;

    @Transactional(propagation = Propagation.REQUIRED, readOnly = true)
    public PageInfo<Goods> findBySplitPage(Integer page, Integer size, String keyword) {
        List<Goods> list = new ArrayList<Goods>();
        PageHelper.startPage(page, size);
        list = goodsMapper.findAll();
//        Type type = new Type();
        for (Goods goods : list) {
            String goodsType = typeService.queryType(goods.getGoodsTypeID());
//              type.setId(goods.getType().getId());
//              type.setGoodsType(goodsType);
//              goods.setType(type);
            goods.setGoodsType(goodsType);
        }
        PageInfo<Goods> info = new PageInfo<Goods>(list);
        return info;
    }
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public String queryGoods(Integer goodsId) {
        String goodsName = goodsMapper.findGoodsById(goodsId).getGoodsName();
        return goodsName;
    }
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public Goods findAllById(Integer goodsId) {
        Goods goods = goodsMapper.findGoodsById(goodsId);
        return goods;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public Integer update(Goods goods) {
        Integer rs = goodsMapper.updateGoods(goods);
        return rs;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public Integer deleteGoods(Integer goodsId) {
        Integer rs = goodsMapper.deleteGoods(goodsId);
        return rs;
    }
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public Integer addGoods(Goods goods) {
        Integer rs = goodsMapper.saveGoods(goods);
        return rs;
    }
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public Integer findIdByName(String name) {
        Integer goodsId = goodsMapper.findId(name);
        return goodsId;
    }
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    @Override
    public List<Goods> findAll(){
        List<Goods> list = goodsMapper.findAll();
        return  list;
    }
}
