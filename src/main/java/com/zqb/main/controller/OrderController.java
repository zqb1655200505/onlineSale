package com.zqb.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * Created by zqb on 2018/4/16.
 */
@Controller
@RequestMapping(value = "/onlineSale/myOrder")
public class OrderController {

    @RequestMapping(value = {"/index","/"})
    public String welcome(Model model, HttpSession session)
    {
        return "myOrder";
    }

}
