package com.shopping.service.impl;

import com.shopping.dto.OrderDTO;
import com.shopping.entity.OrderInfo;
import com.shopping.entity.OrderItem;
import com.shopping.exception.BusinessException;
import com.shopping.mapper.CartMapper;
import com.shopping.mapper.OrderItemMapper;
import com.shopping.mapper.OrderMapper;
import com.shopping.mapper.ProductMapper;
import com.shopping.service.OrderService;
import com.shopping.util.OrderUtil;
import com.shopping.vo.CartVO;
import com.shopping.vo.OrderVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    private static final Logger logger = LoggerFactory.getLogger(OrderServiceImpl.class);

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private OrderItemMapper orderItemMapper;

    @Autowired
    private CartMapper cartMapper;

    @Autowired
    private ProductMapper productMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public OrderVO createOrder(Long userId, OrderDTO orderDTO) {
        if (userId == null || orderDTO == null) {
            throw new BusinessException("Parameters cannot be empty");
        }

        if (orderDTO.getReceiverName() == null || orderDTO.getReceiverPhone() == null 
                || orderDTO.getReceiverAddress() == null) {
            throw new BusinessException("Shipping information is incomplete");
        }

        List<Long> cartIds = orderDTO.getCartIds();
        if (cartIds == null || cartIds.isEmpty()) {
            throw new BusinessException("Please select products to purchase");
        }

        List<CartVO> cartList = cartMapper.selectByIds(cartIds);
        if (cartList == null || cartList.isEmpty()) {
            throw new BusinessException("Cart products do not exist");
        }

        for (CartVO cart : cartList) {
            if (cart.getStock() < cart.getQuantity()) {
                throw new BusinessException("Product [" + cart.getProductName() + "] is out of stock");
            }
        }

        String orderNo = OrderUtil.generateOrderNo();
        BigDecimal totalPrice = BigDecimal.ZERO;

        OrderInfo orderInfo = new OrderInfo();
        orderInfo.setOrderNo(orderNo);
        orderInfo.setUserId(userId);
        orderInfo.setReceiverName(orderDTO.getReceiverName());
        orderInfo.setReceiverPhone(orderDTO.getReceiverPhone());
        orderInfo.setReceiverAddress(orderDTO.getReceiverAddress());
        orderInfo.setStatus(0);

        List<OrderItem> orderItems = new ArrayList<>();
        for (CartVO cart : cartList) {
            OrderItem orderItem = new OrderItem();
            orderItem.setOrderNo(orderNo);
            orderItem.setProductId(cart.getProductId());
            orderItem.setProductName(cart.getProductName());
            orderItem.setProductImage(cart.getProductImage());
            orderItem.setCurrentPrice(cart.getProductPrice());
            orderItem.setQuantity(cart.getQuantity());
            orderItem.setTotalPrice(cart.getTotalPrice());
            orderItems.add(orderItem);

            totalPrice = totalPrice.add(cart.getTotalPrice());

            int updateResult = productMapper.updateStock(cart.getProductId(), cart.getQuantity());
            if (updateResult <= 0) {
                throw new BusinessException("Product [" + cart.getProductName() + "] is out of stock");
            }
        }

        orderInfo.setTotalPrice(totalPrice);
        int orderResult = orderMapper.insert(orderInfo);
        if (orderResult <= 0) {
            throw new BusinessException("Failed to create order");
        }

        for (OrderItem item : orderItems) {
            item.setOrderId(orderInfo.getId());
        }
        int itemResult = orderItemMapper.batchInsert(orderItems);
        if (itemResult <= 0) {
            throw new BusinessException("Failed to create order items");
        }

        cartMapper.deleteByIds(cartIds);

        logger.info("Order created successfully: orderNo={}, userId={}, totalPrice={}", orderNo, userId, totalPrice);

        return getOrderByOrderNo(orderNo);
    }

    @Override
    public OrderVO getOrderById(Long orderId) {
        if (orderId == null) {
            throw new BusinessException("Order ID cannot be empty");
        }

        OrderInfo orderInfo = orderMapper.selectById(orderId);
        if (orderInfo == null) {
            throw new BusinessException("Order does not exist");
        }

        return convertToOrderVO(orderInfo);
    }

    @Override
    public OrderVO getOrderByOrderNo(String orderNo) {
        if (orderNo == null) {
            throw new BusinessException("Order number cannot be empty");
        }

        OrderInfo orderInfo = orderMapper.selectByOrderNo(orderNo);
        if (orderInfo == null) {
            throw new BusinessException("Order does not exist");
        }

        return convertToOrderVO(orderInfo);
    }

    @Override
    public List<OrderVO> getUserOrders(Long userId) {
        if (userId == null) {
            throw new BusinessException("User ID cannot be empty");
        }

        List<OrderInfo> orderInfoList = orderMapper.selectByUserId(userId);
        return convertToOrderVOList(orderInfoList);
    }

    @Override
    public List<OrderVO> getAllOrders() {
        List<OrderInfo> orderInfoList = orderMapper.selectAll();
        return convertToOrderVOList(orderInfoList);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateOrderStatus(Long orderId, Integer status) {
        if (orderId == null || status == null) {
            throw new BusinessException("Parameters cannot be empty");
        }

        int result = orderMapper.updateStatus(orderId, status);
        if (result > 0) {
            logger.info("Order status updated successfully: orderId={}, status={}", orderId, status);
            return true;
        }
        return false;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean cancelOrder(Long orderId) {
        if (orderId == null) {
            throw new BusinessException("Order ID cannot be empty");
        }

        OrderInfo orderInfo = orderMapper.selectById(orderId);
        if (orderInfo == null) {
            throw new BusinessException("Order does not exist");
        }

        if (orderInfo.getStatus() != 0) {
            throw new BusinessException("Only pending payment orders can be cancelled");
        }

        int result = orderMapper.updateStatus(orderId, 4);
        if (result > 0) {
            logger.info("Order cancelled successfully: orderId={}", orderId);
            return true;
        }
        return false;
    }

    private OrderVO convertToOrderVO(OrderInfo orderInfo) {
        OrderVO orderVO = new OrderVO();
        BeanUtils.copyProperties(orderInfo, orderVO);
        orderVO.setStatusDesc(OrderUtil.getStatusDesc(orderInfo.getStatus()));

        List<OrderItem> orderItems = orderItemMapper.selectByOrderId(orderInfo.getId());
        orderVO.setOrderItems(orderItems);

        return orderVO;
    }

    private List<OrderVO> convertToOrderVOList(List<OrderInfo> orderInfoList) {
        List<OrderVO> orderVOList = new ArrayList<>();
        if (orderInfoList != null && !orderInfoList.isEmpty()) {
            for (OrderInfo orderInfo : orderInfoList) {
                orderVOList.add(convertToOrderVO(orderInfo));
            }
        }
        return orderVOList;
    }
}
