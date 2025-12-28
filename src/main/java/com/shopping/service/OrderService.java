package com.shopping.service;

import com.shopping.dto.OrderDTO;
import com.shopping.vo.OrderVO;
import java.util.List;

public interface OrderService {
    
    OrderVO createOrder(Long userId, OrderDTO orderDTO);
    
    OrderVO getOrderById(Long orderId);
    
    OrderVO getOrderByOrderNo(String orderNo);
    
    List<OrderVO> getUserOrders(Long userId);
    
    List<OrderVO> getAllOrders();
    
    boolean updateOrderStatus(Long orderId, Integer status);
    
    boolean cancelOrder(Long orderId);
}
