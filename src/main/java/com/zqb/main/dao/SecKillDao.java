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

    int deleteByGoodsId(@Param("goodsId") String goodsId);


    Seckill getSecKillByPrimaryKey(@Param("id") String id);

    int updateByPrimaryKey(Seckill seckill);
}
