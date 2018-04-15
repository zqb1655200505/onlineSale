package com.zqb.main.controller;

import com.zqb.main.dto.AjaxMessage;
import com.zqb.main.dto.MsgType;
import com.zqb.main.entity.User;
import com.zqb.main.entity.UserType;
import com.zqb.main.service.UserService;
import com.zqb.main.utils.Encryption;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by zqb on 2018/4/3.
 */

@Controller
@RequestMapping(value = "/onlineSale")
public class BasicController {

    @Autowired
    private UserService userService;

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


    @RequestMapping(value = "/doLogin",method = RequestMethod.POST)
    @ResponseBody
    public Object doLogin(User user)
    {
        return new AjaxMessage().Set(MsgType.Success,"登录成功",user);
    }


    @RequestMapping(value = "/doRegister",method = RequestMethod.POST)
    @ResponseBody
    public Object doRegister(HttpServletRequest request)
    {
        User user=new User();
        user.setUserName(request.getParameter("userName"));
        if(userService.getUserByName(user)==null)
        {
            if(request.getParameter("userType").equals(UserType.USER.getId()+""))
            {
                user.setUserType(UserType.USER);
            }
            else
            {
                user.setUserType(UserType.ADMINISTRATOR);
            }
            user.setUserPassword(Encryption.entryptPasswordMD5(request.getParameter("userName")));
            user.preInsert();
            if(userService.addUser(user)>0)
                return new AjaxMessage().Set(MsgType.Success,"注册成功，自动跳转至登录页",null);
            else
                return new AjaxMessage().Set(MsgType.Error,"注册失败",null);
        }
        else
        {
            return new AjaxMessage().Set(MsgType.Error,"该用户名已被注册！",null);
        }
    }
}
