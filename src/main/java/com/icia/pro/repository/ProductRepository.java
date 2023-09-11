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

    public ProductDTO read(String key, String query) {
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("key", key);
        parameters.put("query", query);
        return sql.selectOne("Prodto.read", parameters);
    }
}
