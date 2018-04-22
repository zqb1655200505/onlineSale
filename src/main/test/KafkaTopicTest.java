import com.zqb.main.utils.KafkaTopicUtils;

/**
 * Created by zqb on 2018/4/12.
 */
public class KafkaTopicTest {
    private static final String zookeeper_connect="140.143.6.130:2181,123.207.165.243:2181,123.207.171.22:2181";

    public static void main(String[] args)
    {
        //KafkaTopicUtils.queryTopic(zookeeper_connect,"test");
        KafkaTopicUtils.createTopic("test",1,3);
        //KafkaTopicUtils.deleteTopic(zookeeper_connect,"test");
    }
}
