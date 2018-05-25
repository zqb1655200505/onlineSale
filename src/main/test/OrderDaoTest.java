import com.zqb.config.MyConfig;
import com.zqb.main.dao.OrderDao;
import com.zqb.main.dao.OrderGoodsDao;
import com.zqb.main.dto.Page;
import com.zqb.main.entity.Order;
import com.zqb.main.entity.OrderGoods;
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

    @Autowired
    private OrderGoodsDao orderGoodsDao;

    @Test
    public void getOrderByBuyer() throws Exception {
        //System.out.println(orderDao.getOrderByBuyer("c1409d9c3b794b91867144e2aba05304"));
    }

    @Test
    public void getSellerOrder() throws Exception {
        OrderGoods order=new OrderGoods();
        Page<OrderGoods> page=new Page<OrderGoods>(1, 10);
        page.setFuncName("changePage");
        order.setPage(page);
        System.out.println(orderGoodsDao.getSellerOrder(order,"c1409d9c3b794b91867144e2aba05304"));
    }

}