package com.goods.goodsmanage.controller;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageInfo;
import com.goods.goodsmanage.domain.Goods;
import com.goods.goodsmanage.domain.Records;
import com.goods.goodsmanage.service.GoodsService;
import com.goods.goodsmanage.service.RecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/record")
public class recordController {
    @Autowired
    private RecordService recordService;
    @Autowired
    private GoodsService goodsService;

    //分页查询  采用pagehelper插件完成
    @RequestMapping("findBySplitPage")
    @ResponseBody
    public JSONObject findBySplitPage2(Integer page, Integer limit, String keyword) {
        PageInfo<Records> info = recordService.findBySplitPage2(page, limit, keyword);
        JSONObject obj = new JSONObject();
        obj.put("msg", "");
        obj.put("code", 0);
        obj.put("count", info.getTotal());
        obj.put("data", info.getList());
        return obj;
    }

    //添加记录
    @RequestMapping("addRecord")
    @ResponseBody
    public String addRecord(Records records) {
        //查询物品库存
        Goods goods = goodsService.findAllById(records.getRecordsGoodsId());
        Integer num = goods.getGoodsNum();
        Integer applyed = records.getRecordsNum();
        //判断库存是否足够
        if (num - applyed > 0) {
            //添加记录
            Integer rs = recordService.addRecord(records);
            if (rs > 0) {
                //修改物品库存
                goods.setGoodsNum(num - applyed);
                goodsService.update(goods);
                return "success";
            } else {
                return "fail";
            }
        } else {
            return "fail";
        }

    }
}
