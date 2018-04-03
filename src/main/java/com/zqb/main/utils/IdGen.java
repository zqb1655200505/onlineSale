package com.zqb.main.utils;

import java.util.UUID;

/**
 * Created by zqb on 2018/4/3.
 */
public class IdGen {

    public static String uuid() {
        return UUID.randomUUID().toString().replaceAll("-", "");
    }
}
