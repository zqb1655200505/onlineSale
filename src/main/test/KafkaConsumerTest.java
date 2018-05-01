import com.zqb.main.dto.KafkaMsg;
import com.zqb.main.utils.KafkaConsumerUtils;

import java.util.List;

/**
 * Created by zqb on 2018/4/4.
 */
public class KafkaConsumerTest extends Thread{

    public static void main(String[] args)
    {
        new KafkaConsumerTest().start();
    }

    @Override
    public void run()
    {
        while (true)
        {
           List<KafkaMsg> list= KafkaConsumerUtils.getRowMessage("mytest");
           if(list.size()>0)
           {
               System.out.println("收到消息");
               System.out.println(list);
           }

        }
    }
}
