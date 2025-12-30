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
 * Order Service Test Class
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
        // Add product to cart first
        cartService.addToCart(TEST_USER_ID, TEST_PRODUCT_ID, 2);
        
        // Get cart IDs
        List<com.shopping.vo.CartVO> cartList = cartService.getCartList(TEST_USER_ID);
        List<Long> cartIds = new ArrayList<>();
        for (com.shopping.vo.CartVO cart : cartList) {
            cartIds.add(cart.getId());
        }
        
        // Create order DTO
        testOrderDTO = new OrderDTO();
        testOrderDTO.setReceiverName("Zhang San");
        testOrderDTO.setReceiverPhone("13800138000");
        testOrderDTO.setReceiverAddress("Test Address, Chaoyang District, Beijing");
        testOrderDTO.setCartIds(cartIds);
    }

    @Test
    public void testCreateOrder() {
        OrderVO order = orderService.createOrder(TEST_USER_ID, testOrderDTO);
        assertNotNull("Create order should succeed", order);
        assertNotNull("Order number should be generated", order.getOrderNo());
        assertEquals("Receiver name should match", "Zhang San", order.getReceiverName());
        assertEquals("Order status should be pending payment", Integer.valueOf(0), order.getStatus());
    }

    @Test
    public void testGetOrderById() {
        OrderVO created = orderService.createOrder(TEST_USER_ID, testOrderDTO);
        
        OrderVO found = orderService.getOrderById(created.getId());
        assertNotNull("Should be able to find order", found);
        assertEquals("Order ID should match", created.getId(), found.getId());
    }

    @Test
    public void testGetOrderByOrderNo() {
        OrderVO created = orderService.createOrder(TEST_USER_ID, testOrderDTO);
        
        OrderVO found = orderService.getOrderByOrderNo(created.getOrderNo());
        assertNotNull("Should be able to find order by order number", found);
        assertEquals("Order number should match", created.getOrderNo(), found.getOrderNo());
    }

    @Test
    public void testGetUserOrders() {
        orderService.createOrder(TEST_USER_ID, testOrderDTO);
        
        List<OrderVO> orders = orderService.getUserOrders(TEST_USER_ID);
        assertNotNull("Order list should not be null", orders);
        assertTrue("Should have order data", orders.size() > 0);
    }

    @Test
    public void testUpdateOrderStatus() {
        OrderVO created = orderService.createOrder(TEST_USER_ID, testOrderDTO);
        
        boolean result = orderService.updateOrderStatus(created.getId(), 1);
        assertTrue("Update order status should succeed", result);
        
        OrderVO updated = orderService.getOrderById(created.getId());
        assertEquals("Order status should be updated", Integer.valueOf(1), updated.getStatus());
    }

    @Test
    public void testCancelOrder() {
        OrderVO created = orderService.createOrder(TEST_USER_ID, testOrderDTO);
        
        boolean result = orderService.cancelOrder(created.getId());
        assertTrue("Cancel order should succeed", result);
        
        OrderVO cancelled = orderService.getOrderById(created.getId());
        assertEquals("Order status should be cancelled", Integer.valueOf(4), cancelled.getStatus());
    }

    @Test
    public void testGetAllOrders() {
        List<OrderVO> orders = orderService.getAllOrders();
        assertNotNull("Order list should not be null", orders);
    }
}
