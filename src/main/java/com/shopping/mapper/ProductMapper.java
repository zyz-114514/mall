package com.shopping.mapper;

import com.shopping.entity.Product;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface ProductMapper {
    
    int insert(Product product);
    
    int updateById(Product product);
    
    int deleteById(Long id);
    
    Product selectById(Long id);
    
    List<Product> selectAll();
    
    List<Product> selectByCategoryId(Long categoryId);
    
    List<Product> selectByNameLike(@Param("name") String name);
    
    int updateStock(@Param("id") Long id, @Param("quantity") Integer quantity);
}
