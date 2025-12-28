package com.shopping.mapper;

import com.shopping.entity.OrderItem;
import java.util.List;

public interface OrderItemMapper {
    
    int insert(OrderItem orderItem);
    
    int batchInsert(List<OrderItem> orderItems);
    
    int deleteById(Long id);
    
    OrderItem selectById(Long id);
    
    List<OrderItem> selectByOrderId(Long orderId);
    
    List<OrderItem> selectByOrderNo(String orderNo);
}
