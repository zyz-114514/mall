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
 * 购物车服务测试类
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
        assertTrue("添加到购物车应该成功", result);
    }

    @Test
    public void testGetUserCart() {
        cartService.addToCart(TEST_USER_ID, TEST_PRODUCT_ID, 1);
        
        List<CartVO> cartList = cartService.getCartList(TEST_USER_ID);
        assertNotNull("购物车列表不应为空", cartList);
        assertTrue("购物车应该有商品", cartList.size() > 0);
    }

    @Test
    public void testUpdateCartQuantity() {
        cartService.addToCart(TEST_USER_ID, TEST_PRODUCT_ID, 1);
        
        List<CartVO> cartList = cartService.getCartList(TEST_USER_ID);
        Long cartId = cartList.get(0).getId();
        
        boolean result = cartService.updateQuantity(cartId, 5);
        assertTrue("更新数量应该成功", result);
        
        cartList = cartService.getCartList(TEST_USER_ID);
        assertEquals("数量应该已更新", Integer.valueOf(5), cartList.get(0).getQuantity());
    }

    @Test
    public void testUpdateCartChecked() {
        cartService.addToCart(TEST_USER_ID, TEST_PRODUCT_ID, 1);
        
        List<CartVO> cartList = cartService.getCartList(TEST_USER_ID);
        Long cartId = cartList.get(0).getId();
        
        boolean result = cartService.updateChecked(cartId, 0);
        assertTrue("更新选中状态应该成功", result);
    }

    @Test
    public void testDeleteCartItem() {
        cartService.addToCart(TEST_USER_ID, TEST_PRODUCT_ID, 1);
        
        List<CartVO> cartList = cartService.getCartList(TEST_USER_ID);
        Long cartId = cartList.get(0).getId();
        
        boolean result = cartService.deleteCart(cartId);
        assertTrue("删除购物车项应该成功", result);
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
        assertTrue("清空购物车应该成功", result);
        
        cartList = cartService.getCartList(TEST_USER_ID);
        assertEquals("购物车应该为空", 0, cartList.size());
    }
}
