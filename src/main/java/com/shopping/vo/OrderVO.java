package com.shopping.vo;

import com.shopping.entity.OrderItem;
import lombok.Data;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Data
public class OrderVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private String orderNo;
    private Long userId;
    private String receiverName;
    private String receiverPhone;
    private String receiverAddress;
    private BigDecimal totalPrice;
    private Integer status;
    private String statusDesc;
    private Date paymentTime;
    private Date sendTime;
    private Date endTime;
    private Date createTime;
    private List<OrderItem> orderItems;
}
