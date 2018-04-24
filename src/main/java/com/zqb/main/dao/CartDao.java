package com.zqb.main.dao;

import com.zqb.main.entity.Cart;
import com.zqb.main.entity.User;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by zqb on 2018/4/24.
 */
@Repository
public interface CartDao {

    int add(Cart cart);

    List<Cart> getCartByUser(User user);
}
