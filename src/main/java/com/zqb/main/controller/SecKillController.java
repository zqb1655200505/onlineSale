package com.zqb.main.controller;

import com.alibaba.fastjson.JSONObject;
import com.zqb.main.dao.SecKillDao;
import com.zqb.main.dto.AjaxMessage;
import com.zqb.main.dto.CurrentSecKill;
import com.zqb.main.dto.MsgType;
import com.zqb.main.entity.Seckill;
import com.zqb.main.entity.User;
import com.zqb.main.service.OrderService;
import com.zqb.main.utils.KafkaProducerUtils;
import com.zqb.main.utils.WebSocketDto;
import com.zqb.main.utils.WebSocketListen;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/**
 * Created by zqb on 2018/4/30.
 */
@Controller
@RequestMapping("/onlineSale/secKill")
public class SecKillController {

    private static final String topic="";

    @Autowired
    private OrderService orderService;

    @Autowired
    private SecKillDao secKillDao;

    @RequestMapping("/doSecKill")
    @ResponseBody
    public Object doSecKill(HttpSession session, HttpServletRequest request)
    {
        User user= (User) session.getAttribute("userSession");
        String goodsId=request.getParameter("goodsId");
        List<Seckill> seckillList= CurrentSecKill.getSeckillList();
        boolean flag=false;
        for(Seckill item:seckillList)
        {
            if(item.getGoods().getId().equals(goodsId))
            {
                flag=true;
                break;
            }
        }
        if(!flag)
        {
            return new AjaxMessage().Set(MsgType.SecKillFalse,"该商品未参与秒杀",null);
        }

        //WebSocketDto webSocketDto = WebSocketListen.getWebsocketMap().get(user.getId());
        if(user!=null&&user.getId()!=null&&goodsId.length()>0)
        {
            JSONObject json=new JSONObject();
            json.put("userId",user.getId());
            json.put("goodsId",goodsId);
            KafkaProducerUtils.senStrMsg(topic,json.toJSONString());
        }
        return new AjaxMessage().Set(MsgType.SecKillLoading,"秒杀处理中。。。",null);
    }


    @RequestMapping("/getSecKillGoods")
    @ResponseBody
    public Object getSecKillGoods(HttpServletRequest request)
    {
        List<Seckill> list=CurrentSecKill.getSeckillList();
        if(list!=null)
            return new AjaxMessage().Set(MsgType.Success,list);
        else
        {
            Date now=new Date();
            List<Seckill> seckillList=secKillDao.getCurrentSecKill(now);
            if(seckillList==null)
            {
                return new AjaxMessage().Set(MsgType.Error,"当前暂无秒杀商品",null);
            }
            else
            {
                CurrentSecKill.setSeckillList(seckillList);
                return new AjaxMessage().Set(MsgType.Success,seckillList);
            }
        }
    }
}
