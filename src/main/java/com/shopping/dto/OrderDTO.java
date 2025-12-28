package com.shopping.dto;

import lombok.Data;
import java.io.Serializable;
import java.util.List;

@Data
public class OrderDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private String receiverName;
    private String receiverPhone;
    private String receiverAddress;
    private List<Long> cartIds;
}
