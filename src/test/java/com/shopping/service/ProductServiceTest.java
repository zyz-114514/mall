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
 * 商品服务测试类
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
        testProduct.setName("测试商品" + System.currentTimeMillis());
        testProduct.setSubtitle("测试商品副标题");
        testProduct.setPrice(new BigDecimal("99.99"));
        testProduct.setStock(100);
        testProduct.setStatus(1);
    }

    @Test
    public void testGetAllProducts() {
        List<Product> products = productService.getAllProducts();
        assertNotNull("商品列表不应为空", products);
        assertTrue("应该有商品数据", products.size() > 0);
    }

    @Test
    public void testGetProductById() {
        Product product = productService.getProductById(1L);
        assertNotNull("应该能找到商品", product);
        assertEquals("商品ID应该匹配", Long.valueOf(1L), product.getId());
    }

    @Test
    public void testGetProductsByCategoryId() {
        List<Product> products = productService.getProductsByCategoryId(1L);
        assertNotNull("分类商品列表不应为空", products);
        for (Product p : products) {
            assertEquals("商品应该属于指定分类", Long.valueOf(1L), p.getCategoryId());
        }
    }

    @Test
    public void testSearchProducts() {
        List<Product> products = productService.searchProducts("手机");
        assertNotNull("搜索结果不应为空", products);
    }

    @Test
    public void testAddProduct() {
        boolean result = productService.addProduct(testProduct);
        assertTrue("添加商品应该成功", result);
        assertNotNull("商品ID应该被生成", testProduct.getId());
    }

    @Test
    public void testUpdateProduct() {
        productService.addProduct(testProduct);
        
        testProduct.setName("更新后的商品名称");
        testProduct.setPrice(new BigDecimal("199.99"));
        
        boolean result = productService.updateProduct(testProduct);
        assertTrue("更新商品应该成功", result);
        
        Product updated = productService.getProductById(testProduct.getId());
        assertEquals("商品名称应该已更新", "更新后的商品名称", updated.getName());
        assertEquals("商品价格应该已更新", new BigDecimal("199.99"), updated.getPrice());
    }

    @Test
    public void testDeleteProduct() {
        productService.addProduct(testProduct);
        Long productId = testProduct.getId();
        
        boolean result = productService.deleteProduct(productId);
        assertTrue("删除商品应该成功", result);
        
        Product deleted = productService.getProductById(productId);
        assertNull("商品应该已被删除", deleted);
    }

    @Test
    public void testGetAllCategories() {
        List<com.shopping.entity.Category> categories = productService.getAllCategories();
        assertNotNull("分类列表不应为空", categories);
        assertTrue("应该有分类数据", categories.size() > 0);
    }
}
