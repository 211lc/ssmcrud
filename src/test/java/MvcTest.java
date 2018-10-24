import com.atguigu.crud.bean.Employee;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

// 使用springtest模块
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","file:D:\\ssmcrud\\web\\WEB-INF\\dispatcherServlet-servlet.xml"})
public class MvcTest {
    // 自动装配context,要想自动装配WebApplicationContext,需要配置注解@WebAppConfiguration
    @Autowired
    WebApplicationContext context;
    // 可以使用MockMVC来模拟http请求发送
    MockMvc mockMvc;
    // 初始化MockMVC
    @Before
    public void initMockMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }
    @Test
    public void testPage() throws Exception {
        // 调用andReturn() 方法拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn","5")).andReturn();
        // 拿到Request请求信息
        MockHttpServletRequest request = result.getRequest();
        // 拿到pageInfo对象
        PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
        // 通过pi获取分页信息
        System.out.println("当前页码：" + pi.getPageNum());
        System.out.println("总页数：" + pi.getPages());
        System.out.println("总记录数：" + pi.getTotal());
        System.out.println("在页面需要连续显示的页码");
        int[] nums = pi.getNavigatepageNums();
        for (int i : nums) {
            System.out.print(i + ", ");
        }
        // 获取员工id信息
        System.out.println();
        List<Employee> employees =  pi.getList();
        for (Employee employee : employees) {
            System.out.println("员工id为：" + employee.getEmpId() + "||员工姓名为：" + employee.getEmpName());
        }
    }
}
