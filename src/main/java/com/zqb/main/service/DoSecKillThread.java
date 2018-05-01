package com.zqb.main.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.zqb.main.dto.CurrentSecKill;
import com.zqb.main.dto.KafkaMsg;
import com.zqb.main.entity.Seckill;
import com.zqb.main.entity.User;
import com.zqb.main.utils.KafkaConsumerUtils;
import com.zqb.main.utils.WebSocketListen;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

/**
 * Created by zqb on 2018/5/1.
 */

public class DoSecKillThread extends Thread{

    private static boolean flag=true;


    @Autowired
    private OrderService orderService;

    @Autowired
    private UserService userService;

    @Override
    public void run() {
        while (flag)
        {
            List<KafkaMsg> list=KafkaConsumerUtils.getRowMessage("secKill");
            if(list!=null)
            {
                for(KafkaMsg item:list)
                {
                    String record=item.getValue();
                    JSONObject json= JSON.parseObject(record);
                    String userId=json.getString("userId");
                    String goodsId=json.getString("goodsIs");

                    Lock lock = new ReentrantLock();
                    lock.lock(); //注意这个地方,lock会锁住此部分代码区
//=====================================================================================
                    List<Seckill> seckills= CurrentSecKill.getSeckillList();
                    for(Seckill seckill:seckills)
                    {
                        if(seckill.getGoods().getId().equals(goodsId))//秒杀商品存在
                        {
                            if(seckill.getRestNum()>0)//尚有余量，执行购买操作
                            {
                                List<String> idList=new ArrayList<String>();
                                idList.add(goodsId);
                                List<Integer> numList=new ArrayList<Integer>();
                                numList.add(1);
                                User user=userService.getByPrimaryKey(userId);
                                try {
                                    orderService.addOrder(idList,numList,user,true);
                                } catch (Exception e) {
                                    e.printStackTrace();
                                    try {
                                        WebSocketListen.sendStrMessage(userId,"秒杀失败");
                                    } catch (IOException e1) {
                                        e1.printStackTrace();
                                    }
                                }
                            }
                            else//无余量，从秒杀列表删除，返回秒杀失败
                            {
                                try {
                                    WebSocketListen.sendStrMessage(userId,"秒杀失败");
                                } catch (IOException e) {
                                    e.printStackTrace();
                                }
                            }
                        }
                    }
//==========================================================================================
                    lock.unlock();
                }
            }
        }
    }

    public void setFlag(boolean status)
    {
        flag=status;
    }
}
