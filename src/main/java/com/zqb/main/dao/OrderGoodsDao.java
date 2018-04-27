package com.zqb.main.dao;

import com.zqb.main.entity.OrderGoods;
import org.springframework.stereotype.Repository;

/**
 * Created by zqb on 2018/4/27.
 */
@Repository
public interface OrderGoodsDao {
    int add(OrderGoods orderGoods);
}
