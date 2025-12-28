package com.shopping.service;

import com.shopping.entity.User;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.Assert.*;

/**
 * 用户服务测试类
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/spring-context.xml"})
@Transactional
public class UserServiceTest {

    @Autowired
    private UserService userService;

    private User testUser;

    @Before
    public void setUp() {
        testUser = new User();
        testUser.setUsername("testuser" + System.currentTimeMillis());
        testUser.setPassword("test123");
        testUser.setRealName("测试用户");
        testUser.setEmail("test@example.com");
        testUser.setPhone("13800138000");
        testUser.setAddress("测试地址");
    }

    @Test
    public void testRegister() {
        User result = userService.register(testUser);
        assertNotNull("注册应该返回用户对象", result);
        assertNotNull("用户ID应该被自动生成", result.getId());
        assertEquals("用户名应该匹配", testUser.getUsername(), result.getUsername());
    }

    @Test
    public void testLogin() {
        // 先注册用户
        userService.register(testUser);
        
        // 测试登录
        User loginUser = userService.login(testUser.getUsername(), testUser.getPassword());
        assertNotNull("登录应该成功", loginUser);
        assertEquals("用户名应该匹配", testUser.getUsername(), loginUser.getUsername());
    }

    @Test
    public void testLoginWithWrongPassword() {
        userService.register(testUser);
        
        User loginUser = userService.login(testUser.getUsername(), "wrongpassword");
        assertNull("错误密码登录应该失败", loginUser);
    }

    @Test
    public void testGetUserById() {
        User registered = userService.register(testUser);
        
        User found = userService.getUserById(registered.getId());
        assertNotNull("应该能找到用户", found);
        assertEquals("用户ID应该匹配", registered.getId(), found.getId());
    }

    @Test
    public void testGetUserByUsername() {
        userService.register(testUser);
        
        User found = userService.getUserByUsername(testUser.getUsername());
        assertNotNull("应该能通过用户名找到用户", found);
        assertEquals("用户名应该匹配", testUser.getUsername(), found.getUsername());
    }

    @Test
    public void testUpdateUser() {
        User registered = userService.register(testUser);
        
        registered.setRealName("更新后的姓名");
        registered.setEmail("newemail@example.com");
        
        boolean updated = userService.updateUser(registered);
        assertTrue("更新应该成功", updated);
        
        User found = userService.getUserById(registered.getId());
        assertEquals("姓名应该已更新", "更新后的姓名", found.getRealName());
        assertEquals("邮箱应该已更新", "newemail@example.com", found.getEmail());
    }
}
