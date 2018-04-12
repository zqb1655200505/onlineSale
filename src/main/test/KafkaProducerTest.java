import com.zqb.main.dto.KafkaMsg;
import com.zqb.main.utils.ProducerUtils;

import java.util.Date;
import java.util.Scanner;

/**
 * Created by zqb on 2018/4/4.
 */
public class KafkaProducerTest {

    public static void main(String[] args)
    {
        Scanner scanner = new Scanner(System.in);
        String line = scanner.nextLine();
        while(!line.equals("exit"))
        {
            ProducerUtils.senMsg("mytest",line);
            line = scanner.nextLine();
        }
    }

}
