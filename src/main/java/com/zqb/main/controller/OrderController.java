package com.zqb.main.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.zqb.main.dto.AjaxMessage;
import com.zqb.main.dto.MsgType;
import com.zqb.main.dto.Page;
import com.zqb.main.entity.Order;
import com.zqb.main.entity.OrderGoods;
import com.zqb.main.entity.User;
import com.zqb.main.service.OrderService;
import com.zqb.main.utils.CheckSQLStrUtils;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by zqb on 2018/4/16.
 */
@Controller
@RequestMapping(value = "/onlineSale/myOrder")
public class OrderController {


    @Autowired
    private OrderService orderService;


    @RequestMapping(value = {"/index","/"})
    public String welcome(Model model, HttpSession session)
    {
        return "myOrder";
    }

    @RequestMapping("/addOrder")
    @ResponseBody
    public Object addOrder(@RequestBody String jsonStr,HttpSession session)  {
        if(jsonStr!=null)
        {
            JSONObject obj = JSONObject.parseObject(jsonStr);
            JSONArray idArray=obj.getJSONArray("idList");
            JSONArray numArray=obj.getJSONArray("numList");
            List<String> idList=idArray.toJavaList(String.class);
            List<Integer> numList=numArray.toJavaList(Integer.class);
            User user= (User) session.getAttribute("userSession");
            try {
                return orderService.addOrder(idList,numList,user,false);
            } catch (Exception e) {
                e.printStackTrace();
                return new AjaxMessage().Set(MsgType.Error,"购买商品失败",null);
            }
        }
        return new AjaxMessage().Set(MsgType.Error,"参数错误",null);
    }

    @RequestMapping(value = "/getConsumerOrder",method = RequestMethod.GET)
    @ResponseBody
    public Object getConsumerOrder(HttpServletRequest request,
                             HttpSession session,
                             @RequestParam("pageNo") int pageNo,
                             @RequestParam("pageSize") int pageSize,
                             @RequestParam("keys") String keys)
    {
        if(keys != null && !keys.equals("")){
            if(CheckSQLStrUtils.sql_inj(keys)){
                return new AjaxMessage().Set(MsgType.Error, "请勿输入非法字符！",null);
            }
        }
        Page<Order> page = new Page<Order>(pageNo, pageSize);
        page.setFuncName("changePage");
        User user= (User) session.getAttribute("userSession");
        Order order=new Order();
        order.setBuyer(user);
        order.setPage(page);
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("list", orderService.getConsumerOrder(order));
        map.put("total", orderService.getConsumerOrderCount(user.getId()));
        return new AjaxMessage().Set(MsgType.Success,map);
    }

    @RequestMapping(value = "/getOrderDetail",method = RequestMethod.GET)
    @ResponseBody
    public Object getOrderDetail(@RequestParam("orderId") String orderId)
    {
        return new AjaxMessage().Set(MsgType.Success,orderService.getOrderDetail(orderId));
    }

    @RequestMapping(value = "/getSellerOrder",method = RequestMethod.GET)
    @ResponseBody
    public Object getSellerOrder(HttpSession session,
                                 @RequestParam("pageNo") int pageNo,
                                 @RequestParam("pageSize") int pageSize,
                                 @RequestParam("keys") String keys)
    {
        if(keys != null && !keys.equals("")){
            if(CheckSQLStrUtils.sql_inj(keys)){
                return new AjaxMessage().Set(MsgType.Error, "请勿输入非法字符！",null);
            }
        }

        User user= (User) session.getAttribute("userSession");
        OrderGoods order=new OrderGoods();
        Page<OrderGoods> page=new Page<OrderGoods>(pageNo, pageSize);
        page.setFuncName("changePage");
        order.setPage(page);
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("list", orderService.getSellerOrder(order,user.getId()));
        map.put("total", orderService.getSellerOrderCount(user.getId()));
        return  new AjaxMessage().Set(MsgType.Success,map);
    }
}
