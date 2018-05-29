package com.zqb.main.service;

import com.zqb.main.dao.GoodsDao;
import com.zqb.main.dao.OrderDao;
import com.zqb.main.dao.OrderGoodsDao;
import com.zqb.main.dao.SecKillDao;
import com.zqb.main.dto.AjaxMessage;
import com.zqb.main.dto.MsgType;
import com.zqb.main.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

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

    @Autowired
    private GoodsDao goodsDao;

    @Autowired
    private OrderDao orderDao;

    @Autowired
    private OrderGoodsDao orderGoodsDao;

    @Autowired
    private SecKillDao secKillDao;

    /**
     * @param goodsIdList 此次订单商品id列表
     * @param goodsNumList 与商品对应的商品数目
     * @param buyer 购买者
     * @return
     */
    @Transactional
    public Object addOrder(List<String> goodsIdList, List<Integer> goodsNumList, User buyer, boolean isSeckill) throws Exception {

        Order order=new Order();
        order.setBuyer(buyer);
        order.setOrderTime(new Date());
        int totalNum=0;
        double totalPrice=0;
        for(int i=0;i<goodsNumList.size();i++)
        {
            totalNum+=goodsNumList.get(i);
            String goodsId=goodsIdList.get(i);
            if(isSeckill)//获取秒杀价格
            {
                double price=secKillDao.getSecKillGoodsPrice(goodsId);
                totalPrice+=price;
            }
            else
            {
                Goods goods=goodsDao.getGoodsByPrimaryKey(goodsId);
                totalPrice+=goods.getGoodsPrice();
            }

        }
        order.setGoodsNum(totalNum);
        order.setOrderPrice(totalPrice);
        order.preInsert();
        if(orderDao.addOrder(order)>0)
        {
            for(int i=0;i<goodsNumList.size();++i)
            {
                OrderGoods orderGoods=new OrderGoods();
                String goodsId=goodsIdList.get(i);
                int goodsNum=goodsNumList.get(i);
                Goods goods=goodsDao.getGoodsByPrimaryKey(goodsId);
                //减库存
                if(goods.getGoodsNum()<goodsNum)
                {
                    return new AjaxMessage().Set(MsgType.Error,"超库存",null);
                }
                goods.setGoodsNum(goods.getGoodsNum()-goodsNum);
                if(goodsDao.updateByPrimaryKey(goods)>0)
                {
                    //生成订单详情
                    orderGoods.setGoods(goods);
                    orderGoods.setGoodsNum(goodsNum);
                    orderGoods.setSeckill(false);
                    orderGoods.setOrder(order);
                    orderGoods.preInsert();
                    orderGoods.setSeckill(isSeckill);
                    if(orderGoodsDao.add(orderGoods)<=0)//通过抛异常回滚
                    {
                        throw new Exception("has exception and begin rollBack!!!");
                    }
                }
                else
                {
                    throw new Exception("has exception and begin rollBack!!!");
                }
            }
            return new AjaxMessage().Set(MsgType.Success,"购买商品成功",null);
        }
        else//通过抛异常回滚
        {
            throw new Exception("has exception and begin rollBack!!!");
        }
    }


    public List<Order> getConsumerOrder(Order order)
    {
        return orderDao.getOrderByBuyer(order);
    }

    public int getConsumerOrderCount(String userId)
    {
        return orderDao.getConsumerOrderCount(userId);
    }

    public List<OrderGoods> getOrderDetail(String orderId)
    {
        return orderGoodsDao.getListByOrderId(orderId);
    }


    public List<OrderGoods> getSellerOrder(OrderGoods orderGoods,String sellerId)
    {
        return orderGoodsDao.getSellerOrder(orderGoods,sellerId);
    }


    public int getSellerOrderCount(String sellerId)
    {
        return orderGoodsDao.getSellerOrderCount(sellerId);
    }




}
