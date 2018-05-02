import com.zqb.main.utils.KafkaProducerUtils;

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
            KafkaProducerUtils.senStrMsg("mytest",line);
            line = scanner.nextLine();
        }
    }

}
