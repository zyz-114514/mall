package com.shopping.entity;

import lombok.Data;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

@Data
public class OrderInfo implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private String orderNo;
    private Long userId;
    private String receiverName;
    private String receiverPhone;
    private String receiverAddress;
    private BigDecimal totalPrice;
    private Integer status;
    private Date paymentTime;
    private Date sendTime;
    private Date endTime;
    private Date createTime;
    private Date updateTime;
}
