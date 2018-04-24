package com.zqb.main.dao;

import com.zqb.main.entity.Goods;
import com.zqb.main.entity.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zqb on 2018/4/17.
 */
@Repository
public interface GoodsDao {

    List<Goods> getGoodsByUser(Goods goods);

    int updateByPrimaryKey(Goods goods);

    int addGoods(Goods goods);

    int getCountByUser(Goods goods);

    Goods getGoodsByPrimaryKey(@Param("id") String id);

    List<Goods> getAllGoods(Goods goods);

    int getGoodsCount();

    int deleteByPrimaryKey(@Param("id") String id);

    int removeByIdList(List<String> idList);

    int changeStatus(@Param("goodsId") String goodsId,
                     @Param("status") boolean status);

    List<Goods> getGoodsByIdList(List<String> idList);
}
