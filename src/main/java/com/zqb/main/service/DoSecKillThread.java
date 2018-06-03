package com.zqb.main.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.zqb.config.MyApplicationContext;
import com.zqb.main.dto.AjaxMessage;
import com.zqb.main.dto.CurrentSecKill;
import com.zqb.main.dto.KafkaMsg;
import com.zqb.main.dto.MsgType;
import com.zqb.main.entity.Seckill;
import com.zqb.main.entity.User;
import com.zqb.main.utils.KafkaConsumerUtils;
import com.zqb.main.utils.WebSocketListen;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

/**
 * Created by zqb on 2018/5/1.
 *
 */

public class DoSecKillThread extends Thread{

    private static final String TOPIC="onlinesale";
    private boolean flag=true;

    //此类并未使用spring注解标识，不会被spring自动装配，无法自动注入，需从ApplicationContext中加载
    private UserService userService=null;
    private OrderService orderService=null;
    private SecKillService secKillService=null;
    private KafkaConsumerUtils kafkaConsumerUtils=null;
    private Lock lock=null;
    public DoSecKillThread(Lock lock)
    {
        userService= (UserService)MyApplicationContext.getBean("userService");
        orderService=(OrderService)MyApplicationContext.getBean("orderService");
        secKillService=(SecKillService)MyApplicationContext.getBean("secKillService");
        kafkaConsumerUtils=new KafkaConsumerUtils();
        this.lock=lock;
    }


    @Override
    public void run() {
        while (flag)
        {
            List<KafkaMsg> list=kafkaConsumerUtils.getRowMessage(TOPIC);
            if(list!=null&&list.size()>0)
            {
                System.out.println(Thread.currentThread().getName());
                for(KafkaMsg item:list)
                {
                    String record=item.getValue();
                    JSONObject json= JSON.parseObject(record);
                    String userId=json.getString("userId");
                    String goodsId=json.getString("goodsId");

                    lock.lock(); //注意这个地方,lock会锁住此部分代码区
//=====================================================================================
                    List<Seckill> seckills= CurrentSecKill.seckillList;
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
                                    AjaxMessage obj= (AjaxMessage) orderService.addOrder(idList,numList,user,true);
                                    if(obj.getCode().equals(MsgType.Success.toString().toLowerCase()))
                                    {
                                        seckill.setRestNum(seckill.getRestNum()-1);
                                        WebSocketListen.sendStrMessage(userId,"恭喜！抢购成功");
                                    }
                                    else
                                    {
                                        WebSocketListen.sendStrMessage(userId,"遗憾！秒杀失败");
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                    try {
                                        WebSocketListen.sendStrMessage(userId,"遗憾！秒杀失败");
                                    } catch (IOException e1) {
                                        e1.printStackTrace();
                                    }
                                }
                            }
                            else//无余量，从秒杀列表删除，返回秒杀失败
                            {
                                try {
                                    WebSocketListen.sendStrMessage(userId,"遗憾！秒杀失败");
                                } catch (IOException e) {
                                    e.printStackTrace();
                                }
                                secKillService.updateSecKillToRemove(seckill);

                            }
                            break;
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
