package com.shopping.service.impl;

import com.shopping.entity.Cart;
import com.shopping.entity.Product;
import com.shopping.exception.BusinessException;
import com.shopping.mapper.CartMapper;
import com.shopping.mapper.ProductMapper;
import com.shopping.service.CartService;
import com.shopping.vo.CartVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class CartServiceImpl implements CartService {

    private static final Logger logger = LoggerFactory.getLogger(CartServiceImpl.class);

    @Autowired
    private CartMapper cartMapper;

    @Autowired
    private ProductMapper productMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addToCart(Long userId, Long productId, Integer quantity) {
        if (userId == null || productId == null) {
            throw new BusinessException("Parameters cannot be empty");
        }
        if (quantity == null || quantity <= 0) {
            quantity = 1;
        }

        Product product = productMapper.selectById(productId);
        if (product == null) {
            throw new BusinessException("Product does not exist");
        }
        if (product.getStatus() == 0) {
            throw new BusinessException("Product is off the shelf");
        }
        if (product.getStock() < quantity) {
            throw new BusinessException("Product is out of stock");
        }

        Cart existCart = cartMapper.selectByUserIdAndProductId(userId, productId);
        if (existCart != null) {
            int newQuantity = existCart.getQuantity() + quantity;
            if (product.getStock() < newQuantity) {
                throw new BusinessException("Product is out of stock");
            }
            existCart.setQuantity(newQuantity);
            int result = cartMapper.updateById(existCart);
            if (result > 0) {
                logger.info("Cart updated successfully: userId={}, productId={}", userId, productId);
                return true;
            }
        } else {
            Cart cart = new Cart();
            cart.setUserId(userId);
            cart.setProductId(productId);
            cart.setQuantity(quantity);
            cart.setChecked(1);
            int result = cartMapper.insert(cart);
            if (result > 0) {
                logger.info("Added to cart successfully: userId={}, productId={}", userId, productId);
                return true;
            }
        }
        return false;
    }

    @Override
    public List<CartVO> getCartList(Long userId) {
        if (userId == null) {
            throw new BusinessException("User ID cannot be empty");
        }
        return cartMapper.selectByUserId(userId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateQuantity(Long cartId, Integer quantity) {
        if (cartId == null || quantity == null || quantity <= 0) {
            throw new BusinessException("Invalid parameters");
        }

        Cart cart = cartMapper.selectById(cartId);
        if (cart == null) {
            throw new BusinessException("Cart item does not exist");
        }

        Product product = productMapper.selectById(cart.getProductId());
        if (product == null || product.getStatus() == 0) {
            throw new BusinessException("Product does not exist or is off the shelf");
        }
        if (product.getStock() < quantity) {
            throw new BusinessException("Product is out of stock");
        }

        int result = cartMapper.updateQuantity(cartId, quantity);
        return result > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateChecked(Long cartId, Integer checked) {
        if (cartId == null || checked == null) {
            throw new BusinessException("Invalid parameters");
        }

        int result = cartMapper.updateChecked(cartId, checked);
        return result > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateAllChecked(Long userId, Integer checked) {
        if (userId == null || checked == null) {
            throw new BusinessException("Invalid parameters");
        }

        int result = cartMapper.updateAllChecked(userId, checked);
        return result > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteCart(Long cartId) {
        if (cartId == null) {
            throw new BusinessException("Cart ID cannot be empty");
        }

        int result = cartMapper.deleteById(cartId);
        return result > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteCartItems(List<Long> cartIds) {
        if (cartIds == null || cartIds.isEmpty()) {
            throw new BusinessException("Cart ID list cannot be empty");
        }

        int result = cartMapper.deleteByIds(cartIds);
        return result > 0;
    }
}
