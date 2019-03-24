package com.zqb.main.dao;

import com.zqb.main.service.AOP.Log;
import org.springframework.stereotype.Repository;

/**
 * Created by zqb on 2019/3/24.
 */
@Repository
public interface LogDao {

    int add(Log log);

}
