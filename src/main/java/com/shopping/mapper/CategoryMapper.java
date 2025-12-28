package com.shopping.mapper;

import com.shopping.entity.Category;
import java.util.List;

public interface CategoryMapper {
    
    int insert(Category category);
    
    int updateById(Category category);
    
    int deleteById(Long id);
    
    Category selectById(Long id);
    
    List<Category> selectAll();
    
    List<Category> selectByParentId(Long parentId);
}
