package com.zqb.main.service;

import com.zqb.main.dao.UserDao;
import com.zqb.main.entity.User;
import com.zqb.main.utils.Encryption;
import com.zqb.main.utils.IdGen;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by zqb on 2018/4/3.
 */
@Component
public class UserService {

    @Autowired
    private UserDao userDao;


    public void addUser()
    {
        User user=new User();
        user.setId(IdGen.uuid());
        user.setUserName("zqb2");
        user.setUserPassword(Encryption.entryptPasswordMD5("zqb123456"));
        System.out.println(user.toString());
        userDao.addUser(user);
    }


    public List<User> getAll()
    {
        return userDao.getAll();
    }
}
