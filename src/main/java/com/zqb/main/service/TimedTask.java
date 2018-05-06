package com.zqb.main.service;

import com.zqb.main.dao.SecKillDao;
import com.zqb.main.dto.CurrentSecKill;
import com.zqb.main.entity.Seckill;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/**
 * 获取当前秒杀商品，存储在 CurrentSecKill类静态变量（session）中，防止秒杀时大量查询数据库
 * Created by zqb on 2018/4/30.
 */
@Component
public class TimedTask {

    @Autowired
    private SecKillDao secKillDao;

//    无法在此处获取到session，可能是多线程问题
//    @Autowired
//    private HttpSession session;

    //设置每隔1小时执行1次
    @Scheduled(cron = "0 0/10 * * * ?")//参数依次为秒，分，小时，天，月
    public void getSecKillGoods()
    {
        //更新前一批秒杀商品状态
        List<Seckill> list=CurrentSecKill.getSeckillList();
        DoSecKillThread thread=CurrentSecKill.getThread();
        if(thread!=null)
        {
            thread.setFlag(false);
        }
//        if(list!=null)
//        {
//            for (Seckill item:list)
//            {
//                secKillDao.updateSecKillStatusToRemove(item);
//            }
//        }


        //开启新一轮秒杀
        System.out.println("======开始更新秒杀商品======");
        CurrentSecKill.setSeckillList(null);
        Date now=new Date();
        List<Seckill> seckillList=secKillDao.getCurrentSecKill(now);
        CurrentSecKill.setSeckillList(seckillList);
        System.out.println("======更新秒杀商品成功======");
        System.out.println(seckillList);

        if(seckillList!=null&&seckillList.size()>0)
        {
            DoSecKillThread thread1=new DoSecKillThread();
            thread1.start();
            CurrentSecKill.setThread(thread1);
        }

    }

}
