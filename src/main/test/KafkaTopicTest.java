import com.zqb.main.utils.KafkaTopicUtils;

/**
 * Created by zqb on 2018/4/12.
 */
public class KafkaTopicTest {

    public static void main(String[] args)
    {
        //KafkaTopicUtils.queryTopic("test");
        KafkaTopicUtils.createTopic("test",1,3);
        //KafkaTopicUtils.deleteTopic("test");
    }
}
