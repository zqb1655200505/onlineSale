package com.zqb.main.service;

import com.zqb.main.dao.UserMapper;
import com.zqb.main.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @author zqb
 * @decription
 * @create 2017/7/21
 */
@Component
public class UserService {
    @Autowired
    private UserMapper userMapper;

    public List<User> selectAll()
    {
        return userMapper.selectAll();
    }

}
