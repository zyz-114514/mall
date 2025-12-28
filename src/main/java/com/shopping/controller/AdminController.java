package com.shopping.controller;

import com.shopping.entity.Product;
import com.shopping.entity.User;
import com.shopping.service.OrderService;
import com.shopping.service.ProductService;
import com.shopping.service.UserService;
import com.shopping.util.Result;
import com.shopping.vo.OrderVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private ProductService productService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private UserService userService;

    @GetMapping("/index")
    public String adminIndex(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            return "redirect:/user/login";
        }
        return "admin/index";
    }

    @GetMapping("/product/list")
    public String productList(Model model) {
        List<Product> productList = productService.getAllProducts();
        model.addAttribute("productList", productList);
        return "admin/product-list";
    }

    @GetMapping("/product/add")
    public String productAddPage(Model model) {
        model.addAttribute("categories", productService.getAllCategories());
        return "admin/product-add";
    }

    @PostMapping("/product/add")
    @ResponseBody
    public Result<?> addProduct(@RequestBody Product product) {
        boolean success = productService.addProduct(product);
        if (success) {
            return Result.success("添加成功");
        }
        return Result.error("添加失败");
    }

    @GetMapping("/product/edit/{id}")
    public String productEditPage(@PathVariable Long id, Model model) {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        model.addAttribute("categories", productService.getAllCategories());
        return "admin/product-edit";
    }

    @PostMapping("/product/update")
    @ResponseBody
    public Result<?> updateProduct(@RequestBody Product product) {
        boolean success = productService.updateProduct(product);
        if (success) {
            return Result.success("更新成功");
        }
        return Result.error("更新失败");
    }

    @PostMapping("/product/updateStatus")
    @ResponseBody
    public Result<?> updateProductStatus(@RequestParam Long productId,
                                         @RequestParam Integer status) {
        Product product = productService.getProductById(productId);
        if (product == null) {
            return Result.error("商品不存在");
        }
        product.setStatus(status);
        boolean success = productService.updateProduct(product);
        if (success) {
            return Result.success("更新成功");
        }
        return Result.error("更新失败");
    }

    @PostMapping("/product/delete/{id}")
    @ResponseBody
    public Result<?> deleteProduct(@PathVariable Long id) {
        boolean success = productService.deleteProduct(id);
        if (success) {
            return Result.success("删除成功");
        }
        return Result.error("删除失败");
    }

    @GetMapping("/order/list")
    public String orderList(Model model) {
        List<OrderVO> orderList = orderService.getAllOrders();
        model.addAttribute("orderList", orderList);
        return "admin/order-list";
    }

    @PostMapping("/order/updateStatus")
    @ResponseBody
    public Result<?> updateOrderStatus(@RequestParam Long orderId,
                                       @RequestParam Integer status) {
        boolean success = orderService.updateOrderStatus(orderId, status);
        if (success) {
            return Result.success("更新成功");
        }
        return Result.error("更新失败");
    }

    // 用户管理相关接口
    @GetMapping("/user/list")
    public String userList(Model model) {
        List<User> userList = userService.getAllUsers();
        model.addAttribute("userList", userList);
        return "admin/user-list";
    }

    @PostMapping("/user/add")
    @ResponseBody
    public Result<?> addUser(@RequestBody User user) {
        try {
            User newUser = userService.register(user);
            return Result.success("添加成功", newUser);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }

    @GetMapping("/user/get/{id}")
    @ResponseBody
    public Result<User> getUser(@PathVariable Long id) {
        User user = userService.getUserById(id);
        if (user != null) {
            return Result.success(user);
        }
        return Result.error("用户不存在");
    }

    @PostMapping("/user/update")
    @ResponseBody
    public Result<?> updateUser(@RequestBody User user) {
        boolean success = userService.updateUser(user);
        if (success) {
            return Result.success("更新成功");
        }
        return Result.error("更新失败");
    }

    @PostMapping("/user/updateStatus")
    @ResponseBody
    public Result<?> updateUserStatus(@RequestParam Long userId,
                                      @RequestParam Integer status) {
        User user = userService.getUserById(userId);
        if (user == null) {
            return Result.error("用户不存在");
        }
        user.setStatus(status);
        boolean success = userService.updateUser(user);
        if (success) {
            return Result.success("更新成功");
        }
        return Result.error("更新失败");
    }
}
