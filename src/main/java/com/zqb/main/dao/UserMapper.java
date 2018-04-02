package com.zqb.main.dao;

import com.zqb.main.entity.User;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zqb on 2017/7/21.
 */
@Repository
public interface UserMapper {

    List<User> selectAll();

    int addUser(User user);
}
