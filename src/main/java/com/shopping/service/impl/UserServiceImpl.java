package com.shopping.service.impl;

import com.shopping.entity.User;
import com.shopping.exception.BusinessException;
import com.shopping.mapper.UserMapper;
import com.shopping.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    private static final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);

    @Autowired
    private UserMapper userMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public User register(User user) {
        if (user == null || user.getUsername() == null || user.getPassword() == null) {
            throw new BusinessException("Username and password cannot be empty");
        }

        int count = userMapper.countByUsername(user.getUsername());
        if (count > 0) {
            throw new BusinessException("Username already exists");
        }

        if (user.getRole() == null) {
            user.setRole("USER");
        }
        if (user.getStatus() == null) {
            user.setStatus(1);
        }

        int result = userMapper.insert(user);
        if (result <= 0) {
            throw new BusinessException("Registration failed");
        }

        logger.info("User registered successfully: {}", user.getUsername());
        return user;
    }

    @Override
    public User login(String username, String password) {
        if (username == null || password == null) {
            throw new BusinessException("Username and password cannot be empty");
        }

        User user = userMapper.selectByUsernameAndPassword(username, password);
        if (user == null) {
            throw new BusinessException("Invalid username or password");
        }

        if (user.getStatus() == 0) {
            throw new BusinessException("Account has been disabled");
        }

        logger.info("User logged in successfully: {}", username);
        return user;
    }

    @Override
    public User getUserById(Long id) {
        if (id == null) {
            throw new BusinessException("User ID cannot be empty");
        }
        return userMapper.selectById(id);
    }

    @Override
    public User getUserByUsername(String username) {
        if (username == null) {
            throw new BusinessException("Username cannot be empty");
        }
        return userMapper.selectByUsername(username);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateUser(User user) {
        if (user == null || user.getId() == null) {
            throw new BusinessException("User information is incomplete");
        }

        int result = userMapper.updateById(user);
        return result > 0;
    }

    @Override
    public List<User> getAllUsers() {
        try {
            return userMapper.getAllUsers();
        } catch (Exception e) {
            logger.error("Failed to get user list: {}", e.getMessage());
            throw new BusinessException("Failed to get user list");
        }
    }
}
