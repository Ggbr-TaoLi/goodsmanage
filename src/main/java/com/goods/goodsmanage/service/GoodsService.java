package com.goods.goodsmanage.service;

import com.github.pagehelper.PageInfo;
import com.goods.goodsmanage.domain.Goods;

import java.util.List;

public interface GoodsService {
    PageInfo<Goods> findBySplitPage(Integer page, Integer size, String keyword);

    Integer update(Goods goods);

    Integer deleteGoods(Integer goodsId);

    Integer addGoods(Goods goods);

    String queryGoods(Integer goodsId);

    Integer findIdByName(String name);

    Goods findAllById(Integer goodsId);

    List<Goods> findAll();
}
