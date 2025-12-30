package com.shopping.service;

import com.shopping.vo.CartVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static org.junit.Assert.*;

/**
 * Cart Service Test Class
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/spring-context.xml"})
@Transactional
public class CartServiceTest {

    @Autowired
    private CartService cartService;

    private static final Long TEST_USER_ID = 2L;
    private static final Long TEST_PRODUCT_ID = 1L;

    @Test
    public void testAddToCart() {
        boolean result = cartService.addToCart(TEST_USER_ID, TEST_PRODUCT_ID, 2);
        assertTrue("Add to cart should succeed", result);
    }

    @Test
    public void testGetUserCart() {
        cartService.addToCart(TEST_USER_ID, TEST_PRODUCT_ID, 1);
        
        List<CartVO> cartList = cartService.getCartList(TEST_USER_ID);
        assertNotNull("Cart list should not be null", cartList);
        assertTrue("Cart should have items", cartList.size() > 0);
    }

    @Test
    public void testUpdateCartQuantity() {
        cartService.addToCart(TEST_USER_ID, TEST_PRODUCT_ID, 1);
        
        List<CartVO> cartList = cartService.getCartList(TEST_USER_ID);
        Long cartId = cartList.get(0).getId();
        
        boolean result = cartService.updateQuantity(cartId, 5);
        assertTrue("Update quantity should succeed", result);
        
        cartList = cartService.getCartList(TEST_USER_ID);
        assertEquals("Quantity should be updated", Integer.valueOf(5), cartList.get(0).getQuantity());
    }

    @Test
    public void testUpdateCartChecked() {
        cartService.addToCart(TEST_USER_ID, TEST_PRODUCT_ID, 1);
        
        List<CartVO> cartList = cartService.getCartList(TEST_USER_ID);
        Long cartId = cartList.get(0).getId();
        
        boolean result = cartService.updateChecked(cartId, 0);
        assertTrue("Update checked status should succeed", result);
    }

    @Test
    public void testDeleteCartItem() {
        cartService.addToCart(TEST_USER_ID, TEST_PRODUCT_ID, 1);
        
        List<CartVO> cartList = cartService.getCartList(TEST_USER_ID);
        Long cartId = cartList.get(0).getId();
        
        boolean result = cartService.deleteCart(cartId);
        assertTrue("Delete cart item should succeed", result);
    }

    @Test
    public void testClearCart() {
        cartService.addToCart(TEST_USER_ID, TEST_PRODUCT_ID, 1);
        cartService.addToCart(TEST_USER_ID, 2L, 1);
        
        List<CartVO> cartList = cartService.getCartList(TEST_USER_ID);
        List<Long> cartIds = new java.util.ArrayList<>();
        for (CartVO cart : cartList) {
            cartIds.add(cart.getId());
        }
        
        boolean result = cartService.deleteCartItems(cartIds);
        assertTrue("Clear cart should succeed", result);
        
        cartList = cartService.getCartList(TEST_USER_ID);
        assertEquals("Cart should be empty", 0, cartList.size());
    }
}
