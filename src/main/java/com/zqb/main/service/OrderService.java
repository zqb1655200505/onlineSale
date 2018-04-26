package com.zqb.main.service;

import com.zqb.main.entity.Order;
import com.zqb.main.entity.OrderGoods;
import com.zqb.main.entity.User;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

/**
 * Created by zqb on 2018/4/26.
 * 事务有四大特性（ACID）: 原子性（Atomicity）、一致性（Consistency）、隔离性（Isolation）、持久性（Durability）
 *
 *   TRANSACTION_NONE JDBC 驱动不支持事务
 *   TRANSACTION_READ_UNCOMMITTED 允许脏读、不可重复读和幻读。
 *   TRANSACTION_READ_COMMITTED 禁止脏读，但允许不可重复读和幻读。
 *   TRANSACTION_REPEATABLE_READ 禁止脏读和不可重复读，单运行幻读。
 *   TRANSACTION_SERIALIZABLE 禁止脏读、不可重复读和幻读。
 *
 *      默认情况下，只有来自外部的方法调用才会被AOP代理捕获，也就是，
 *      类内部方法调用本类内部的其他方法并不会引起事务行为，
 *      即使被调用方法使用@Transactional注解进行修饰。
 *
 *      只要在需要事务方法上开启@Transactional注解，当有异常抛出时会自动回滚
 */
@Component
public class OrderService {

    /**
     * @param idList 商品id列表
     * @param numList 与商品对应的商品数目
     * @param buyer 购买者
     * @return
     */
    @Transactional
    public Object addOrder(String[] idList, Integer[] numList, User buyer)
    {
        OrderGoods orderGoods=new OrderGoods();
        Order order=new Order();
        order.setBuyer(buyer);
        order.setOrderTime(new Date());
        for(int i=0;i<idList.length;i++)
        {
            String goodsId=idList[i];
            int goodsNum=numList[i];
        }
        return null;
    }
}
