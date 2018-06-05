package com.zqb.main.service;

import com.zqb.main.dao.SecKillDao;
import com.zqb.main.dto.CurrentSecKill;
import com.zqb.main.entity.Seckill;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

/**
 * 获取当前秒杀商品，存储在 CurrentSecKill类静态变量（session）中，防止秒杀时大量查询数据库
 * Created by zqb on 2018/4/30.
 */
@Component
public class TimedTask {

    @Autowired
    private SecKillDao secKillDao;


    //设置每隔1小时执行1次
    @Scheduled(cron = "0 0 0/1 * * ?")//参数依次为秒，分，小时，天，月
    public void getSecKillGoods()
    {
        //更新前一批秒杀商品状态
        List<Seckill> list=CurrentSecKill.seckillList;

        List<DoSecKillThread> threadList=CurrentSecKill.threadList;
        if(threadList.size()==0)
        {
            Lock lock = new ReentrantLock();
            DoSecKillThread thread=new DoSecKillThread(lock);
            CurrentSecKill.threadList.add(thread);
            thread.start();
        }
//        for(DoSecKillThread item:threadList)
//        {
//            if(item!=null)
//            {
//                item.setFlag(false);
//            }
//        }

        if(list!=null)
        {
            for (Seckill item:list)
            {
                secKillDao.updateSecKillStatusToRemove(item);
            }
        }


        //开启新一轮秒杀
        System.out.println("======开始更新秒杀商品======");
        CurrentSecKill.seckillList=null;
        Date now=new Date();
        List<Seckill> seckillList=secKillDao.getCurrentSecKill(now);
        CurrentSecKill.seckillList=seckillList;
        if(seckillList!=null&&seckillList.size()>0)
        {
            CurrentSecKill.secKillEndTime = seckillList.get(0).getSeckillEndTime().getTime();
        }
        else
        {
            CurrentSecKill.secKillEndTime=-1L;
        }
        System.out.println("======更新秒杀商品成功======");
        System.out.println(seckillList);


//        CurrentSecKill.threadList.clear();
//        Lock lock = new ReentrantLock();
//        for(int i=0;i<3;i++)//通过消费者组进行消息消息消费
//        {
//            DoSecKillThread thread=new DoSecKillThread(lock);
//            CurrentSecKill.threadList.add(thread);
//            thread.start();
//        }

    }

}
