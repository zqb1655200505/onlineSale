package com.zqb.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.zqb.main.dto.AjaxMessage;
import com.zqb.main.dto.MsgType;
import com.zqb.main.entity.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

/**
 * @author zqb
 * @decription 请求拦截器
 * @create 2017/7/20
 */
public class SpringMVCInterceptor implements HandlerInterceptor{
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        HttpSession session = request.getSession();
        User user = (User)session.getAttribute("userSession");
        if(user==null)
        {
            //拦截发现未登录，返回登录界面
            response.sendRedirect("/onlineSale/login");

            //拦截器直接向客户端返回数据
//            response.setContentType("application/json;charset=UTF-8");
//            AjaxMessage msg=new AjaxMessage();
//            msg.Set(MsgType.Error,"请先登录");
//            PrintWriter out=response.getWriter();
//            out.write(new ObjectMapper().writeValueAsString(msg));
//            out.close();

            return false;//不会继续调用其他的拦截器或处理器
        }
        return true;
    }

    /**
     * Handler执行之后，ModelAndView返回之前调用这个方法
     */
    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }


    /**
     * Handler执行完成之后调用这个方法
     */
    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
