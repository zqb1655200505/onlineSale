package com.zqb.main.service.AOP;

import com.zqb.main.entity.BasicEntity;

/**
 * Created by root on 2019/3/20.
 */
public class Log extends BasicEntity<Log> {

    private String operationUser;		// 操作者账户名称，与create_by对应
    private String operationType;		// 操作类型：如创建、删除等
    private String operationName;		// 标识不同类型日志
    private String method;              //方法名
    private String description;         //描述信息
    private String fromIp;              //客户端ip
    private String params;              //方法参数


    public Log() {

    }

    public String getOperationUser() {
        return operationUser;
    }

    public void setOperationUser(String operationUser) {
        this.operationUser = operationUser;
    }

    public String getOperationType() {
        return operationType;
    }

    public void setOperationType(String operationType) {
        this.operationType = operationType;
    }

    public String getOperationName() {
        return operationName;
    }

    public void setOperationName(String operationName) {
        this.operationName = operationName;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getFromIp() {
        return fromIp;
    }

    public void setFromIp(String fromIp) {
        this.fromIp = fromIp;
    }

    public String getParams() {
        return params;
    }

    public void setParams(String params) {
        this.params = params;
    }
}
