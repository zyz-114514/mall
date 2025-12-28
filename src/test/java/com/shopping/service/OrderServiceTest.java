package com.shopping.service;

import com.shopping.dto.OrderDTO;
import com.shopping.vo.OrderVO;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.*;

/**
 * 订单服务测试类
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/spring-context.xml"})
@Transactional
public class OrderServiceTest {

    @Autowired
    private OrderService orderService;
    
    @Autowired
    private CartService cartService;

    private static final Long TEST_USER_ID = 2L;
    private static final Long TEST_PRODUCT_ID = 1L;
    private OrderDTO testOrderDTO;

    @Before
    public void setUp() {
        // 先添加商品到购物车
        cartService.addToCart(TEST_USER_ID, TEST_PRODUCT_ID, 2);
        
        // 获取购物车ID
        List<com.shopping.vo.CartVO> cartList = cartService.getCartList(TEST_USER_ID);
        List<Long> cartIds = new ArrayList<>();
        for (com.shopping.vo.CartVO cart : cartList) {
            cartIds.add(cart.getId());
        }
        
        // 创建订单DTO
        testOrderDTO = new OrderDTO();
        testOrderDTO.setReceiverName("张三");
        testOrderDTO.setReceiverPhone("13800138000");
        testOrderDTO.setReceiverAddress("北京市朝阳区测试地址");
        testOrderDTO.setCartIds(cartIds);
    }

    @Test
    public void testCreateOrder() {
        OrderVO order = orderService.createOrder(TEST_USER_ID, testOrderDTO);
        assertNotNull("创建订单应该成功", order);
        assertNotNull("订单号应该被生成", order.getOrderNo());
        assertEquals("收货人应该匹配", "张三", order.getReceiverName());
        assertEquals("订单状态应该为待支付", Integer.valueOf(0), order.getStatus());
    }

    @Test
    public void testGetOrderById() {
        OrderVO created = orderService.createOrder(TEST_USER_ID, testOrderDTO);
        
        OrderVO found = orderService.getOrderById(created.getId());
        assertNotNull("应该能找到订单", found);
        assertEquals("订单ID应该匹配", created.getId(), found.getId());
    }

    @Test
    public void testGetOrderByOrderNo() {
        OrderVO created = orderService.createOrder(TEST_USER_ID, testOrderDTO);
        
        OrderVO found = orderService.getOrderByOrderNo(created.getOrderNo());
        assertNotNull("应该能通过订单号找到订单", found);
        assertEquals("订单号应该匹配", created.getOrderNo(), found.getOrderNo());
    }

    @Test
    public void testGetUserOrders() {
        orderService.createOrder(TEST_USER_ID, testOrderDTO);
        
        List<OrderVO> orders = orderService.getUserOrders(TEST_USER_ID);
        assertNotNull("订单列表不应为空", orders);
        assertTrue("应该有订单数据", orders.size() > 0);
    }

    @Test
    public void testUpdateOrderStatus() {
        OrderVO created = orderService.createOrder(TEST_USER_ID, testOrderDTO);
        
        boolean result = orderService.updateOrderStatus(created.getId(), 1);
        assertTrue("更新订单状态应该成功", result);
        
        OrderVO updated = orderService.getOrderById(created.getId());
        assertEquals("订单状态应该已更新", Integer.valueOf(1), updated.getStatus());
    }

    @Test
    public void testCancelOrder() {
        OrderVO created = orderService.createOrder(TEST_USER_ID, testOrderDTO);
        
        boolean result = orderService.cancelOrder(created.getId());
        assertTrue("取消订单应该成功", result);
        
        OrderVO cancelled = orderService.getOrderById(created.getId());
        assertEquals("订单状态应该为已取消", Integer.valueOf(4), cancelled.getStatus());
    }

    @Test
    public void testGetAllOrders() {
        List<OrderVO> orders = orderService.getAllOrders();
        assertNotNull("订单列表不应为空", orders);
    }
}
