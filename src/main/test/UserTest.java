import com.zqb.config.MyConfig;
import com.zqb.main.dao.UserDao;
import com.zqb.main.entity.User;
import com.zqb.main.entity.UserType;
import com.zqb.main.service.UserService;
import com.zqb.main.utils.Encryption;
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
        User user=new User();
        user.setUserName("zqb");
        user.setUserPassword(Encryption.entryptPasswordMD5("123456"));
        user.setUserType(UserType.ADMINISTRATOR);
        user.preInsert();
        userService.addUser(user);
    }


    @Test
    public void getAll()
    {
        System.out.println(userService.getAll());
    }

    @Test
    public void getUserByName()
    {
        System.out.println(userService.getUserByName("zqb"));
    }

    @Test
    public void getUserByNameAndPwd()
    {
        System.out.println(userService.getUserByNameAndPwd("zqb","123456"));
    }
}