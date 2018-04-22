package com.zqb.main.service;

import com.alibaba.fastjson.JSONObject;
import com.zqb.main.dao.GoodsDao;
import com.zqb.main.dao.SecKillDao;
import com.zqb.main.dto.AjaxMessage;
import com.zqb.main.dto.MsgType;
import com.zqb.main.entity.Goods;
import com.zqb.main.entity.User;
import com.zqb.main.utils.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Created by zqb on 2018/4/17.
 */
@Component
public class GoodsService {

    @Autowired
    private GoodsDao goodsDao;


    @Autowired
    private SecKillDao secKillDao;

    public List<Goods> getGoodsByUser(Goods goods)
    {
        return goodsDao.getGoodsByUser(goods);
    }


    public Object saveGoods(HttpSession session, HttpServletRequest request) throws IOException {
        User user= (User) session.getAttribute("userSession");
        String param=request.getParameter("goods");
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        MultipartFile file=multipartRequest.getFile("uploadFile");
        String fileName="/upload/goods/default.jpg";
        if(file!=null)
        {
            String directory="/upload/goods/"+user.getId()+"/";
            fileName=FileUtils.writeToServer(request,directory,file);
        }

        JSONObject obj= JSONObject.parseObject(param);
        Goods goods=JSONObject.toJavaObject(obj,Goods.class);

        if(goods.getId()!=null&&!goods.getId().equals(""))//修改商品
        {
            if(file!=null)
            {
                FileUtils.deleteFile(request.getSession().getServletContext().getRealPath("/")+goods.getGoodsPic());
                goods.setGoodsPic(fileName);
            }
            if(goodsDao.updateByPrimaryKey(goods)>0)
            {
                return new AjaxMessage().Set(MsgType.Success,"商品信息修改成功",null);
            }
            else
            {
                return new AjaxMessage().Set(MsgType.Success, "商品信息修改失败", null);
            }
        }
        else//新增商品
        {
            goods.setGoodsPic(fileName);
            goods.setUser(user);
            goods.preInsert();
            if(goodsDao.addGoods(goods)>0)
            {
                return new AjaxMessage().Set(MsgType.Success,"添加成功！",null);
            }
            else
            {
                return new AjaxMessage().Set(MsgType.Error, "添加失败", null);
            }
        }

    }



    public int getCountByUser(Goods goods)
    {
        return goodsDao.getCountByUser(goods);
    }


    public Goods getGoodsByPrimaryKey(String id)
    {
        return goodsDao.getGoodsByPrimaryKey(id);
    }


    public List<Goods> getAllGoods(Goods goods)
    {
        return goodsDao.getAllGoods(goods);
    }



    public int getGoodsCount()
    {
        return goodsDao.getGoodsCount();
    }

    public Object deleteGoods(String goodsId)
    {

        if(secKillDao.deleteByGoodsId(goodsId)>0)
        {
            if(goodsDao.deleteByPrimaryKey(goodsId)>0)
            {
                return new AjaxMessage().Set(MsgType.Success,"删除商品成功",null);
            }
        }
        return new AjaxMessage().Set(MsgType.Error,"删除商品失败",null);
    }

    public int removeByIdList(List<String> idList)
    {
        return goodsDao.removeByIdList(idList);
    }


    public Object changeStatus(String id,boolean status)
    {
        if(goodsDao.changeStatus(id,status)>0)
        {
            return new AjaxMessage().Set(MsgType.Success,"商品状态修改成功",null);
        }
        return new AjaxMessage().Set(MsgType.Error,"商品状态修改失败",null);
    }
}
