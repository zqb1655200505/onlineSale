package com.zqb.main.service;

import com.alibaba.fastjson.JSONObject;
import com.zqb.main.dao.CartDao;
import com.zqb.main.dao.GoodsDao;
import com.zqb.main.dto.AjaxMessage;
import com.zqb.main.dto.MsgType;
import com.zqb.main.entity.Cart;
import com.zqb.main.entity.Goods;
import com.zqb.main.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;

/**
 * Created by zqb on 2018/4/24.
 */
@Component
public class CartService {

    @Autowired
    private CartDao cartDao;

    @Autowired
    private GoodsDao goodsDao;

    public Object addToCart(HttpServletRequest request, HttpSession session)
    {
        User user= (User) session.getAttribute("userSession");
        String goodsId=request.getParameter("goodsId");
        String goodsNum=request.getParameter("goodsNum");
        if(goodsNum!=null&&goodsId!=null)
        {
            int num=Integer.parseInt(goodsNum);
            Goods goods=goodsDao.getGoodsByPrimaryKey(goodsId);
            Cart cart=new Cart();
            cart.setUser(user);
            cart.setGoods(goods);
            cart.setGoodsNum(num);
            cart.preInsert();
            if(cartDao.add(cart)>0)
            {
                return new AjaxMessage().Set(MsgType.Success,"加入购物车成功",null);
            }
            else
            {
                return new AjaxMessage().Set(MsgType.Error,"加入购物车出错",null);
            }
        }
        else
        {
            return new AjaxMessage().Set(MsgType.Error,"参数错误",null);
        }
    }

    public List<Goods> getGoodsByIdList(HttpServletRequest request)
    {
        String ids=request.getParameter("idList");
        System.out.println(ids);
        if(ids!=null)
        {
            String[] idArray=ids.split(";");
            List<String> idList= Arrays.asList(idArray);
            System.out.println(idList);
            return goodsDao.getGoodsByIdList(idList);
        }
        return null;
    }
}
