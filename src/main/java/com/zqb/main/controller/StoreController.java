package com.zqb.main.controller;

import com.zqb.main.entity.Goods;
import com.zqb.main.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

/**
 * Created by zqb on 2018/4/16.
 */
@Controller
@RequestMapping(value = "/onlineSale/myStore")
public class StoreController {

    @Autowired
    private UserService userService;



    @ModelAttribute
    public Goods get(@RequestParam(required=false) String id) {
        Goods entity = null;
//        if (id != null){
//            entity = industrySortDao.getByPrimaryKey(id);
//        }
//        if (entity == null){
//            entity = new IndustrySort();
//        }
        return entity;
    }

    @RequestMapping(value = {"/index","/"})
    public String welcome(Model model,HttpSession session)
    {
        if(userService.checkUserPermission(session))
            return "myStore";
        return "permissionDeny";
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
    public String goodsForm(Model model,HttpSession session)
    {
        model.addAttribute("goods", model);
        if(userService.checkUserPermission(session))
            return "goodsForm";
        return "permissionDeny";
    }

}
