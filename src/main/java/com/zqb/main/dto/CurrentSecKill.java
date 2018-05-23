package com.zqb.main.dto;

import com.zqb.main.entity.Seckill;
import com.zqb.main.service.DoSecKillThread;

import java.util.List;

/**
 * 用于保存当前秒杀商品
 * Created by zqb on 2018/4/30.
 */
public class CurrentSecKill {

    public static List<Seckill> seckillList=null;

    public static DoSecKillThread thread=null;

    public static long secKillEndTime=-1L;

}
