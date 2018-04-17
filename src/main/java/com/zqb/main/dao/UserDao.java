package com.zqb.main.dao;

import com.zqb.main.entity.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zqb on 2018/4/3.
 */
@Repository
public interface UserDao {

    int addUser(User user);

    List<User> getAll();

    User selectById(@Param("id") String userId);

    User getUserByName(@Param("userName") String userName);


    User getUserByNameAndPwd(@Param("userName") String userName,
                             @Param("userPassword") String userPassword);
}
