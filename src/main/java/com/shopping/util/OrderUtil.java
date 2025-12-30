package com.shopping.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class OrderUtil {

    public static String generateOrderNo() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String dateStr = sdf.format(new Date());
        Random random = new Random();
        int randomNum = random.nextInt(9000) + 1000;
        return dateStr + randomNum;
    }

    public static String getStatusDesc(Integer status) {
        if (status == null) {
            return "Unknown";
        }
        switch (status) {
            case 0:
                return "Pending Payment";
            case 1:
                return "Paid";
            case 2:
                return "Shipped";
            case 3:
                return "Completed";
            case 4:
                return "Cancelled";
            default:
                return "Unknown";
        }
    }
}
