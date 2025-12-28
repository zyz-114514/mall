package com.shopping.controller;

import com.shopping.dto.OrderDTO;
import com.shopping.entity.User;
import com.shopping.service.OrderService;
import com.shopping.util.Result;
import com.shopping.vo.OrderVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping("/list")
    public String orderList(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        List<OrderVO> orderList = orderService.getUserOrders(user.getId());
        model.addAttribute("orderList", orderList);
        return "order/list";
    }

    @GetMapping("/detail/{id}")
    public String orderDetail(@PathVariable Long id, Model model) {
        OrderVO order = orderService.getOrderById(id);
        model.addAttribute("order", order);
        return "order/detail";
    }

    @GetMapping("/confirm")
    public String confirmOrder(@RequestParam String cartIds, 
                              HttpSession session, 
                              Model model) {
        User user = (User) session.getAttribute("user");
        model.addAttribute("user", user);
        model.addAttribute("cartIds", cartIds);
        return "order/confirm";
    }

    @PostMapping("/create")
    @ResponseBody
    public Result<OrderVO> createOrder(@RequestBody OrderDTO orderDTO, 
                                       HttpSession session) {
        User user = (User) session.getAttribute("user");
        OrderVO order = orderService.createOrder(user.getId(), orderDTO);
        return Result.success("订单创建成功", order);
    }

    @PostMapping("/cancel/{id}")
    @ResponseBody
    public Result<?> cancelOrder(@PathVariable Long id) {
        boolean success = orderService.cancelOrder(id);
        if (success) {
            return Result.success("订单已取消");
        }
        return Result.error("取消订单失败");
    }

    @PostMapping("/updateStatus")
    @ResponseBody
    public Result<?> updateOrderStatus(@RequestParam Long orderId,
                                       @RequestParam Integer status) {
        boolean success = orderService.updateOrderStatus(orderId, status);
        if (success) {
            return Result.success("更新成功");
        }
        return Result.error("更新失败");
    }
}
