package com.goods.goodsmanage.domain;


import java.io.Serializable;
import java.sql.Date;

public class Goods implements Serializable {
    private Integer goodsId;
    private String goodsName;
    private String goodsUnit;
    private Integer goodsTypeID;
    private Integer goodsNum;
//    private Type type;
    private String goodsDesc;
    private Date goodsDate;
    private String goodsType;

    public Integer getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(Integer goodsId) {
        this.goodsId = goodsId;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public String getGoodsUnit() {
        return goodsUnit;
    }

    public void setGoodsUnit(String goodsUnit) {
        this.goodsUnit = goodsUnit;
    }

    public Integer getGoodsTypeID() {
        return goodsTypeID;
    }

    public void setGoodsTypeID(Integer goodsTypeID) {
        this.goodsTypeID = goodsTypeID;
    }

    public Integer getGoodsNum() {
        return goodsNum;
    }

    public void setGoodsNum(Integer goodsNum) {
        this.goodsNum = goodsNum;
    }

    public String getGoodsDesc() {
        return goodsDesc;
    }

    public void setGoodsDesc(String goodsDesc) {
        this.goodsDesc = goodsDesc;
    }

    public Date getGoodsDate() {
        return goodsDate;
    }

    public void setGoodsDate(Date goodsDate) {
        this.goodsDate = goodsDate;
    }

    public String getGoodsType() {
        return goodsType;
    }

    public void setGoodsType(String goodsType) {
        this.goodsType = goodsType;
    }
//
//    public Goods() {
//        super();
//    }
//
//    public Goods(Integer goodsId, String goodsName, Type type,
//                 Date goodsDate, String goodsUnit, int goodsNum, String goodsDesc) {
//        super();
//        this.goodsId = goodsId;
//        this.goodsName = goodsName;
//        this.goodsDate = goodsDate;
//        this.goodsNum = goodsNum;
//        this.type = type;
//        this.goodsUnit = goodsUnit;
//        this.goodsDesc = goodsDesc;
//    }

}
