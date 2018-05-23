package com.zqb.main.controller;

import com.zqb.main.dto.AjaxMessage;
import com.zqb.main.dto.MsgType;
import com.zqb.main.dto.Page;
import com.zqb.main.entity.Goods;
import com.zqb.main.service.CartService;
import com.zqb.main.service.GoodsService;
import com.zqb.main.service.SecKillService;
import com.zqb.main.utils.CheckSQLStrUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
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


    @Autowired
    private CartService cartService;

    @ModelAttribute
    public Goods get(@RequestParam(required=false) String id) {
        Goods entity = null;
        if (id != null){
            entity = goodsService.getGoodsByPrimaryKey(id);
        }
        if (entity == null){
            entity = new Goods();
        }
        return entity;
    }


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


    @RequestMapping(value = "/goodsDetail")
    public String goodsDetail(HttpServletRequest request,Model model)
    {
        String isSecKill=request.getParameter("isSecKill");
        String id=request.getParameter("id");
        if(isSecKill.equals("true"))
        {
            model.addAttribute("isSecKill","true");
            model.addAttribute("secKillGoods",secKillService.getSecKillFromCache(id));
        }
        else
        {
            model.addAttribute("isSecKill","false");
            model.addAttribute("goods",get(id));
        }

        return "goodsDetail";
    }

    @RequestMapping(value = "/addToCart",method = RequestMethod.GET)
    @ResponseBody
    public Object addToCart(HttpServletRequest request,HttpSession session)
    {
        return cartService.addToCart(request,session);
    }

}
