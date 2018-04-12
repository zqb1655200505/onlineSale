package com.zqb.main.utils;

import kafka.admin.AdminUtils;
import kafka.admin.RackAwareMode;
import kafka.server.ConfigType;
import kafka.utils.ZkUtils;
import org.apache.kafka.common.security.JaasUtils;

import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

/**
 * Created by zqb on 2018/4/11.
 */
public class TopicUtils {

    private static final String zookeeper_connect="140.143.6.130:2181,123.207.165.243:2181,123.207.171.22:2181";//为zookeeperHosts

    public static void createTopic(String topic,int partitions,int factors)
    {
        ZkUtils zkUtils = ZkUtils.apply(zookeeper_connect, 30000, 30000, JaasUtils.isZkSecurityEnabled());
        AdminUtils.createTopic(zkUtils,topic,partitions,factors,new Properties(), RackAwareMode.Enforced$.MODULE$);
        zkUtils.close();
    }

    public static void deleteTopic(String topic)
    {
        ZkUtils zkUtils = ZkUtils.apply(zookeeper_connect, 30000, 30000, JaasUtils.isZkSecurityEnabled());
        // 删除topic
        AdminUtils.deleteTopic(zkUtils, topic);
        zkUtils.close();
    }


    //暂时无法获取
    public static void queryTopic(String topic)
    {
        ZkUtils zkUtils = ZkUtils.apply(zookeeper_connect, 30000, 30000, JaasUtils.isZkSecurityEnabled());
        // 获取topic 'test'的属性
        Properties props = AdminUtils.fetchEntityConfig(zkUtils, ConfigType.Topic(), topic);
        // 查询topic-level属性
        Iterator it = props.entrySet().iterator();
        while(it.hasNext()){
            Map.Entry entry=(Map.Entry)it.next();
            Object key = entry.getKey();
            Object value = entry.getValue();
            System.out.println(key + " = " + value);
        }
        zkUtils.close();
    }

}
