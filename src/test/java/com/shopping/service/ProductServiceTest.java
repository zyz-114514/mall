package com.shopping.service;

import com.shopping.entity.Product;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

import static org.junit.Assert.*;

/**
 * Product Service Test Class
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/spring-context.xml"})
@Transactional
public class ProductServiceTest {

    @Autowired
    private ProductService productService;

    private Product testProduct;

    @Before
    public void setUp() {
        testProduct = new Product();
        testProduct.setCategoryId(1L);
        testProduct.setName("Test Product" + System.currentTimeMillis());
        testProduct.setSubtitle("Test Product Subtitle");
        testProduct.setPrice(new BigDecimal("99.99"));
        testProduct.setStock(100);
        testProduct.setStatus(1);
    }

    @Test
    public void testGetAllProducts() {
        List<Product> products = productService.getAllProducts();
        assertNotNull("Product list should not be null", products);
        assertTrue("Should have product data", products.size() > 0);
    }

    @Test
    public void testGetProductById() {
        Product product = productService.getProductById(1L);
        assertNotNull("Should be able to find product", product);
        assertEquals("Product ID should match", Long.valueOf(1L), product.getId());
    }

    @Test
    public void testGetProductsByCategoryId() {
        List<Product> products = productService.getProductsByCategoryId(1L);
        assertNotNull("Category product list should not be null", products);
        for (Product p : products) {
            assertEquals("Product should belong to specified category", Long.valueOf(1L), p.getCategoryId());
        }
    }

    @Test
    public void testSearchProducts() {
        List<Product> products = productService.searchProducts("phone");
        assertNotNull("Search result should not be null", products);
    }

    @Test
    public void testAddProduct() {
        boolean result = productService.addProduct(testProduct);
        assertTrue("Add product should succeed", result);
        assertNotNull("Product ID should be generated", testProduct.getId());
    }

    @Test
    public void testUpdateProduct() {
        productService.addProduct(testProduct);
        
        testProduct.setName("Updated Product Name");
        testProduct.setPrice(new BigDecimal("199.99"));
        
        boolean result = productService.updateProduct(testProduct);
        assertTrue("Update product should succeed", result);
        
        Product updated = productService.getProductById(testProduct.getId());
        assertEquals("Product name should be updated", "Updated Product Name", updated.getName());
        assertEquals("Product price should be updated", new BigDecimal("199.99"), updated.getPrice());
    }

    @Test
    public void testDeleteProduct() {
        productService.addProduct(testProduct);
        Long productId = testProduct.getId();
        
        boolean result = productService.deleteProduct(productId);
        assertTrue("Delete product should succeed", result);
        
        Product deleted = productService.getProductById(productId);
        assertNull("Product should be deleted", deleted);
    }

    @Test
    public void testGetAllCategories() {
        List<com.shopping.entity.Category> categories = productService.getAllCategories();
        assertNotNull("Category list should not be null", categories);
        assertTrue("Should have category data", categories.size() > 0);
    }
}
