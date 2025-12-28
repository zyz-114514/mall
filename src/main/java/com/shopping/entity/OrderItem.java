package com.shopping.entity;

import lombok.Data;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

@Data
public class OrderItem implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long orderId;
    private String orderNo;
    private Long productId;
    private String productName;
    private String productImage;
    private BigDecimal currentPrice;
    private Integer quantity;
    private BigDecimal totalPrice;
    private Date createTime;
    private Date updateTime;
}
