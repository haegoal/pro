package com.icia.pro.repository;

import com.icia.pro.dto.ProductDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Map;

@Repository
public class ProductRepository {
    @Autowired
    private SqlSessionTemplate sql;


    public ProductDTO read(Map<String, String> map) {
        return sql.selectOne("Product.read", map);
    }
}
