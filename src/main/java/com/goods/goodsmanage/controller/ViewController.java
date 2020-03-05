package com.goods.goodsmanage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/view")
public class ViewController {
    @RequestMapping("index")
    public String toIndex() {
        return "index";
    }

    @RequestMapping("apply")
    public String toAddGoods() {
        return "apply";
    }

    @RequestMapping("manage")
    public String toManage() {
        return "manage";
    }
}
