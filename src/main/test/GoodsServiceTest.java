import com.zqb.config.MyConfig;
import com.zqb.main.dto.Page;
import com.zqb.main.entity.Goods;
import com.zqb.main.entity.User;
import com.zqb.main.service.GoodsService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;

/**
 * Created by zqb on 2018/4/18.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = MyConfig.class)
public class GoodsServiceTest {

    @Autowired
    private GoodsService goodsService;

    @Test
    public void getGoodsByUser() throws Exception {
        Goods goods=new Goods();
        goods.setPage(new Page<Goods>(2,5));
        User user=new User();
        user.setId("c1409d9c3b794b91867144e2aba05304");
        goods.setUser(user);
        System.out.println(goodsService.getGoodsByUser(goods));
    }


    @Test
    public void getCountByUser() throws Exception {
        Goods goods=new Goods();
        User user=new User();
        user.setId("c1409d9c3b794b91867144e2aba05304");
        goods.setUser(user);
        System.out.println(goodsService.getCountByUser(goods));
    }

    @Test
    public void changeStatus()
    {
        System.out.println(goodsService.changeStatus("3ada14e323ca43f0891d5e2d05976cc5",true));
    }
}