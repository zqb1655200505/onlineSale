package com.zqb.main.dao;

import com.zqb.main.entity.Order;
import com.zqb.main.entity.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zqb on 2018/4/26.
 */
@Repository
public interface OrderDao {

    int addOrder(Order order);

    Order getByPrimaryKey(@Param("id") String id);

    List<Order> getOrderByBuyer(Order order);

    List<Order> getSellerOrder(@Param("order") Order order,
                                @Param("userId") String userId);

    int getSellerOrderCount(@Param("userId") String userId);
}
