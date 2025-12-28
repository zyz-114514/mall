package com.shopping.mapper;

import com.shopping.entity.Cart;
import com.shopping.vo.CartVO;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface CartMapper {
    
    int insert(Cart cart);
    
    int updateById(Cart cart);
    
    int deleteById(Long id);
    
    int deleteByIds(@Param("ids") List<Long> ids);
    
    Cart selectById(Long id);
    
    Cart selectByUserIdAndProductId(@Param("userId") Long userId, @Param("productId") Long productId);
    
    List<CartVO> selectByUserId(Long userId);
    
    List<CartVO> selectCheckedByUserId(Long userId);
    
    List<CartVO> selectByIds(@Param("ids") List<Long> ids);
    
    int updateQuantity(@Param("id") Long id, @Param("quantity") Integer quantity);
    
    int updateChecked(@Param("id") Long id, @Param("checked") Integer checked);
    
    int updateAllChecked(@Param("userId") Long userId, @Param("checked") Integer checked);
}
