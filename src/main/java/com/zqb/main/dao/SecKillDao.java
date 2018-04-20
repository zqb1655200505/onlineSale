package com.zqb.main.dao;

import com.zqb.main.entity.Seckill;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zqb on 2018/4/20.
 */
@Repository
public interface SecKillDao {

    int add(Seckill seckill);

    List<Seckill> getMySecKillGoods(Seckill seckill);

    int getMySecKillGoodsCount(Seckill seckill);
}