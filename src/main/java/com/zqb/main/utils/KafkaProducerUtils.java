package com.zqb.main.utils;

import com.alibaba.fastjson.JSON;
import com.zqb.main.dto.KafkaMsg;
import org.apache.kafka.clients.producer.*;

import java.util.Properties;

/**
 * Created by zqb on 2018/4/12.
 */
public class KafkaProducerUtils {

    private static final String bootstrap_servers="140.143.6.130:9092,123.207.165.243:9092,123.207.171.22:9092";
    private static KafkaProducer producer;
    static {

        Properties props = new Properties();
        props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG,bootstrap_servers);
        props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG,"org.apache.kafka.common.serialization.StringSerializer");
        props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG,"org.apache.kafka.common.serialization.StringSerializer");
        props.put(ProducerConfig.ACKS_CONFIG, "all");
        props.put(ProducerConfig.RETRIES_CONFIG, 0);
        props.put(ProducerConfig.BATCH_SIZE_CONFIG, 16384);
        props.put(ProducerConfig.LINGER_MS_CONFIG, 1);
        props.put(ProducerConfig.BUFFER_MEMORY_CONFIG, 33554432);
        producer = new KafkaProducer<String,String>(props);
    }


    //不要key，key的作用是选择分区时hash(key)%partitionNum选择分区，未设置则按顺序选择分区，平均分发到所有分区
    public static void senStrMsg(String topic,String msg)
    {
        ProducerRecord<String, String> rec = new ProducerRecord<String, String>(topic,msg);
        producer.send(rec, new Callback() {
            @Override
            public void onCompletion(RecordMetadata recordMetadata, Exception e) {
                System.out.println("offset="+recordMetadata.offset()+",partition="+recordMetadata.partition());
            }
        });
    }

    public static void senObjMsg(String topic,Object msg)
    {
        ProducerRecord<String, Object> rec = new ProducerRecord<String, Object>(topic,msg);
        producer.send(rec);
    }



    public static void close()
    {
        producer.close();
    }

}
