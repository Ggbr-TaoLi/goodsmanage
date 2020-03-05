package com.goods.goodsmanage.domain;

import java.sql.Date;

public class Records {
    private Integer recordsId;
    private Integer recordsGoodsId;
    private String goodsName;
    private String recordsName;
    private Date recordsDate;
    private Integer recordsNum;
    private String recordsDesc;

    public Integer getRecordsId() {
        return recordsId;
    }

    public void setRecordsId(Integer recordsId) {
        this.recordsId = recordsId;
    }

    public Integer getRecordsGoodsId() {
        return recordsGoodsId;
    }

    public void setRecordsGoodsId(Integer recordsGoodsId) {
        this.recordsGoodsId = recordsGoodsId;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public String getRecordsName() {
        return recordsName;
    }

    public void setRecordsName(String recordsName) {
        this.recordsName = recordsName;
    }

    public Date getRecordsDate() {
        return recordsDate;
    }

    public void setRecordsDate(Date recordsDate) {
        this.recordsDate = recordsDate;
    }

    public Integer getRecordsNum() {
        return recordsNum;
    }

    public void setRecordsNum(Integer recordsNum) {
        this.recordsNum = recordsNum;
    }

    public String getRecordsDesc() {
        return recordsDesc;
    }

    public void setRecordsDesc(String recordsDesc) {
        this.recordsDesc = recordsDesc;
    }
}
