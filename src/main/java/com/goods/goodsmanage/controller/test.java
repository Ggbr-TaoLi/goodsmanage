package com.goods.goodsmanage.controller;

import com.goods.goodsmanage.service.TypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class test {
    @Autowired
    private TypeService typeService;


    @RequestMapping("/index")
   @ResponseBody
    public String jspIndex(){
        return "index";

    }
}
