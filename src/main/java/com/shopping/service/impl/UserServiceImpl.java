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
            throw new BusinessException("用户名和密码不能为空");
        }

        int count = userMapper.countByUsername(user.getUsername());
        if (count > 0) {
            throw new BusinessException("用户名已存在");
        }

        if (user.getRole() == null) {
            user.setRole("USER");
        }
        if (user.getStatus() == null) {
            user.setStatus(1);
        }

        int result = userMapper.insert(user);
        if (result <= 0) {
            throw new BusinessException("注册失败");
        }

        logger.info("用户注册成功: {}", user.getUsername());
        return user;
    }

    @Override
    public User login(String username, String password) {
        if (username == null || password == null) {
            throw new BusinessException("用户名和密码不能为空");
        }

        User user = userMapper.selectByUsernameAndPassword(username, password);
        if (user == null) {
            throw new BusinessException("用户名或密码错误");
        }

        if (user.getStatus() == 0) {
            throw new BusinessException("账号已被禁用");
        }

        logger.info("用户登录成功: {}", username);
        return user;
    }

    @Override
    public User getUserById(Long id) {
        if (id == null) {
            throw new BusinessException("用户ID不能为空");
        }
        return userMapper.selectById(id);
    }

    @Override
    public User getUserByUsername(String username) {
        if (username == null) {
            throw new BusinessException("用户名不能为空");
        }
        return userMapper.selectByUsername(username);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateUser(User user) {
        if (user == null || user.getId() == null) {
            throw new BusinessException("用户信息不完整");
        }

        int result = userMapper.updateById(user);
        return result > 0;
    }

    @Override
    public List<User> getAllUsers() {
        try {
            return userMapper.getAllUsers();
        } catch (Exception e) {
            logger.error("获取用户列表失败: {}", e.getMessage());
            throw new BusinessException("获取用户列表失败");
        }
    }
}
