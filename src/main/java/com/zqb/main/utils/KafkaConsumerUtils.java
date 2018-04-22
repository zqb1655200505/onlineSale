package com.zqb.main.utils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.zqb.main.dto.KafkaMsg;
import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.KafkaConsumer;
import org.apache.kafka.common.TopicPartition;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

/**
 * Created by zqb on 2018/4/12.
 */
public class KafkaConsumerUtils {

    private static final String bootstrap_servers="140.143.6.130:9092,123.207.165.243:9092,123.207.171.22:9092";
    private static KafkaConsumer<String, String> consumer;

    static {
        Properties props = new Properties();
        props.put(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG,bootstrap_servers);//声明zk
        props.put(ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG, "org.apache.kafka.common.serialization.ByteArrayDeserializer");
        props.put(ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG, "org.apache.kafka.common.serialization.StringDeserializer");
        props.put(ConsumerConfig.GROUP_ID_CONFIG, "test-consumer-group");// 必须要使用别的组名称， 如果生产者和消费者都在同一组，则不能访问同一组内的topic数据
        props.put(ConsumerConfig.ENABLE_AUTO_COMMIT_CONFIG, "false");// 自动提交offsets
        props.put(ConsumerConfig.AUTO_COMMIT_INTERVAL_MS_CONFIG, "1000");// 每隔1s，自动提交offsets
        props.put(ConsumerConfig.SESSION_TIMEOUT_MS_CONFIG, "30000");// Consumer向集群发送自己的心跳，超时则认为Consumer已经死了，kafka会把它的分区分配给其他进程
        consumer= new KafkaConsumer<String, String>(props);
    }

    public static String getStringMessage(String topic)
    {
        consumer.subscribe(Arrays.asList(topic));
        ConsumerRecords<String, String> records = consumer.poll(100);
        JSONArray jsonArray=new JSONArray();
        for (ConsumerRecord<String, String> record : records)
        {
            JSONObject jsonMsg = JSON.parseObject(record.value());
            //KafkaMsg msg=JSONObject.toJavaObject(jsonMsg, KafkaMsg.class);
            jsonArray.add(jsonMsg);
        }
        return jsonArray.toJSONString();
    }


    public static List<KafkaMsg> getRowMessage(String topic)
    {
        consumer.subscribe(Arrays.asList(topic));
        return consume();
    }

    public static List<KafkaMsg> getRowMessage(String topic,long offset)
    {
        //consumer.subscribe(Arrays.asList(topic));
        consumer.assign(Arrays.asList(new TopicPartition(topic, 0),new TopicPartition(topic, 1),new TopicPartition(topic, 2)));
        //consumer.seekToBeginning(Arrays.asList(new TopicPartition(topic, 0)));//不改变当前offset
        consumer.seek(new TopicPartition(topic,0),offset);
        //consumer.commitSync();
        return consume();

    }


    private static List<KafkaMsg> consume()
    {
        List<KafkaMsg> list=new ArrayList<KafkaMsg>();
        ConsumerRecords<String, String> records = consumer.poll(100);
        for (ConsumerRecord<String, String> record : records)
        {
            System.out.println(record.toString());
            KafkaMsg msg=new KafkaMsg();
            msg.setTimestamp(record.timestamp());
            msg.setOffset(record.offset());
            msg.setPartition(record.partition());
            msg.setValue(record.value());
            msg.setTopic(record.topic());
            list.add(msg);

            //测试JSONObject是否可用
//            JSONObject jsonObject=JSON.parseObject(msg.toString());
//            KafkaMsg kafkaMsg=JSONObject.toJavaObject(jsonObject,KafkaMsg.class);
//            System.out.println("zqb:"+kafkaMsg.toString());
        }
        return list;
    }
    public static void close()
    {
        consumer.close();
    }
}
