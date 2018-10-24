import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

// @ContextConfiguration(locations指定spring配置文件位置，这样不用自己获得spring的ioc容器
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;
    // 测试DepartmentMapper
    @Test
    public void testCRUD() throws Exception {
        System.out.println(departmentMapper);
        // 如果插入中文乱码，在dbconfig.properties文件中的url中配置?characterEncoding=utf8;
//        departmentMapper.insertSelective(new Department(1, "开发部"));
//        departmentMapper.insertSelective(new Department(2, "测试部"));
        // 插入员工数据
//        employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "Jerry@qq.com", 1));
        // 批量插入员工数据
        EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String uid = UUID.randomUUID().toString().substring(0,5) + i;
            employeeMapper.insertSelective(new Employee(null, uid, "M", uid + "@qq.com", 1));
        }
    }
}
