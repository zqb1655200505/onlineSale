package com.zqb.main.controller;


import com.zqb.main.dto.AjaxMessage;
import com.zqb.main.dto.MsgType;
import com.zqb.main.dto.Page;
import com.zqb.main.entity.Goods;
import com.zqb.main.entity.User;
import com.zqb.main.service.GoodsService;
import com.zqb.main.service.UserService;
import com.zqb.main.utils.CheckSQLStrUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

/**
 * Created by zqb on 2018/4/16.
 */
@Controller
@RequestMapping(value = "/onlineSale/myStore")
public class StoreController {

    @Autowired
    private UserService userService;

    @Autowired
    private GoodsService goodsService;


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

    @RequestMapping(value = {"/index","/"})
    public String welcome(Model model,HttpSession session)
    {
        if(userService.checkUserPermission(session))
            return "myStore";
        return "permissionDeny";
    }

    @RequestMapping(value = "/getMyGoods",method = RequestMethod.GET)
    @ResponseBody
    public Object getMyGoods(HttpSession session,
                             @RequestParam("pageNo") int pageNo,
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

        User user= (User) session.getAttribute("userSession");
        if(user!=null)
        {
            goods.setUser(user);
            List<Goods> list=goodsService.getGoodsByUser(goods);
            page.initialize();
            HashMap<String, Object> map = new HashMap<String, Object>();
            map.put("list", list);
            map.put("total", goodsService.getCountByUser(goods));
            return new AjaxMessage().Set(MsgType.Success, map);
        }
        return null;
    }


    @RequestMapping(value = "/save",method = RequestMethod.POST)
    @ResponseBody
    public Object save(HttpServletRequest request, Model model,HttpSession session) throws IOException {
        return goodsService.saveGoods(session,request);
    }



    @RequestMapping(value = "/myOrder")
    public String getSellerOrder(Model model,HttpSession session)
    {
        if(userService.checkUserPermission(session))
            return "sellerOrder";
        return "permissionDeny";
    }

    @RequestMapping(value = "/mySecKillGoods")
    public String getSellersecKillGoods(Model model,HttpSession session)
    {
        if(userService.checkUserPermission(session))
            return "sellerSecKillGoods";
        return "permissionDeny";
    }


    @RequestMapping(value = "/goodsForm")
    public String goodsForm(Goods goods,Model model,HttpSession session)
    {
        model.addAttribute("goods", goods);
        if(userService.checkUserPermission(session))
            return "goodsForm";
        return "permissionDeny";
    }




}
