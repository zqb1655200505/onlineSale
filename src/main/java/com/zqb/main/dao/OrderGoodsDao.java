package com.zqb.main.dao;

import com.zqb.main.entity.OrderGoods;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zqb on 2018/4/27.
 */
@Repository
public interface OrderGoodsDao {
    int add(OrderGoods orderGoods);

    List<OrderGoods> getListByOrderId(@Param("orderId") String orderId);

    List<OrderGoods> getSellerOrder(@Param("orderGoods") OrderGoods orderGoods,
                                    @Param("userId") String userId);

    int getSellerOrderCount(@Param("userId") String userId);
}
