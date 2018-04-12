import com.zqb.main.utils.TopicUtils;

/**
 * Created by zqb on 2018/4/12.
 */
public class KafkaTopicTest {
    private static final String zookeeper_connect="140.143.6.130:2181,123.207.165.243:2181,123.207.171.22:2181";

    public static void main(String[] args)
    {
        //TopicUtils.queryTopic(zookeeper_connect,"test");
        TopicUtils.createTopic("test",1,3);
        //TopicUtils.deleteTopic(zookeeper_connect,"test");
    }
}
