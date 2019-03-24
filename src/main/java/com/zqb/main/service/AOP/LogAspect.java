package com.zqb.main.service.AOP;

import com.zqb.main.dao.LogDao;
import com.zqb.main.entity.User;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Method;
import java.util.Arrays;

/**
 * Created by root on 2019/3/20.
 */
@Aspect
@Component
public class LogAspect {


    @Autowired
    private LogDao logDao;


    //申明切点为使用了@LogAOP注解的方法
    @Pointcut("@annotation(com.zqb.main.service.AOP.LogAOP)")
    public  void logAOP()
    {}


    @Before("logAOP()")
    public void doBefore(JoinPoint joinPoint) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session = request.getSession();
        try {
            String targetName = joinPoint.getTarget().getClass().getName();
            String methodName = joinPoint.getSignature().getName();
            Object[] arguments = joinPoint.getArgs();

            //通过反射获得Method对象
            Class targetClass = Class.forName(targetName);
            Method[] methods = targetClass.getMethods();
            String operationType = "";
            String operationName = "";
            for (Method method : methods)
            {
                if (method.getName().equals(methodName))
                {
                    Class[] clazzs = method.getParameterTypes();
                    if (clazzs.length == arguments.length) {
                        operationType = method.getAnnotation(LogAOP.class).operationType();
                        operationName = method.getAnnotation(LogAOP.class).operationName();
                        break;
                    }
                }
            }


            Log log=new Log();
            log.setOperationType(operationType);
            log.setMethod(methodName);
            log.setParams(Arrays.toString(arguments));
            log.setOperationName(operationName);
            log.setFromIp(request.getRemoteAddr());
            if(session.getAttribute("userSession")!=null)
                log.setOperationUser(((User)session.getAttribute("userSession")).getUserName());
            log.preInsert();
            logDao.add(log);

        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }



    @AfterReturning(pointcut="logAOP()", returning="retVal")
    public void doBefore(Object retVal)
    {
        System.out.println("接收到AOP返回值：");
        System.out.println(retVal);
    }

}
