package com.zqb.main.dto;

import com.zqb.main.entity.Seckill;
import com.zqb.main.service.DoSecKillThread;

import java.util.List;

/**
 * 用于保存当前秒杀商品
 * Created by zqb on 2018/4/30.
 */
public class CurrentSecKill {

     private static List<Seckill> seckillList=null;

    private static DoSecKillThread thread=null;

    public static void setSeckillList(List<Seckill> list)
    {
        seckillList=list;
    }

    public static List<Seckill> getSeckillList()
    {
        return seckillList;
    }

    public static DoSecKillThread getThread() {
        return thread;
    }

    public static void setThread(DoSecKillThread thread) {
        CurrentSecKill.thread = thread;
    }
}
