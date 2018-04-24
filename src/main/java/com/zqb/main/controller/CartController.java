package com.zqb.main.controller;

import com.zqb.main.dto.AjaxMessage;
import com.zqb.main.dto.MsgType;
import com.zqb.main.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by zqb on 2018/4/16.
 */

@Controller
@RequestMapping(value = "/onlineSale/myCart")
public class CartController {

    @Autowired
    private CartService cartService;

    @RequestMapping(value = {"/index","/"})
    public String welcome(Model model, HttpSession session)
    {
        return "myCart";
    }


    @RequestMapping(value = "/getCartGoods",method = RequestMethod.GET)
    @ResponseBody
    public Object getCartGoods(HttpServletRequest request)
    {
        return new AjaxMessage().Set(MsgType.Success,cartService.getGoodsByIdList(request));
    }

}
