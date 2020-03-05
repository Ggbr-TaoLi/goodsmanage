package com.goods.goodsmanage.controller;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageInfo;
import com.goods.goodsmanage.domain.Goods;
import com.goods.goodsmanage.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/goods")
public class goodsController {
    @Autowired
    private GoodsService goodsService;

    //分页查询  采用pagehelper插件完成
    @RequestMapping("findBySplitPage")
    @ResponseBody
    public JSONObject findBySplitPage(Integer page, Integer limit, String keyword) {
        PageInfo<Goods> info = goodsService.findBySplitPage(page, limit, keyword);
        JSONObject obj = new JSONObject();
        obj.put("msg", "");
        obj.put("code", 0);
        obj.put("count", info.getTotal());
        obj.put("data", info.getList());
        return obj;
    }

    //查询所有物品
    @RequestMapping("findAll")
    @ResponseBody
    public List<Goods> findAll() {
        List<Goods> list = goodsService.findAll();
        return list;
    }

    //修改
    @RequestMapping("updateGoods")
    @ResponseBody
    public String updateGoods(Goods goods) {
        Integer rs = goodsService.update(goods);
        if (rs > 0) {
            return "success";
        } else {
            return "fail";
        }
    }

    //删除
    @RequestMapping("delete")
    @ResponseBody
    public String deleteGoods(Integer goodsId) {
        //查询物品库存
        Goods goods = goodsService.findAllById(goodsId);
        Integer num = goods.getGoodsNum();
        if (num == 0) {
            Integer rs = goodsService.deleteGoods(goodsId);
            if (rs > 0) {
                return "success";
            } else {
                return "fail";
            }
        } else {
            return "fail";
        }
    }

    //添加
    @RequestMapping("addGoods")
    @ResponseBody
    public String addGoods(Goods goods) {
        Integer rs = 0;
        //判断有无同名物品
        String name = goods.getGoodsName();
        if (goodsService.findIdByName(name) != null) {
            Integer num = goodsService.findAllById(goodsService.findIdByName(name)).getGoodsNum();
            goods.setGoodsNum(goods.getGoodsNum() + num);
            rs = goodsService.update(goods);//修改数据
        } else {
            rs = goodsService.addGoods(goods);//添加数据
        }
        if (rs > 0) {
            return "success";
        } else {
            return "fail";
        }
    }
}
