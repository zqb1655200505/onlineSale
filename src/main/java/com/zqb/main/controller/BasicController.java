package com.zqb.main.controller;

import com.zqb.main.dto.AjaxMessage;
import com.zqb.main.dto.MsgType;
import com.zqb.main.entity.User;
import com.zqb.main.entity.UserType;
import com.zqb.main.service.UserService;
import com.zqb.main.utils.Encryption;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by zqb on 2018/4/3.
 */

@Controller
@RequestMapping(value = "/onlineSale")
public class BasicController {

    @Autowired
    private UserService userService;


    @RequestMapping(value = {"/index",""})
    public String welcome(Model model,HttpSession session)
    {
        return "index";
    }


    @RequestMapping(value = "/login")
    public String login(HttpSession session,HttpServletRequest request)
    {
        if(session.getAttribute("userSession")!=null)//防止重新登录
            return "redirect:index";
        return "login";
    }


    @RequestMapping(value = "/register")
    public String register()
    {
        return "register";
    }


    @RequestMapping(value = "/doLogin",method = RequestMethod.POST)
    @ResponseBody
    public Object doLogin(User user, Model model, HttpSession session)
    {
        User user1=userService.getUserByNameAndPwd(user.getUserName(),user.getUserPassword());
        if(user1!=null)
        {
            session.setAttribute("userSession",user1);
            String url = (String) session.getAttribute("redirectUrl");
            if(url!=null&&url.length()>0)
            {
                return new AjaxMessage().Set(MsgType.Success,"登录成功",url);
            }
            return new AjaxMessage().Set(MsgType.Success,"登录成功",null);
        }
        return new AjaxMessage().Set(MsgType.Error,"用户名或密码错误",null);
    }


    @RequestMapping(value = "/doRegister",method = RequestMethod.POST)
    @ResponseBody
    public Object doRegister(HttpServletRequest request, Model model)
    {
        String userName=request.getParameter("userName");
        if(userService.getUserByName(userName)==null)//检查用户名是否已存在
        {
            User user=new User();
            user.setUserName(userName);
            if(request.getParameter("userType").equals(UserType.USER.getId()+""))
            {
                user.setUserType(UserType.USER);
            }
            else
            {
                user.setUserType(UserType.ADMINISTRATOR);
            }
            user.setUserPassword(Encryption.entryptPasswordMD5(request.getParameter("userPassword")));
            user.setUserPic("/upload/image/defaultAvatar.jpg");
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

    @RequestMapping(value = "/getLoginUserInfo",method = RequestMethod.GET)
    @ResponseBody
    public Object getLoginUserInfo(HttpSession session)
    {
        if(session.getAttribute("userSession")!=null)
            return new AjaxMessage().Set(MsgType.Success,null,session.getAttribute("userSession"));
        return new AjaxMessage().Set(MsgType.Error,null);
    }

    @RequestMapping(value = "/logout")
    public String logout(HttpSession session)
    {
        session.removeAttribute("userSession");
        session.removeAttribute("redirectUrl");//把url清理
        return "login";//退出后返回登录页
    }
}
