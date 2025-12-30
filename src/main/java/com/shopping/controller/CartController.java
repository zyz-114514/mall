package com.shopping.controller;

import com.shopping.entity.User;
import com.shopping.service.CartService;
import com.shopping.util.Result;
import com.shopping.vo.CartVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    @GetMapping("/list")
    public String cartList(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        List<CartVO> cartList = cartService.getCartList(user.getId());
        model.addAttribute("cartList", cartList);
        return "cart/list";
    }

    @PostMapping("/add")
    @ResponseBody
    public Result<?> addToCart(@RequestParam Long productId,
                               @RequestParam(defaultValue = "1") Integer quantity,
                               HttpSession session) {
        User user = (User) session.getAttribute("user");
        boolean success = cartService.addToCart(user.getId(), productId, quantity);
        if (success) {
            return Result.success("Added successfully");
        }
        return Result.error("Failed to add");
    }

    @PostMapping("/updateQuantity")
    @ResponseBody
    public Result<?> updateQuantity(@RequestParam Long cartId,
                                    @RequestParam Integer quantity) {
        boolean success = cartService.updateQuantity(cartId, quantity);
        if (success) {
            return Result.success("Updated successfully");
        }
        return Result.error("Update failed");
    }

    @PostMapping("/updateChecked")
    @ResponseBody
    public Result<?> updateChecked(@RequestParam Long cartId,
                                   @RequestParam Integer checked) {
        boolean success = cartService.updateChecked(cartId, checked);
        if (success) {
            return Result.success("Updated successfully");
        }
        return Result.error("Update failed");
    }

    @PostMapping("/updateAllChecked")
    @ResponseBody
    public Result<?> updateAllChecked(@RequestParam Integer checked,
                                      HttpSession session) {
        User user = (User) session.getAttribute("user");
        boolean success = cartService.updateAllChecked(user.getId(), checked);
        if (success) {
            return Result.success("Updated successfully");
        }
        return Result.error("Update failed");
    }

    @PostMapping("/delete")
    @ResponseBody
    public Result<?> deleteCart(@RequestParam Long cartId) {
        boolean success = cartService.deleteCart(cartId);
        if (success) {
            return Result.success("Deleted successfully");
        }
        return Result.error("Delete failed");
    }

    @PostMapping("/deleteSelected")
    @ResponseBody
    public Result<?> deleteSelected(@RequestBody List<Long> cartIds) {
        boolean success = cartService.deleteCartItems(cartIds);
        if (success) {
            return Result.success("Deleted successfully");
        }
        return Result.error("Delete failed");
    }
}
