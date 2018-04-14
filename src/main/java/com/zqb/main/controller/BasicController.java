package com.zqb.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by zqb on 2018/4/3.
 */

@Controller
@RequestMapping(value = "/onlineSale")
public class BasicController {

    @RequestMapping(value = "")
    public String index()
    {
        return "index";
    }

    @RequestMapping(value = "/index")
    public String welcome()
    {
        return "index";
    }


    @RequestMapping(value = "/login")
    public String login()
    {
        return "login";
    }


    @RequestMapping(value = "/register")
    public String register()
    {
        return "register";
    }
}
