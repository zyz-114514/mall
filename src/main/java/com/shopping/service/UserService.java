package com.shopping.service;

import com.shopping.entity.User;
import java.util.List;

public interface UserService {
    
    User register(User user);
    
    User login(String username, String password);
    
    User getUserById(Long id);
    
    User getUserByUsername(String username);
    
    boolean updateUser(User user);
    
    List<User> getAllUsers();
}
