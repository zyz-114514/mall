package com.shopping.entity;

import lombok.Data;
import java.io.Serializable;
import java.util.Date;

@Data
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private String username;
    private String password;
    private String realName;
    private String email;
    private String phone;
    private String address;
    private String role;
    private Integer status;
    private Date createTime;
    private Date updateTime;
}
