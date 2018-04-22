package com.zqb.main.service;

import com.zqb.main.dao.SecKillDao;
import com.zqb.main.dto.AjaxMessage;
import com.zqb.main.dto.MsgType;
import com.zqb.main.entity.Seckill;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by zqb on 2018/4/20.
 */
@Component
public class SecKillService {

    @Autowired
    private SecKillDao secKillDao;

    public Object add(Seckill seckill)
    {
        seckill.preInsert();
        if(secKillDao.add(seckill)>0)
        {
            return new AjaxMessage().Set(MsgType.Success,"添加秒杀商品成功",null);
        }
        else
        {
            return new AjaxMessage().Set(MsgType.Error,"添加秒杀商品失败",null);
        }
    }


    public List<Seckill> getMySecKillGoods(Seckill seckill)
    {
        return secKillDao.getMySecKillGoods(seckill);
    }

    public int getMySecKillGoodsCount(Seckill seckill)
    {
        return secKillDao.getMySecKillGoodsCount(seckill);
    }
}
