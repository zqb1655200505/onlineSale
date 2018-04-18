package com.zqb.main.service;

import com.alibaba.fastjson.JSONObject;
import com.zqb.main.dao.GoodsDao;
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

    public List<Goods> getGoodsByUser(Goods goods)
    {
        return goodsDao.getGoodsByUser(goods);
    }


    /**
     * 添加或修改商品信息
     * @param session
     * @param request
     * @return
     * @throws IOException
     */
    public Object saveGoods(HttpSession session, HttpServletRequest request) throws IOException {
        User user= (User) session.getAttribute("userSession");
        String param=request.getParameter("goods");
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        MultipartFile file=multipartRequest.getFile("uploadFile");
        String directory="/upload/goods/"+user.getId()+"/";
        String fileName=FileUtils.writeToServer(request,directory,file);
        if(fileName!=null)
        {
            JSONObject obj= JSONObject.parseObject(param);
            Goods goods=JSONObject.toJavaObject(obj,Goods.class);
            goods.setGoodsPic(fileName);
            if(goods.getId()!=null&&!goods.getId().equals(""))//修改商品
            {
                FileUtils.deleteFile(request.getSession().getServletContext().getRealPath("/")+goods.getGoodsPic());
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
        else
        {
            return new AjaxMessage().Set(MsgType.Error,"保存商品出错，商品图片保存错误！",null);
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
}
