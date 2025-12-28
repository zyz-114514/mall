package com.shopping.vo;

import lombok.Data;
import java.io.Serializable;
import java.math.BigDecimal;

@Data
public class CartVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long userId;
    private Long productId;
    private String productName;
    private String productImage;
    private BigDecimal productPrice;
    private Integer quantity;
    private Integer checked;
    private Integer stock;
    private BigDecimal totalPrice;
}
