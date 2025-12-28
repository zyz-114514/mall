package com.shopping.service.impl;

import com.shopping.entity.Category;
import com.shopping.entity.Product;
import com.shopping.exception.BusinessException;
import com.shopping.mapper.CategoryMapper;
import com.shopping.mapper.ProductMapper;
import com.shopping.service.ProductService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {

    private static final Logger logger = LoggerFactory.getLogger(ProductServiceImpl.class);

    @Autowired
    private ProductMapper productMapper;

    @Autowired
    private CategoryMapper categoryMapper;

    @Override
    public List<Product> getAllProducts() {
        return productMapper.selectAll();
    }

    @Override
    public List<Product> getProductsByCategoryId(Long categoryId) {
        if (categoryId == null) {
            throw new BusinessException("分类ID不能为空");
        }
        return productMapper.selectByCategoryId(categoryId);
    }

    @Override
    public List<Product> searchProducts(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllProducts();
        }
        return productMapper.selectByNameLike(keyword.trim());
    }

    @Override
    public Product getProductById(Long id) {
        if (id == null) {
            throw new BusinessException("商品ID不能为空");
        }
        Product product = productMapper.selectById(id);
        if (product == null) {
            throw new BusinessException("商品不存在");
        }
        return product;
    }

    @Override
    public List<Category> getAllCategories() {
        return categoryMapper.selectAll();
    }

    @Override
    public List<Category> getCategoriesByParentId(Long parentId) {
        if (parentId == null) {
            parentId = 0L;
        }
        return categoryMapper.selectByParentId(parentId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addProduct(Product product) {
        if (product == null) {
            throw new BusinessException("商品信息不能为空");
        }
        if (product.getName() == null || product.getPrice() == null) {
            throw new BusinessException("商品名称和价格不能为空");
        }

        if (product.getStatus() == null) {
            product.setStatus(1);
        }
        if (product.getStock() == null) {
            product.setStock(0);
        }

        int result = productMapper.insert(product);
        if (result > 0) {
            logger.info("添加商品成功: {}", product.getName());
            return true;
        }
        return false;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateProduct(Product product) {
        if (product == null || product.getId() == null) {
            throw new BusinessException("商品信息不完整");
        }

        int result = productMapper.updateById(product);
        if (result > 0) {
            logger.info("更新商品成功: {}", product.getId());
            return true;
        }
        return false;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteProduct(Long id) {
        if (id == null) {
            throw new BusinessException("商品ID不能为空");
        }

        int result = productMapper.deleteById(id);
        if (result > 0) {
            logger.info("删除商品成功: {}", id);
            return true;
        }
        return false;
    }
}
