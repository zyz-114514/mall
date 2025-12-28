package com.shopping.mapper;

import com.shopping.entity.OrderInfo;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface OrderMapper {
    
    int insert(OrderInfo orderInfo);
    
    int updateById(OrderInfo orderInfo);
    
    int deleteById(Long id);
    
    OrderInfo selectById(Long id);
    
    OrderInfo selectByOrderNo(String orderNo);
    
    List<OrderInfo> selectByUserId(Long userId);
    
    List<OrderInfo> selectAll();
    
    int updateStatus(@Param("id") Long id, @Param("status") Integer status);
}
