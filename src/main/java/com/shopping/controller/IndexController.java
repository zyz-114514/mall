package com.shopping.controller;

import com.shopping.entity.Category;
import com.shopping.entity.Product;
import com.shopping.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import java.util.List;

@Controller
public class IndexController {

    @Autowired
    private ProductService productService;

    @GetMapping("/")
    public String index(Model model) {
        List<Product> productList = productService.getAllProducts();
        List<Category> categories = productService.getCategoriesByParentId(0L);
        
        model.addAttribute("productList", productList);
        model.addAttribute("categories", categories);
        
        return "index";
    }
}
