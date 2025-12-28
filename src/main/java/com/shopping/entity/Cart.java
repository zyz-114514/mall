package com.shopping.entity;

import lombok.Data;
import java.io.Serializable;
import java.util.Date;

@Data
public class Cart implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long userId;
    private Long productId;
    private Integer quantity;
    private Integer checked;
    private Date createTime;
    private Date updateTime;
}
