import com.zqb.config.MyConfig;
import com.zqb.main.dao.UserDao;
import com.zqb.main.entity.User;
import com.zqb.main.service.UserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


/**
 * Created by zqb on 2018/4/3.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = MyConfig.class)
public class UserTest {

    @Autowired
    private UserService userService;


    @Autowired
    private UserDao userDao;

    @Test
    public void addUser()
    {
        //userService.addUser();
    }


    @Test
    public void getAll()
    {
        System.out.println(userService.getAll());
    }

    @Test
    public void getUserByName()
    {
        User user=new User();
        user.setUserName(null);
        System.out.println(userService.getUserByName(user));
    }
}