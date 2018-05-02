import com.zqb.config.MyConfig;
import com.zqb.main.dao.OrderDao;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;

/**
 * Created by zqb on 2018/4/27.
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = MyConfig.class)
public class OrderDaoTest {

    @Autowired
    private OrderDao orderDao;

    @Test
    public void getOrderByBuyer() throws Exception {
        //System.out.println(orderDao.getOrderByBuyer("c1409d9c3b794b91867144e2aba05304"));
    }

    @Test
    public void getSellerOrder() throws Exception {
        System.out.println(orderDao.getSellerOrder("c1409d9c3b794b91867144e2aba05304"));
    }

}