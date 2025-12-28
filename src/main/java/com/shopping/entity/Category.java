package com.shopping.entity;

import lombok.Data;
import java.io.Serializable;
import java.util.Date;

@Data
public class Category implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private String name;
    private Long parentId;
    private Integer sortOrder;
    private Integer status;
    private Date createTime;
    private Date updateTime;
}
