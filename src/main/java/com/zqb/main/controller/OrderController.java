package com.zqb.main.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.zqb.main.dto.AjaxMessage;
import com.zqb.main.dto.MsgType;
import com.zqb.main.entity.Order;
import com.zqb.main.entity.OrderGoods;
import com.zqb.main.entity.User;
import com.zqb.main.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

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

    @RequestMapping(value = "/getMyOrder",method = RequestMethod.GET)
    @ResponseBody
    public Object getMyOrder(HttpServletRequest request,HttpSession session)
    {
        User user= (User) session.getAttribute("userSession");
        return new AjaxMessage().Set(MsgType.Success,orderService.getConsumerOrder(user));
    }
}
