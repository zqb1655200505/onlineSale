package com.zqb.main.service;

import com.zqb.main.dao.GoodsDao;
import com.zqb.main.entity.Goods;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by zqb on 2018/4/17.
 */
@Component
public class GoodsService {

    @Autowired
    private GoodsDao goodsDao;

    public List<Goods> getGoodsByUserId(String userId)
    {
        return goodsDao.getGoodsByUserId(userId);
    }
}
