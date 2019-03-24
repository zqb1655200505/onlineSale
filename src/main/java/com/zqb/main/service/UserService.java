package com.zqb.main.service;

import com.zqb.main.dao.UserDao;
import com.zqb.main.entity.User;
import com.zqb.main.entity.UserType;
import com.zqb.main.service.AOP.LogAOP;
import com.zqb.main.utils.Encryption;
import com.zqb.main.utils.IdGen;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by zqb on 2018/4/3.
 */
@Component
public class UserService {

    @Autowired
    private UserDao userDao;


    @LogAOP(operationName = "用户注册",operationType = "user")
    public int addUser(User user)
    {
        return userDao.addUser(user);
    }


    public List<User> getAll()
    {
        return userDao.getAll();
    }


    public User getUserByName(String userName)
    {
        return userDao.getUserByName(userName);
    }

    public User getUserByNameAndPwd(String userName,String password)
    {
        return userDao.getUserByNameAndPwd(userName,Encryption.entryptPasswordMD5(password));
    }

    public boolean checkUserPermission(HttpSession session)
    {
        User user= (User) session.getAttribute("userSession");
        if(user!=null)
        {
            if(user.getUserType().equals(UserType.ADMINISTRATOR))
            {
                return true;
            }
        }
        return false;
    }


    public User getUserFromSession(HttpSession session)
    {
        return (User) session.getAttribute("userSession");
    }


    public User getByPrimaryKey(String userId)
    {
        return userDao.getByPrimaryKey(userId);
    }
}
