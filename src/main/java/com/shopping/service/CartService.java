package com.shopping.service;

import com.shopping.vo.CartVO;
import java.util.List;

public interface CartService {
    
    boolean addToCart(Long userId, Long productId, Integer quantity);
    
    List<CartVO> getCartList(Long userId);
    
    boolean updateQuantity(Long cartId, Integer quantity);
    
    boolean updateChecked(Long cartId, Integer checked);
    
    boolean updateAllChecked(Long userId, Integer checked);
    
    boolean deleteCart(Long cartId);
    
    boolean deleteCartItems(List<Long> cartIds);
}
