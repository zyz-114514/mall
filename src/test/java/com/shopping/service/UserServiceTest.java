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
 * User Service Test Class
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
        testUser.setRealName("Test User");
        testUser.setEmail("test@example.com");
        testUser.setPhone("13800138000");
        testUser.setAddress("Test Address");
    }

    @Test
    public void testRegister() {
        User result = userService.register(testUser);
        assertNotNull("Registration should return user object", result);
        assertNotNull("User ID should be auto-generated", result.getId());
        assertEquals("Username should match", testUser.getUsername(), result.getUsername());
    }

    @Test
    public void testLogin() {
        // Register user first
        userService.register(testUser);
        
        // Test login
        User loginUser = userService.login(testUser.getUsername(), testUser.getPassword());
        assertNotNull("Login should succeed", loginUser);
        assertEquals("Username should match", testUser.getUsername(), loginUser.getUsername());
    }

    @Test
    public void testLoginWithWrongPassword() {
        userService.register(testUser);
        
        User loginUser = userService.login(testUser.getUsername(), "wrongpassword");
        assertNull("Login with wrong password should fail", loginUser);
    }

    @Test
    public void testGetUserById() {
        User registered = userService.register(testUser);
        
        User found = userService.getUserById(registered.getId());
        assertNotNull("Should be able to find user", found);
        assertEquals("User ID should match", registered.getId(), found.getId());
    }

    @Test
    public void testGetUserByUsername() {
        userService.register(testUser);
        
        User found = userService.getUserByUsername(testUser.getUsername());
        assertNotNull("Should be able to find user by username", found);
        assertEquals("Username should match", testUser.getUsername(), found.getUsername());
    }

    @Test
    public void testUpdateUser() {
        User registered = userService.register(testUser);
        
        registered.setRealName("Updated Name");
        registered.setEmail("newemail@example.com");
        
        boolean updated = userService.updateUser(registered);
        assertTrue("Update should succeed", updated);
        
        User found = userService.getUserById(registered.getId());
        assertEquals("Name should be updated", "Updated Name", found.getRealName());
        assertEquals("Email should be updated", "newemail@example.com", found.getEmail());
    }
}
