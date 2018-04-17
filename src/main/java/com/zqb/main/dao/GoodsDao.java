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

    List<Goods> getGoodsByUserId(@Param("userId") String userId);
}
