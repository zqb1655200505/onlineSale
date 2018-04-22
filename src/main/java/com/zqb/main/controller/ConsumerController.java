package com.zqb.main.controller;

import com.zqb.main.dto.AjaxMessage;
import com.zqb.main.dto.MsgType;
import com.zqb.main.dto.Page;
import com.zqb.main.entity.Goods;
import com.zqb.main.service.GoodsService;
import com.zqb.main.service.SecKillService;
import com.zqb.main.utils.CheckSQLStrUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

/**
 * Created by zqb on 2018/4/22.
 */
@Controller
@RequestMapping(value = "/onlineSale/consumer")
public class ConsumerController {

    @Autowired
    private GoodsService goodsService;


    @Autowired
    private SecKillService secKillService;


    @RequestMapping(value = "/getGoods",method = RequestMethod.GET)
    @ResponseBody
    public Object getGoods(@RequestParam("pageNo") int pageNo,
                           @RequestParam("pageSize") int pageSize,
                           @RequestParam("keys") String keys)
    {
        if(keys != null && !keys.equals("")){
            if(CheckSQLStrUtils.sql_inj(keys)){
                return new AjaxMessage().Set(MsgType.Error, "请勿输入非法字符！",null);
            }
        }
        Page<Goods> page = new Page<Goods>(pageNo, pageSize);
        page.setFuncName("changePage");
        Goods goods=new Goods();
        goods.setPage(page);

        List<Goods> list=goodsService.getAllGoods(goods);
        page.initialize();
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("list", list);
        map.put("total", goodsService.getGoodsCount());
        return new AjaxMessage().Set(MsgType.Success, map);
    }
}
