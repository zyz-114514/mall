package com.shopping.mapper;

import com.shopping.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface UserMapper {
    
    int insert(User user);
    
    int updateById(User user);
    
    int deleteById(Long id);
    
    User selectById(Long id);
    
    User selectByUsername(String username);
    
    User selectByUsernameAndPassword(@Param("username") String username, @Param("password") String password);
    
    int countByUsername(String username);
    
    List<User> getAllUsers();
}
