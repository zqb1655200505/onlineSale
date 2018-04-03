package com.zqb.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by zqb on 2018/4/3.
 */

@Controller
@RequestMapping(value = "/onlineSale/login")
public class LoginController {

    @RequestMapping(value = "")
    public String login()
    {
        return "customer/login";
    }
}
