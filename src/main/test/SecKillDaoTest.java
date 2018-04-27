import com.zqb.config.MyConfig;
import com.zqb.main.dao.SecKillDao;
import com.zqb.main.dto.Page;
import com.zqb.main.entity.Goods;
import com.zqb.main.entity.Seckill;
import com.zqb.main.entity.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;

/**
 * Created by zqb on 2018/4/20.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = MyConfig.class)
public class SecKillDaoTest {

    @Autowired
    private SecKillDao secKillDao;

    @Test
    public void getMySecKillGoods() throws Exception {
        User user=new User();
        user.setId("c1409d9c3b794b91867144e2aba05304");
        Goods goods=new Goods();
        goods.setUser(user);
        Seckill seckill=new Seckill();
        seckill.setGoods(goods);
        Page<Seckill> page=new Page<Seckill>(1,10);
        seckill.setPage(page);
        System.out.println(secKillDao.getMySecKillGoods(seckill));
    }

    @Test
    public void getSecKillGoodsPrice()
    {
        System.out.println(secKillDao.getSecKillGoodsPrice("437f12bfcf0e4943a409692c857857f2"));
    }

}