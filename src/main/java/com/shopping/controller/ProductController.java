package com.shopping.controller;

import com.shopping.entity.Category;
import com.shopping.entity.Product;
import com.shopping.service.ProductService;
import com.shopping.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    @GetMapping("/list")
    public String productList(@RequestParam(required = false) Long categoryId,
                             @RequestParam(required = false) String keyword,
                             Model model) {
        List<Product> productList;
        if (categoryId != null) {
            productList = productService.getProductsByCategoryId(categoryId);
        } else if (keyword != null && !keyword.trim().isEmpty()) {
            productList = productService.searchProducts(keyword);
        } else {
            productList = productService.getAllProducts();
        }

        List<Category> categories = productService.getAllCategories();
        
        model.addAttribute("productList", productList);
        model.addAttribute("categories", categories);
        model.addAttribute("currentCategoryId", categoryId);
        model.addAttribute("keyword", keyword);
        
        return "product/list";
    }

    @GetMapping("/detail/{id}")
    public String productDetail(@PathVariable Long id, Model model) {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        return "product/detail";
    }

    @GetMapping("/search")
    @ResponseBody
    public Result<List<Product>> searchProducts(@RequestParam String keyword) {
        List<Product> productList = productService.searchProducts(keyword);
        return Result.success(productList);
    }

    @GetMapping("/category/{categoryId}")
    @ResponseBody
    public Result<List<Product>> getProductsByCategory(@PathVariable Long categoryId) {
        List<Product> productList = productService.getProductsByCategoryId(categoryId);
        return Result.success(productList);
    }
}
