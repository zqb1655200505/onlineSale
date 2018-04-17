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

import javax.servlet.http.HttpSession;

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

    @RequestMapping(value = "/getMyGoods",method = RequestMethod.GET)
    @ResponseBody
    public Object getMyGoods(Goods goods,
                             HttpSession session,
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
        goods.setPage(page);

        User user= (User) session.getAttribute("userSession");
        if(user!=null)
        {
            return new AjaxMessage().Set(MsgType.Success,null,goodsService.getGoodsByUserId(user.getId()));
        }
        return null;
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
