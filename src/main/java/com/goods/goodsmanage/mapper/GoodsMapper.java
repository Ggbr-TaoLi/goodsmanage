package com.goods.goodsmanage.mapper;

import com.goods.goodsmanage.domain.Goods;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GoodsMapper {

    List<Goods> findAll();

    Integer updateGoods(Goods goods);

    Integer deleteGoods(Integer goods);

    Integer saveGoods(Goods goods);

    Goods findGoodsById(Integer goodsId);

    Integer findId(String name);
}
