package com.zqb.main.service.AOP;

import java.lang.annotation.*;

/**
 * Created by root on 2019/3/20.
 */
@Target({ElementType.PARAMETER, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface LogAOP {

    //操作类型，如add,update
    String operationType() default "";

    //具体操作，如登录，注销
    String operationName() default "";

}
