package com.shopping.service;

import com.shopping.entity.Category;
import com.shopping.entity.Product;
import java.util.List;

public interface ProductService {
    
    List<Product> getAllProducts();
    
    List<Product> getProductsByCategoryId(Long categoryId);
    
    List<Product> searchProducts(String keyword);
    
    Product getProductById(Long id);
    
    List<Category> getAllCategories();
    
    List<Category> getCategoriesByParentId(Long parentId);
    
    boolean addProduct(Product product);
    
    boolean updateProduct(Product product);
    
    boolean deleteProduct(Long id);
}
